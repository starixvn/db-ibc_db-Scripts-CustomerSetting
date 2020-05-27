/*
	Created: Tiara
	Task: Insert CanSee RNG WAR for 789y [Redmine: #132018]
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
WHERE S.site = '789y'

--Offer all sites
INSERT INTO ProductLaunchedSiteCurrency (SportType, Currency, SiteID, IsLaunched, IsTest, BetType)
SELECT @Sporttype AS SportType, 0 AS Currency, s.siteid AS SiteID, 0 AS IsLaunched, 0 AS IsTest, @Bettype AS BetType
FROM #OfferedSites S WITH(NOLOCK) 

--Offer all currencies on 789y
UPDATE ps
SET ps.IsLaunched = 1
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #OfferedSites s ON s.siteid = ps.SiteID
WHERE SportType = @Sporttype AND BetType = @Bettype 

DROP TABLE #OfferedSites

