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

CREATE TABLE #Dep_ProductBetSetting (Currency INT,MinBet MONEY,MaxBet MONEY,MaxPerMatch	MONEY,IsMinBet BIT)
				
INSERT INTO #Dep_ProductBetSetting(Currency,MinBet,MaxBet,MaxPerMatch,IsMinBet)
SELECT 2  AS Currency ,5 AS MinBet,500 AS MaxBet,500 AS MaxPerMatch, 0 As IsUpdMinBet		UNION ALL   -- RM
SELECT 4  AS Currency ,50 AS MinBet,5000 AS MaxBet,5000 AS MaxPerMatch, 1 As IsUpdMinBet	UNION ALL   -- TB
SELECT 5  AS Currency ,10 AS MinBet,1000 AS MaxBet,1000 AS MaxPerMatch, 0 As IsUpdMinBet	UNION ALL   -- HK$
SELECT 13 AS Currency ,10 AS MinBet,1000 AS MaxBet,1000 AS MaxPerMatch, 0 As IsUpdMinBet	UNION ALL   -- RMB
SELECT 15 AS Currency ,10 AS MinBet,2500 AS MaxBet,2500 AS MaxPerMatch, 0 As IsUpdMinBet	UNION ALL   -- IN
SELECT 51 AS Currency ,25 AS MinBet,5000 AS MaxBet,5000 AS MaxPerMatch, 0 As IsUpdMinBet	UNION ALL   -- INH
SELECT 61 AS Currency ,50 AS MinBet,15000 AS MaxBet,15000 AS MaxPerMatch, 1 As IsUpdMinBet	UNION ALL   -- INR
SELECT 66 AS Currency ,10 AS MinBet,1000 AS MaxBet,1000 AS MaxPerMatch, 0 As IsUpdMinBet				-- YUN


UPDATE cs
SET cs.MinBet = CASE WHEN ci.IsMinBet = 1 THEN ci.MinBet ELSE cs.MinBet END,
	cs.MaxBet = ci.MaxBet,
	cs.MaxPerMatch =ci.MaxPerMatch
FROM dbo.Dep_ProductBetSetting cs WITH(UPDLOCK,ROWLOCK)
INNER JOIN #Dep_ProductBetSetting ci ON cs.Currency = ci.Currency AND Cs.Sporttype = @sportType  AND cs.Bettype = @betType

DROP Table #Dep_ProductBetSetting

