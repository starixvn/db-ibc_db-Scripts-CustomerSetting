/*
	Created: Tiara
	Task: Insert CanSee SAGaming for batch 1
	DB: DBCUST/CustDB
	Date: 20200316
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 244, @Bettype = 3001

--Import Indo site
SELECT siteid
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.site IN ('Indo')

DELETE FROM ProductLaunchedSiteCurrency WHERE SportType = @Sporttype
--Offer Indo site
INSERT INTO ProductLaunchedSiteCurrency (SportType, Currency, SiteID, IsLaunched, IsTest, BetType)
SELECT @Sporttype AS SportType, E.exchangeid AS Currency, s.siteid AS SiteID, 0 AS IsLaunched, 0 AS IsTest, @Bettype AS BetType
FROM #OfferedSites S WITH(NOLOCK) CROSS JOIN exchange E WITH (NOLOCK)

--Offer all currency on Indo site exclude RMB and Won (KRW)
UPDATE ps
SET ps.IsLaunched = 1
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #OfferedSites s ON s.siteid = ps.SiteID
WHERE SportType = @Sporttype AND BetType = @Bettype AND PS.Currency NOT IN (13,45)

--Offer site BEST-ODDS, UUS

INSERT INTO ProductLaunchedSiteCurrency (SportType, Currency, SiteID, IsLaunched, IsTest, BetType)
SELECT @Sporttype AS SportType, 20 AS Currency, S.siteid AS SiteID, 1 AS IsLaunched, 0 AS IsTest, @Bettype AS Bettype
FROM Site S WITH (NOLOCK)
WHERE S.siteid = 1

DROP TABLE #OfferedSites