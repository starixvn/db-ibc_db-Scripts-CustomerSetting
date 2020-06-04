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
WHERE exchangeid NOT IN (12 --GBP
						,13 --RMB
						,15 --IN
						,16 --Yen
						,2 --RM
						,22 --IND
						,3 --US$
						,33 --IDD
						,34 --IDR
						,35 --$US
						,43 --THB
						,45 --Won
						,47 --DDD
						,5 --HK$
						,6 --EURO
						,64 --UT
						,67 --HKK
						,78 --EUR
						,81 --CY
						,20,72 --test
				) --supported currencies


INSERT INTO ProductStatusSiteCurrency (SportType, BetType, SiteID, Currency, IsHidden, IsDisabled, HasSynced)
SELECT DISTINCT @Sporttype, @Bettype, 0, Currency, 1, 1, 1  
FROM #NonOfferedCurency WITH (NOLOCK)

DROP TABLE #NonOfferedCurency





