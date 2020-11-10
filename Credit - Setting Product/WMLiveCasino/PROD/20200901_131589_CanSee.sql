/*
	Created: Winfred
	Date: 20200828
	Task: Insert CanSee for WM [Redmine: 131589]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype INT, @Bettype INT
SELECT @Sporttype = 233, @Bettype = 3401

CREATE TABLE #OfferCurrency (ExchangeID INT)
INSERT INTO #OfferCurrency(ExchangeID)
			SELECT 15 --IN
UNION ALL SELECT 45 --Won
UNION ALL SELECT 2 --RM
UNION ALL SELECT 5 --HK$
UNION ALL SELECT 13 --RMB
UNION ALL SELECT 66 --YUN
UNION ALL SELECT 43 --THB
UNION ALL SELECT 3 --US$
UNION ALL SELECT 16 --Yen
UNION ALL SELECT 35 --$US
UNION ALL SELECT 64 --UT
UNION ALL SELECT 95 -- USD
UNION ALL SELECT 51 -- INH
UNION ALL SELECT 20	--UUS
UNION ALL SELECT 72 --YNG
UNION ALL SELECT 67 --HKK
UNION ALL SELECT 4 --TB
UNION ALL SELECT 22 --IND
UNION ALL SELECT 33 --IDD
UNION ALL SELECT 34 --IDR
UNION ALL SELECT 47 --DDD

SELECT c.ExchangeID,s.siteid
INTO #OfferedSiteCurrency
FROM #OfferCurrency c
	CROSS APPLY Site s WITH(NOLOCK)
WHERE s.isLicensee = 0 AND s.isActive = 1  AND site NOT IN ('CN88')

DELETE p
FROM ProductLaunchedSiteCurrency p WITH(ROWLOCK) 
	INNER JOIN #OfferedSiteCurrency t ON p.Currency = t.ExchangeID AND p.SiteID = t.siteid
WHERE p.SportType = @Sporttype AND p.BetType = @Bettype

INSERT INTO ProductLaunchedSiteCurrency (SportType, BetType, Currency, SiteID, IsLaunched, IsTest)
SELECT @Sporttype AS SportType, @Bettype AS BetType, t.ExchangeID AS Currency, siteid AS SiteID, 1 AS IsLaunched, 0 AS IsTest 
FROM #OfferedSiteCurrency t

DROP TABLE #OfferCurrency
DROP TABLE #OfferedSiteCurrency





