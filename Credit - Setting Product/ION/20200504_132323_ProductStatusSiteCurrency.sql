/*
	Created: 20200504@Eden
	Task: Update ProductStatusSiteCurrency for ION [Redmine: 132323]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype INT, @Bettype INT
SELECT @Sporttype = 225, @Bettype = 5601

DELETE FROM ProductStatusSiteCurrency WHERE SportType=@Sporttype

CREATE TABLE #NonOfferedCurency (Currency INT) 

INSERT INTO #NonOfferedCurency (Currency)
SELECT exchangeid 
FROM exchange WITH(NOLOCK) 
WHERE exchangeid NOT IN (15 --IN
						,22 --IND
						,33 --IDD
						,34 --IDR
						,47 --DDD
						,45 --Won
						,2 --RM
						,5 --HK$
						,13 --RMB
						,67 --HKK
						,81 --CY
						,43 --THB
						,3 --US$
						,6 --EURO
						,12 --GBP
						,16 --Yen
						,35 --$US
						,64 --UT
						--,69 --MMK
						,20,72 --test
				) --supported currencies


INSERT INTO ProductStatusSiteCurrency (SportType, BetType, SiteID, Currency, IsHidden, IsDisabled, HasSynced)
SELECT DISTINCT @Sporttype, @Bettype, 0, Currency, 1, 1, 1  
FROM #NonOfferedCurency WITH (NOLOCK)

DROP TABLE #NonOfferedCurency





