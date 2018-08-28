/*
	Created: Elodie 
	Task: Insert CanSee PokerGames for batch 1
	DB: DBCUST/CustDB
	Date: 20180815
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT
SELECT @Sporttype = 163

--Import sites which offered PokerGames
SELECT siteid
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.site IN ('789y')

DELETE FROM ProductLaunchedSiteCurrency WHERE SportType = @Sporttype

INSERT INTO ProductLaunchedSiteCurrency (SportType, Currency, SiteID, IsLaunched, IsTest)
SELECT @Sporttype AS SportType, 0 AS Currency, s.siteid AS SiteID, 0 AS IsLaunched, 0 AS IsTest
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.siteid NOT IN (SELECT siteid FROM #OfferedSites)

INSERT INTO ProductLaunchedSiteCurrency (SportType, Currency, SiteID, IsLaunched, IsTest)
SELECT @Sporttype AS SportType, c.Currency AS Currency, s.siteid AS SiteID, 1 AS IsLaunched, 0 AS IsTest
FROM dbo.Site s WITH(NOLOCK)
	CROSS APPLY (SELECT 16 AS Currency UNION ALL SELECT 64 UNION ALL SELECT 20) c
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.siteid IN (SELECT siteid FROM #OfferedSites)

--Offer site BEST-ODDS, UUS
UPDATE ps
SET ps.IsLaunched = 1,
	currency = 20
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK)
WHERE SportType = @Sporttype AND siteid = 1

--SELECT * FROM ProductLaunchedSiteCurrency WHERE SportType = 163


