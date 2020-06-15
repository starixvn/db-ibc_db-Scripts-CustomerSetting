/*
	Created: Eden
	Task: Insert CanSee RNG WAR for Indo, IBCIndo Sites [Redmine: #132018]
	DB: DBCUST/CustDB
	Date: 20200615
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 224, @Bettype = 5500

--Re-Insert for UUS,YNG by site
DELETE p
FROM ProductLaunchedSiteCurrency p WITH(ROWLOCK) 
WHERE p.SportType = @Sporttype AND p.BetType = @Bettype

CREATE TABLE #OfferCurrency (ExchangeID INT)
INSERT INTO #OfferCurrency(ExchangeID)
			SELECT 20 --UUS
UNION ALL SELECT 72 --YNG

SELECT c.ExchangeID,s.siteid
INTO #OfferedSiteCurrency
FROM #OfferCurrency c
	CROSS APPLY Site s WITH(NOLOCK)
WHERE s.isLicensee = 0 AND s.isActive = 1 AND s.Site <> 'CN88'

INSERT INTO ProductLaunchedSiteCurrency (SportType, BetType, Currency, SiteID, IsLaunched, IsTest)
SELECT @Sporttype AS SportType, @Bettype AS BetType, t.ExchangeID AS Currency, siteid AS SiteID, 1 AS IsLaunched, 0 AS IsTest 
FROM #OfferedSiteCurrency t

DROP TABLE #OfferCurrency
DROP TABLE #OfferedSiteCurrency

--> Process for Indo, IBCIndo Sites 

--Import offered Sites
SELECT siteid
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0 AND S.site IN ('Indo','IBCIndo')

DELETE p
FROM ProductLaunchedSiteCurrency p WITH(ROWLOCK) 
	INNER JOIN #OfferedSites t ON p.SiteID = t.siteid
WHERE p.SportType = @Sporttype AND p.BetType = @Bettype

--Offer sites
INSERT INTO ProductLaunchedSiteCurrency (SportType, Currency, SiteID, IsLaunched, IsTest, BetType)
SELECT @Sporttype AS SportType, 0 AS Currency, s.siteid AS SiteID, 0 AS IsLaunched, 0 AS IsTest, @Bettype AS BetType
FROM #OfferedSites S WITH(NOLOCK) 

--Offer Indo, IBCIndo
UPDATE ps
SET ps.IsLaunched = 1
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #OfferedSites s ON s.siteid = ps.SiteID
WHERE SportType = @Sporttype AND BetType = @Bettype 

DROP TABLE #OfferedSites

--SELECT * FROM ProductLaunchedSiteCurrency WITH(NOLOCK) WHERE SportType = 224