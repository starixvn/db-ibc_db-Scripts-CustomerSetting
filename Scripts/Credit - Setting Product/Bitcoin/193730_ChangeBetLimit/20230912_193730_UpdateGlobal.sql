/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20230910
	Task: Bitcoin - Change Bet Limit [Redmine: 193730]
	DB: DBCust/CustDB
*/
USE CustDB
GO

DECLARE @betType SMALLINT,@sportType SMALLINT

SELECT @sportType = 175 , @betType = 7901 	
--============================Bet Setting

CREATE TABLE #ProductBetSetting (Currency INT,MinBet MONEY,MaxBet MONEY,MaxPerMatch	MONEY,
								DefaultMinBet MONEY,DefaultMaxBet MONEY,DefaultMaxPerMatch MONEY, IsUpdMinBet BIT)
				
INSERT INTO #ProductBetSetting(Currency,MinBet,MaxBet,MaxPerMatch,DefaultMinBet,DefaultMaxBet,DefaultMaxPerMatch,IsUpdMinBet)
SELECT 2 AS Currency ,5 AS MinBet,500 AS MaxBet,500 AS MaxPerMatch,5 AS DefaultMinBet,500 AS DefaultMaxBet,500  AS DefaultMaxPerMatch, 0 As IsUpdMinBet UNION ALL   -- RM
SELECT 5 AS Currency ,10 AS MinBet,1000 AS MaxBet,1000 AS MaxPerMatch,10 AS DefaultMinBet,1000 AS DefaultMaxBet,1000  AS DefaultMaxPerMatch, 0 As IsUpdMinBet UNION ALL   -- HK$
SELECT 13 AS Currency ,10 AS MinBet,1000 AS MaxBet,1000 AS MaxPerMatch,10 AS DefaultMinBet,1000 AS DefaultMaxBet,1000  AS DefaultMaxPerMatch, 0 As IsUpdMinBet UNION ALL   -- RMB
SELECT 15 AS Currency ,10 AS MinBet,2500 AS MaxBet,2500 AS MaxPerMatch,10 AS DefaultMinBet,2500 AS DefaultMaxBet,2500  AS DefaultMaxPerMatch, 0 As IsUpdMinBet UNION ALL   -- IN
SELECT 22 AS Currency ,25 AS MinBet,2500 AS MaxBet,2500 AS MaxPerMatch,10 AS DefaultMinBet,2500 AS DefaultMaxBet,2500  AS DefaultMaxPerMatch, 0 As IsUpdMinBet UNION ALL   -- IND
SELECT 33 AS Currency ,25 AS MinBet,2500 AS MaxBet,2500 AS MaxPerMatch,10 AS DefaultMinBet,2500 AS DefaultMaxBet,2500  AS DefaultMaxPerMatch, 0 As IsUpdMinBet UNION ALL   -- IDD
SELECT 34 AS Currency ,25 AS MinBet,2500 AS MaxBet,2500 AS MaxPerMatch,10 AS DefaultMinBet,2500 AS DefaultMaxBet,2500  AS DefaultMaxPerMatch, 0 As IsUpdMinBet UNION ALL   -- IDR
SELECT 43 AS Currency ,50 AS MinBet,5000 AS MaxBet,5000 AS MaxPerMatch,50 AS DefaultMinBet,5000 AS DefaultMaxBet,5000  AS DefaultMaxPerMatch, 1 As IsUpdMinBet UNION ALL   -- THB
SELECT 47 AS Currency ,25 AS MinBet,2500 AS MaxBet,2500 AS MaxPerMatch,25 AS DefaultMinBet,2500 AS DefaultMaxBet,2500  AS DefaultMaxPerMatch, 0 As IsUpdMinBet UNION ALL   -- DDD
SELECT 51 AS Currency ,25 AS MinBet,5000 AS MaxBet,5000 AS MaxPerMatch,25 AS DefaultMinBet,5000 AS DefaultMaxBet,5000  AS DefaultMaxPerMatch, 0 As IsUpdMinBet UNION ALL   -- INH
SELECT 67 AS Currency ,5 AS MinBet,500 AS MaxBet,500 AS MaxPerMatch,5 AS DefaultMinBet,500 AS DefaultMaxBet,500  AS DefaultMaxPerMatch, 0 As IsUpdMinBet    -- HKK


UPDATE cs
SET cs.MinBet = CASE WHEN ci.IsUpdMinBet = 1 THEN ci.MinBet ELSE cs.MinBet END,
	cs.DefaultMinBet = CASE WHEN ci.IsUpdMinBet = 1 THEN ci.DefaultMinBet ELSE cs.DefaultMinBet END,
	cs.MaxBet = ci.MaxBet,
	cs.MaxPerMatch =ci.MaxPerMatch,
	cs.DefaultMaxBet =ci.DefaultMaxBet,
	cs.DefaultMaxPerMatch =ci.DefaultMaxPerMatch
FROM dbo.ProductBetSetting cs WITH(UPDLOCK,ROWLOCK)
INNER JOIN #ProductBetSetting ci ON cs.Currency = ci.Currency AND Cs.Sporttype = @sportType  AND cs.Bettype = @betType

DROP Table #ProductBetSetting

