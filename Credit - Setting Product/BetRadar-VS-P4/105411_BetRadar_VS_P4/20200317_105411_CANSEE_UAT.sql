/*
	Created: Tiara
	Task: Insert CanSee BetRadar VS 2 - Phase 4 UAT [RedmineID: #105411]
	DB: DBCUST/CustDB
	Date: 20200317
*/ 
USE CustDB
GO

DECLARE @Bettype INT
SELECT @Bettype = 2701
--Import all active site
SELECT siteid
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0

DELETE FROM ProductLaunchedSiteCurrency WHERE SportType IN (195,196)
--Insert data for all active sites
INSERT INTO ProductLaunchedSiteCurrency (SportType, Currency, SiteID, IsLaunched, IsTest, BetType)
SELECT 195 AS SportType, 0 AS Currency, S.siteid AS SiteID, 0 AS IsLaunched, 1 AS IsTest, @Bettype AS BetType
FROM #OfferedSites S WITH(NOLOCK) 
UNION ALL
SELECT 196 AS SportType, 0 AS Currency, S.siteid AS SiteID, 0 AS IsLaunched, 1 AS IsTest, @Bettype AS BetType
FROM #OfferedSites S WITH(NOLOCK) 

--Offer all currency for site Indo and 611111
UPDATE ps
SET ps.IsLaunched = 1
FROM dbo.ProductLaunchedSiteCurrency PS WITH (ROWLOCK,UPDLOCK)
WHERE SportType IN (195,196) AND PS.SiteID IN (11,16)

DROP TABLE #OfferedSites