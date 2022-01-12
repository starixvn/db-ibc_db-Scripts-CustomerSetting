/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220112
	Task: Bitcoin - Reduce bet limit setting [Redmine: 167235]
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
SELECT 2 AS Currency ,5 AS MinBet,1000 AS MaxBet,3000 AS MaxPerMatch,5 AS DefaultMinBet,1000 AS DefaultMaxBet,3000  Union ALL --RM
SELECT 3 AS Currency ,3 AS MinBet,300 AS MaxBet,900 AS MaxPerMatch,3 AS DefaultMinBet,300 AS DefaultMaxBet,900  Union ALL --US$
SELECT 5 AS Currency ,10 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,10 AS DefaultMinBet,2000 AS DefaultMaxBet,6000  Union ALL --HK$
SELECT 6 AS Currency ,2 AS MinBet,200 AS MaxBet,600 AS MaxPerMatch,2 AS DefaultMinBet,200 AS DefaultMaxBet,600  Union ALL --EURO
SELECT 7 AS Currency ,25000 AS MinBet,5000000 AS MaxBet,15000000 AS MaxPerMatch,25000 AS DefaultMinBet,5000000 AS DefaultMaxBet,15000000  Union ALL --DON
SELECT 9 AS Currency ,3 AS MinBet,300 AS MaxBet,900 AS MaxPerMatch,3 AS DefaultMinBet,300 AS DefaultMaxBet,900  Union ALL --AUD
SELECT 12 AS Currency ,2 AS MinBet,200 AS MaxBet,600 AS MaxPerMatch,2 AS DefaultMinBet,200 AS DefaultMaxBet,600  Union ALL --GBP
SELECT 13 AS Currency ,10 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,10 AS DefaultMinBet,2000 AS DefaultMaxBet,6000  Union ALL --RMB
SELECT 15 AS Currency ,25 AS MinBet,4000 AS MaxBet,12000 AS MaxPerMatch,25 AS DefaultMinBet,4000 AS DefaultMaxBet,12000  Union ALL --IN
SELECT 16 AS Currency ,3 AS MinBet,300 AS MaxBet,900 AS MaxPerMatch,3 AS DefaultMinBet,300 AS DefaultMaxBet,900  Union ALL --Yen
SELECT 22 AS Currency ,25 AS MinBet,4000 AS MaxBet,12000 AS MaxPerMatch,25 AS DefaultMinBet,4000 AS DefaultMaxBet,12000  Union ALL --IND
SELECT 33 AS Currency ,25 AS MinBet,4000 AS MaxBet,12000 AS MaxPerMatch,25 AS DefaultMinBet,4000 AS DefaultMaxBet,12000  Union ALL --IDD
SELECT 34 AS Currency ,25 AS MinBet,4000 AS MaxBet,12000 AS MaxPerMatch,25 AS DefaultMinBet,4000 AS DefaultMaxBet,12000  Union ALL --IDR
SELECT 35 AS Currency ,3 AS MinBet,300 AS MaxBet,900 AS MaxPerMatch,3 AS DefaultMinBet,300 AS DefaultMaxBet,900  Union ALL --$US
SELECT 41 AS Currency ,2 AS MinBet,200 AS MaxBet,600 AS MaxPerMatch,2 AS DefaultMinBet,200 AS DefaultMaxBet,600  Union ALL --CHF
SELECT 42 AS Currency ,120 AS MinBet,12000 AS MaxBet,36000 AS MaxPerMatch,120 AS DefaultMinBet,12000 AS DefaultMaxBet,36000  Union ALL --PE
SELECT 43 AS Currency ,100 AS MinBet,8000 AS MaxBet,24000 AS MaxPerMatch,100 AS DefaultMinBet,8000 AS DefaultMaxBet,24000  Union ALL --THB
SELECT 45 AS Currency ,2500 AS MinBet,300000 AS MaxBet,900000 AS MaxPerMatch,2500 AS DefaultMinBet,300000 AS DefaultMaxBet,900000  Union ALL --Won
SELECT 47 AS Currency ,25 AS MinBet,4000 AS MaxBet,12000 AS MaxPerMatch,25 AS DefaultMinBet,4000 AS DefaultMaxBet,12000  Union ALL --DDD
SELECT 50 AS Currency ,3 AS MinBet,300 AS MaxBet,900 AS MaxPerMatch,3 AS DefaultMinBet,300 AS DefaultMaxBet,900  Union ALL --CAN
SELECT 51 AS Currency ,25 AS MinBet,5000 AS MaxBet,15000 AS MaxPerMatch,25 AS DefaultMinBet,5000 AS DefaultMaxBet,15000  Union ALL --INH
SELECT 52 AS Currency ,15 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,15 AS DefaultMinBet,2000 AS DefaultMaxBet,6000  Union ALL --DKK
SELECT 53 AS Currency ,15 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,15 AS DefaultMinBet,2000 AS DefaultMaxBet,6000  Union ALL --SEK
SELECT 54 AS Currency ,15 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,15 AS DefaultMinBet,2000 AS DefaultMaxBet,6000  Union ALL --NOK
SELECT 57 AS Currency ,50 AS MinBet,5000 AS MaxBet,15000 AS MaxPerMatch,50 AS DefaultMinBet,5000 AS DefaultMaxBet,15000  Union ALL --CZK
SELECT 58 AS Currency ,10 AS MinBet,1000 AS MaxBet,3000 AS MaxPerMatch,10 AS DefaultMinBet,1000 AS DefaultMaxBet,3000  Union ALL --RON
SELECT 64 AS Currency ,3 AS MinBet,300 AS MaxBet,900 AS MaxPerMatch,3 AS DefaultMinBet,300 AS DefaultMaxBet,900  Union ALL --UT
SELECT 67 AS Currency ,5 AS MinBet,1000 AS MaxBet,3000 AS MaxPerMatch,5 AS DefaultMinBet,1000 AS DefaultMaxBet,3000  Union ALL --HKK
SELECT 69 AS Currency ,4 AS MinBet,360 AS MaxBet,1080 AS MaxPerMatch,4 AS DefaultMinBet,360 AS DefaultMaxBet,1080  Union ALL --MMK
SELECT 71 AS Currency ,10 AS MinBet,1000 AS MaxBet,3000 AS MaxPerMatch,10 AS DefaultMinBet,1000 AS DefaultMaxBet,3000  Union ALL --KHR
SELECT 81 AS Currency ,10 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,10 AS DefaultMinBet,2000 AS DefaultMaxBet,6000  Union ALL --CY
SELECT 95 AS Currency ,3 AS MinBet,300 AS MaxBet,900 AS MaxPerMatch,3 AS DefaultMinBet,300 AS DefaultMaxBet,900			 --USD


UPDATE cs
SET cs.MaxBet = ci.MaxBet,
	cs.MaxPerMatch =ci.MaxPerMatch,
	cs.DefaultMaxBet =ci.DefaultMaxBet,
	cs.DefaultMaxPerMatch =ci.DefaultMaxPerMatch
FROM dbo.ProductBetSetting cs WITH(UPDLOCK,ROWLOCK)
INNER JOIN #ProductBetSetting ci ON cs.Currency = ci.Currency AND Cs.Sporttype = @sportType  AND cs.Bettype = @betType

DROP Table #ProductBetSetting

