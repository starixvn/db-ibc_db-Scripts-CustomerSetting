/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250520@Tacy
	Task: Deposit - Adjust Sportsbook minbet of IDR currency for all active licensees [RedmineID:#227852]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @tmpMinBet MONEY
DECLARE @tmpSetting TABLE (code VARCHAR(3), MBParlay MONEY)

INSERT INTO @tmpSetting(code,MBParlay)
SELECT 'IDR', 5

-- 15 rows affected
UPDATE cs
SET @tmpMinBet = ISNULL(tmp.MBParlay,cs.MinBet),
	cs.MinBet = @tmpMinBet,
	cs.MaxBet = CASE WHEN cs.MaxBet < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxBet END,
	cs.MaxPerMatch = CASE WHEN cs.MaxPerMatch < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxPerMatch END,
	cs.MaxPayOutPerMatch = CASE WHEN cs.MaxPayOutPerMatch < @tmpMinBet THEN @tmpMinBet ELSE cs.MaxPayOutPerMatch END,
	RepUpdateTime = dbo.f_GetDateTime2()
FROM Dep_CustBetLimit_Special cs WITH(UPDLOCK)
	CROSS APPLY (SELECT ExchangeId, t.MBParlay 
				FROM exchange e WITH(NOLOCK)
					INNER JOIN  @tmpSetting t ON e.Code = t.code
				WHERE cs.CurrencyID= e.ExchangeId				
	)tmp
WHERE Site in (SELECT LicenseeName 
				FROM bodb_Licensee.dbo.Licensees WITH(NOLOCK)
				WHERE IsActive = 1)
	AND cs.SportType in (1,2,3,5,8,10,11,43,50,99,9901,9902,9907) AND cs.Bettype=9
	AND cs.MinBet NOT IN (0, 0.1) AND MaxBet NOT IN (0, 0.1) AND MaxPerMatch NOT IN (0, 0.1) AND MaxPayOutPerMatch NOT IN (0, 0.1)
	AND cs.MinBet > ISNULL(tmp.MBParlay,cs.MinBet)	
	