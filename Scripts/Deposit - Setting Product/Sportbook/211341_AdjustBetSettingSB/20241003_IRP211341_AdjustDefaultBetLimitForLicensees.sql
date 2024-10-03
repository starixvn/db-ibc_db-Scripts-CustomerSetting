/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20241003@Johnson
	Task: Deposit - Adjust Sportsbook minbet of some currencies for all active licensees [RedmineID:#211341]
	DB: DBCUST/CustDB
*/

DECLARE @tmpSetting TABLE (code VARCHAR(3), MinBet MONEY, MBParlay MONEY)
DECLARE @tmpMinBet MONEY

INSERT INTO @tmpSetting(code,MinBet,MBParlay)
SELECT 'CNY',    10, 3
UNION ALL SELECT 'IDR',    8, 7
UNION ALL SELECT 'VND',    30, 10
UNION ALL SELECT 'MYR',    10, 2
UNION ALL SELECT 'THB',    50, 15
UNION ALL SELECT 'INR',    100, 40
UNION ALL SELECT 'BDT',    150, 60
UNION ALL SELECT 'PKR',    350, 130
UNION ALL SELECT 'BRL',    6, 3

--459 rows affected
UPDATE cs
SET @tmpMinBet = CASE WHEN cs.Bettype <> 9 THEN tmp.MinBet ELSE ISNULL(tmp.MBParlay,cs.MinBet) END,
	cs.MinBet = @tmpMinBet,
	cs.MaxBet = CASE WHEN cs.MaxBet < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxBet END,
	cs.MaxPerMatch = CASE WHEN cs.MaxPerMatch < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxPerMatch END,
	cs.MaxPayOutPerMatch = CASE WHEN cs.MaxPayOutPerMatch < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxPayOutPerMatch END,
	RepUpdateTime = dbo.f_GetDateTime2()
FROM Dep_CustBetLimit_Special cs WITH(UPDLOCK)
	CROSS APPLY (SELECT ExchangeId, t.MinBet, t.MBParlay 
				FROM exchange e WITH(NOLOCK)
					INNER JOIN  @tmpSetting t ON e.Code = t.code
				WHERE cs.CurrencyID= e.ExchangeId				
	)tmp
WHERE Site in (SELECT LicenseeName 
				FROM bodb_Licensee.dbo.Licensees WITH(NOLOCK)
				WHERE IsActive = 1)
	AND cs.SportType in (1,2,3,5,8,10,11,43,50,99,9901,9902,9907)
	AND cs.MinBet NOT IN (0, 0.1) AND MaxBet NOT IN (0, 0.1) AND MaxPerMatch NOT IN (0, 0.1) AND MaxPayOutPerMatch NOT IN (0, 0.1)
	AND cs.MinBet < CASE WHEN cs.Bettype <> 9 THEN tmp.MinBet ELSE ISNULL(tmp.MBParlay,cs.MinBet) END	
	
--remove data for agent GMASTERRMB01
--12 rows affected
DELETE Dep_CustBetSettingGame_Member 
OUTPUT DELETED.custid, DELETED.sporttype, DELETED.bettype, dbo.f_GetDateTime2()
INTO Dep_CustBetSettingGame_Member_Del_Inhouse(custid,sporttype,bettype,RepUpdateTime)
WHERE CustID = 28627544
	