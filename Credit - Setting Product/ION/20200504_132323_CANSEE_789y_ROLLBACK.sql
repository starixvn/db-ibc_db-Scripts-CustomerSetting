/*
	Created: 20200504@Eden
	Task: Insert CanSee for ION - 789y - ROLLBACK [Redmine: 132323] - Batch 3
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 225, @Bettype = 5601

CREATE TABLE #OfferCurrency (ExchangeID INT)
INSERT INTO #OfferCurrency(ExchangeID)
			SELECT 15 --IN
UNION ALL SELECT 22 --IND
UNION ALL SELECT 33 --IDD
UNION ALL SELECT 34 --IDR
UNION ALL SELECT 47 --DDD
UNION ALL SELECT 45 --Won
UNION ALL SELECT 2	--RM
UNION ALL SELECT 5	--HK$
UNION ALL SELECT 13 --RMB
UNION ALL SELECT 67 --HKK
UNION ALL SELECT 81 --CY
UNION ALL SELECT 43 --THB
UNION ALL SELECT 3	--US$
UNION ALL SELECT 6	--EURO
UNION ALL SELECT 12 --GBP
UNION ALL SELECT 16 --Yen
UNION ALL SELECT 35 --$US
UNION ALL SELECT 64 --UT

SELECT c.ExchangeID,s.siteid
INTO #OfferedSiteCurrency
FROM #OfferCurrency c
	CROSS APPLY Site s WITH(NOLOCK)
WHERE s.isLicensee = 0 AND s.isActive = 1 AND site IN ('789y')

UPDATE p
SET p.IsLaunched = 0
FROM ProductLaunchedSiteCurrency p WITH(ROWLOCK) 
	INNER JOIN #OfferedSiteCurrency t ON p.Currency = t.ExchangeID ANd p.SiteID = t.siteid
WHERE p.SportType = @Sporttype AND p.BetType = @Bettype

DROP TABLE #OfferCurrency
DROP TABLE #OfferedSiteCurrency

--SELECT * FROM ProductLaunchedSiteCurrency WITH(NOLOCK) WHERE SportType = 225



