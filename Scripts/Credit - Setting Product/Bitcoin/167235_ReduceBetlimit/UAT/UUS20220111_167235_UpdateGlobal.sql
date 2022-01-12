/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220112
	Task: Bitcoin - Reduce bet limit setting UUS [Redmine: 167235]
	DB: DBCust/CustDB
*/
USE CustDB
GO

DECLARE @betType SMALLINT,@sportType SMALLINT

SELECT @sportType = 175
	 , @betType = 7901 	
--============================Bet Setting

CREATE TABLE #ProductBetSetting (Currency INT,MinBet	money,MaxBet	money,MaxPerMatch	money,
								DefaultMinBet	money,DefaultMaxBet	money,DefaultMaxPerMatch	money)
				
INSERT INTO #ProductBetSetting(Currency,MinBet,MaxBet,MaxPerMatch,DefaultMinBet,DefaultMaxBet,DefaultMaxPerMatch)
SELECT 20 AS Currency ,3 AS MinBet,600 AS MaxBet,1800 AS MaxPerMatch,3 AS DefaultMinBet,600 AS DefaultMaxBet,1800  Union ALL --UUS
SELECT 72 AS Currency ,50 AS MinBet,10000 AS MaxBet,30000 AS MaxPerMatch,50 AS DefaultMinBet,10000 AS DefaultMaxBet,30000	 --YNG


UPDATE cs
SET cs.MaxBet = ci.MaxBet,
	cs.MaxPerMatch =ci.MaxPerMatch,
	cs.DefaultMaxBet =ci.DefaultMaxBet,
	cs.DefaultMaxPerMatch =ci.DefaultMaxPerMatch
FROM dbo.ProductBetSetting cs WITH(UPDLOCK,ROWLOCK)
INNER JOIN #ProductBetSetting ci ON cs.Currency = ci.Currency AND Cs.Sporttype = @sportType  AND cs.Bettype = @betType

DROP Table #ProductBetSetting

