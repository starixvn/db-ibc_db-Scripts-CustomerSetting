/*
	Created: Tiara
	Task: Insert CanSee RNG WAR for all sites (except 789y) [Redmine: #132018]
	DB: DBCUST/CustDB
	Date: 20200527
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 224, @Bettype = 5500

--Import all active sites
SELECT siteid
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0 AND S.site NOT IN ('Indo','IBCIndo','789y','CN88')

DELETE p
FROM ProductLaunchedSiteCurrency p WITH(ROWLOCK) 
	INNER JOIN #OfferedSites t ON p.SiteID = t.siteid
WHERE p.SportType = @Sporttype AND p.BetType = @Bettype

--Offer all sites
INSERT INTO ProductLaunchedSiteCurrency (SportType, Currency, SiteID, IsLaunched, IsTest, BetType)
SELECT @Sporttype AS SportType, 0 AS Currency, s.siteid AS SiteID, 0 AS IsLaunched, 0 AS IsTest, @Bettype AS BetType
FROM #OfferedSites S WITH(NOLOCK) 

--Offer all currencies on all sites except 789y
UPDATE ps
SET ps.IsLaunched = 1
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #OfferedSites s ON s.siteid = ps.SiteID
WHERE SportType = @Sporttype AND BetType = @Bettype 

DROP TABLE #OfferedSites
--SELECT * FROM ProductLaunchedSiteCurrency WITH(NOLOCK) WHERE SportType = 224