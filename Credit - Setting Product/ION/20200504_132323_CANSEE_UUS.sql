/*
	Created: 20200504@Eden
	Task: Insert CanSee for ION UUS, YNG [Redmine: 132323]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 225, @Bettype = 5601

CREATE TABLE #OfferCurrency (ExchangeID INT)
INSERT INTO #OfferCurrency(ExchangeID)
			SELECT 20 --UUS
UNION ALL SELECT 72 --YNG

SELECT c.ExchangeID,s.siteid
INTO #OfferedSiteCurrency
FROM #OfferCurrency c
	CROSS APPLY Site s WITH(NOLOCK)
WHERE s.isLicensee = 0 AND s.isActive = 1 AND site NOT IN ('IBCIndo')

DELETE p
FROM ProductLaunchedSiteCurrency p WITH(ROWLOCK) 
WHERE p.SportType = @Sporttype AND p.BetType = @Bettype

INSERT INTO ProductLaunchedSiteCurrency (SportType, BetType, Currency, SiteID, IsLaunched, IsTest)
SELECT @Sporttype AS SportType, @Bettype AS BetType, t.ExchangeID AS Currency, siteid AS SiteID, 1 AS IsLaunched, 0 AS IsTest 
FROM #OfferedSiteCurrency t

DROP TABLE #OfferCurrency
DROP TABLE #OfferedSiteCurrency

--SELECT * FROM ProductLaunchedSiteCurrency WITH(NOLOCK) WHERE SportType = 225



