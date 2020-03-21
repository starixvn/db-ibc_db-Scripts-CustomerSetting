/*
	Created: Tiara
	Task: Insert CanSee Sexy Gaming for batch 1 [Redmine: #130678]
	DB: DBCUST/CustDB
	Date: 20200321
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 243, @Bettype = 3101

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
WHERE SportType = @Sporttype AND BetType = @Bettype AND PS.Currency IN (16, 64, 35, 3, 74, 12, 2, 67, 5, 4, 43, 15, 22, 33, 34, 47, 72, 20) --Supported currencies

--Offer site BEST-ODDS, UUS

INSERT INTO ProductLaunchedSiteCurrency (SportType, Currency, SiteID, IsLaunched, IsTest, BetType)
SELECT @Sporttype AS SportType, 20 AS Currency, S.siteid AS SiteID, 1 AS IsLaunched, 0 AS IsTest, @Bettype AS Bettype
FROM Site S WITH (NOLOCK)
WHERE S.siteid = 1

DROP TABLE #OfferedSites