/*
	Created: Winfred
	Date: 20200828
	Task: Update ProductStatusSiteCurrency for RM [Redmine: 131589]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype INT, @Bettype INT
SELECT @Sporttype = 233, @Bettype = 3401

DELETE FROM ProductStatusSiteCurrency WHERE SportType=@Sporttype

CREATE TABLE #NonOfferedCurency (Currency INT) 

INSERT INTO #NonOfferedCurency (Currency)
SELECT exchangeid 
FROM exchange WITH(NOLOCK) 
WHERE exchangeid NOT IN (15 --IN
						,45 --Won
						,2 --RM
						,5 --HK$
						,13 --RMB
						,66 --YUN
						,43 --THB
						,3 --US$
						,16 --Yen
						,35 --$US
						,64 --UT
						,95 -- USD
						,51 -- INH
						,20,72 --test
						,67 --HKK
						,4 --TB
						,22 --IND
						,33 --IDD
						,34 --IDR
						,47 --DDD
				) --supported currencies


INSERT INTO ProductStatusSiteCurrency (SportType, BetType, SiteID, Currency, IsHidden, IsDisabled, HasSynced)
SELECT DISTINCT @Sporttype, @Bettype, 0, Currency, 1, 1, 1  
FROM #NonOfferedCurency WITH (NOLOCK)

DROP TABLE #NonOfferedCurency





