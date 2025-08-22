/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250821@Tacy
	Task: Deposit - Adjust Sportsbook minbet for TGXISW [RedmineID:#236681]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @tmpSetting TABLE (code VARCHAR(3), MinBet MONEY)

INSERT INTO @tmpSetting(code,MinBet)
SELECT 'PHP', 10

UPDATE cs
SET cs.MinBet = tmp.MinBet,
	RepUpdateTime = dbo.f_GetDateTime2()
FROM Dep_CustBetLimit_Special cs WITH(UPDLOCK)
	CROSS APPLY (SELECT ExchangeId, t.MinBet 
				FROM exchange e WITH(NOLOCK)
					INNER JOIN  @tmpSetting t ON e.Code = t.code
				WHERE cs.CurrencyID= e.ExchangeId				
	)tmp
WHERE Site in ('TGXISW')
	AND cs.SportType in (1,2,3,5,8,10,11,43,50,99,9901,9902,9907)
	AND cs.MinBet NOT IN (0, 0.1) AND MaxBet NOT IN (0, 0.1) AND MaxPerMatch NOT IN (0, 0.1) AND MaxPayOutPerMatch NOT IN (0, 0.1)
GO	