/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20211117
	Task: Bitcoin - Reduce bet limit setting by 50 [Redmine: 164702]
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
SELECT 2 AS Currency ,5 AS MinBet,2500 AS MaxBet,15000 AS MaxPerMatch,5 AS DefaultMinBet,2500 AS DefaultMaxBet,15000  AS DefaultMaxPerMatch Union ALL --RM
SELECT 3 AS Currency ,3 AS MinBet,750 AS MaxBet,4500 AS MaxPerMatch,3 AS DefaultMinBet,750 AS DefaultMaxBet,4500  AS DefaultMaxPerMatch Union ALL --US$
SELECT 5 AS Currency ,10 AS MinBet,5000 AS MaxBet,30000 AS MaxPerMatch,10 AS DefaultMinBet,5000 AS DefaultMaxBet,30000  AS DefaultMaxPerMatch Union ALL --HK$
SELECT 6 AS Currency ,2 AS MinBet,500 AS MaxBet,3000 AS MaxPerMatch,2 AS DefaultMinBet,500 AS DefaultMaxBet,3000  AS DefaultMaxPerMatch Union ALL --EURO
SELECT 7 AS Currency ,25000 AS MinBet,12500000 AS MaxBet,75000000 AS MaxPerMatch,25000 AS DefaultMinBet,12500000 AS DefaultMaxBet,75000000  AS DefaultMaxPerMatch Union ALL --DON
SELECT 9 AS Currency ,3 AS MinBet,750 AS MaxBet,4500 AS MaxPerMatch,3 AS DefaultMinBet,750 AS DefaultMaxBet,4500  AS DefaultMaxPerMatch Union ALL --AUD
SELECT 12 AS Currency ,2 AS MinBet,500 AS MaxBet,3000 AS MaxPerMatch,2 AS DefaultMinBet,500 AS DefaultMaxBet,3000  AS DefaultMaxPerMatch Union ALL --GBP
SELECT 13 AS Currency ,10 AS MinBet,5000 AS MaxBet,30000 AS MaxPerMatch,10 AS DefaultMinBet,5000 AS DefaultMaxBet,30000  AS DefaultMaxPerMatch Union ALL --RMB
SELECT 15 AS Currency ,25 AS MinBet,10000 AS MaxBet,60000 AS MaxPerMatch,25 AS DefaultMinBet,10000 AS DefaultMaxBet,60000  AS DefaultMaxPerMatch Union ALL --IN
SELECT 16 AS Currency ,3 AS MinBet,750 AS MaxBet,4500 AS MaxPerMatch,3 AS DefaultMinBet,750 AS DefaultMaxBet,4500  AS DefaultMaxPerMatch Union ALL --Yen
SELECT 22 AS Currency ,25 AS MinBet,10000 AS MaxBet,60000 AS MaxPerMatch,25 AS DefaultMinBet,10000 AS DefaultMaxBet,60000  AS DefaultMaxPerMatch Union ALL --IND
SELECT 33 AS Currency ,25 AS MinBet,10000 AS MaxBet,60000 AS MaxPerMatch,25 AS DefaultMinBet,10000 AS DefaultMaxBet,60000  AS DefaultMaxPerMatch Union ALL --IDD
SELECT 34 AS Currency ,25 AS MinBet,10000 AS MaxBet,60000 AS MaxPerMatch,25 AS DefaultMinBet,10000 AS DefaultMaxBet,60000  AS DefaultMaxPerMatch Union ALL --IDR
SELECT 35 AS Currency ,3 AS MinBet,750 AS MaxBet,4500 AS MaxPerMatch,3 AS DefaultMinBet,750 AS DefaultMaxBet,4500  AS DefaultMaxPerMatch Union ALL --$US
SELECT 41 AS Currency ,2 AS MinBet,500 AS MaxBet,3000 AS MaxPerMatch,2 AS DefaultMinBet,500 AS DefaultMaxBet,3000  AS DefaultMaxPerMatch Union ALL --CHF
SELECT 42 AS Currency ,120 AS MinBet,30000 AS MaxBet,180000 AS MaxPerMatch,120 AS DefaultMinBet,30000 AS DefaultMaxBet,180000  AS DefaultMaxPerMatch Union ALL --PE
SELECT 43 AS Currency ,100 AS MinBet,20000 AS MaxBet,120000 AS MaxPerMatch,100 AS DefaultMinBet,20000 AS DefaultMaxBet,120000  AS DefaultMaxPerMatch Union ALL --THB
SELECT 45 AS Currency ,2500 AS MinBet,750000 AS MaxBet,4500000 AS MaxPerMatch,2500 AS DefaultMinBet,750000 AS DefaultMaxBet,4500000  AS DefaultMaxPerMatch Union ALL --Won
SELECT 47 AS Currency ,25 AS MinBet,10000 AS MaxBet,60000 AS MaxPerMatch,25 AS DefaultMinBet,10000 AS DefaultMaxBet,60000  AS DefaultMaxPerMatch Union ALL --DDD
SELECT 50 AS Currency ,3 AS MinBet,750 AS MaxBet,4500 AS MaxPerMatch,3 AS DefaultMinBet,750 AS DefaultMaxBet,4500  AS DefaultMaxPerMatch Union ALL --CAN
SELECT 51 AS Currency ,25 AS MinBet,12500 AS MaxBet,75000 AS MaxPerMatch,25 AS DefaultMinBet,12500 AS DefaultMaxBet,75000  AS DefaultMaxPerMatch Union ALL --INH
SELECT 52 AS Currency ,15 AS MinBet,5000 AS MaxBet,30000 AS MaxPerMatch,15 AS DefaultMinBet,5000 AS DefaultMaxBet,30000  AS DefaultMaxPerMatch Union ALL --DKK
SELECT 53 AS Currency ,15 AS MinBet,5000 AS MaxBet,30000 AS MaxPerMatch,15 AS DefaultMinBet,5000 AS DefaultMaxBet,30000  AS DefaultMaxPerMatch Union ALL --SEK
SELECT 54 AS Currency ,15 AS MinBet,5000 AS MaxBet,30000 AS MaxPerMatch,15 AS DefaultMinBet,5000 AS DefaultMaxBet,30000  AS DefaultMaxPerMatch Union ALL --NOK
SELECT 57 AS Currency ,50 AS MinBet,12500 AS MaxBet,75000 AS MaxPerMatch,50 AS DefaultMinBet,12500 AS DefaultMaxBet,75000  AS DefaultMaxPerMatch Union ALL --CZK
SELECT 58 AS Currency ,10 AS MinBet,2500 AS MaxBet,15000 AS MaxPerMatch,10 AS DefaultMinBet,2500 AS DefaultMaxBet,15000  AS DefaultMaxPerMatch Union ALL --RON
SELECT 64 AS Currency ,3 AS MinBet,750 AS MaxBet,4500 AS MaxPerMatch,3 AS DefaultMinBet,750 AS DefaultMaxBet,4500  AS DefaultMaxPerMatch Union ALL --UT
SELECT 67 AS Currency ,5 AS MinBet,2500 AS MaxBet,15000 AS MaxPerMatch,5 AS DefaultMinBet,2500 AS DefaultMaxBet,15000  AS DefaultMaxPerMatch Union ALL --HKK
SELECT 69 AS Currency ,4 AS MinBet,900 AS MaxBet,5400 AS MaxPerMatch,4 AS DefaultMinBet,900 AS DefaultMaxBet,5400  AS DefaultMaxPerMatch Union ALL --MMK
SELECT 71 AS Currency ,10 AS MinBet,2500 AS MaxBet,15000 AS MaxPerMatch,10 AS DefaultMinBet,2500 AS DefaultMaxBet,15000  AS DefaultMaxPerMatch Union ALL --KHR
SELECT 81 AS Currency ,10 AS MinBet,5000 AS MaxBet,30000 AS MaxPerMatch,10 AS DefaultMinBet,5000 AS DefaultMaxBet,30000  AS DefaultMaxPerMatch Union ALL --CY
SELECT 95 AS Currency ,3 AS MinBet,750 AS MaxBet,4500 AS MaxPerMatch,3 AS DefaultMinBet,750 AS DefaultMaxBet,4500  AS DefaultMaxPerMatch Union ALL --USD
SELECT 20 AS Currency ,3 AS MinBet,1500 AS MaxBet,9000 AS MaxPerMatch,3 AS DefaultMinBet,1500 AS DefaultMaxBet,9000  AS DefaultMaxPerMatch Union ALL --UUS
SELECT 72 AS Currency ,50 AS MinBet,25000 AS MaxBet,150000 AS MaxPerMatch,50 AS DefaultMinBet,25000 AS DefaultMaxBet,150000  AS DefaultMaxPerMatch		 --YNG

UPDATE cs
SET cs.MaxBet = ci.MaxBet,
	cs.MaxPerMatch =ci.MaxPerMatch,
	cs.DefaultMaxBet =ci.DefaultMaxBet,
	cs.DefaultMaxPerMatch =ci.DefaultMaxPerMatch
FROM dbo.ProductBetSetting cs WITH(UPDLOCK,ROWLOCK)
INNER JOIN #ProductBetSetting ci ON cs.Currency = ci.Currency AND Cs.Sporttype = @sportType  AND cs.Bettype = @betType

DROP Table #ProductBetSetting

