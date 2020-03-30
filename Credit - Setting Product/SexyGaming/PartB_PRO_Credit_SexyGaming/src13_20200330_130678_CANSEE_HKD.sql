/*
	Created: Tiara
	Task: Insert CanSee Sexy Gaming for HKD currency [Redmine: #130678]
	DB: DBCUST/CustDB
	Date: 20200330
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 243, @Bettype = 3101

--Import all supported sites
SELECT siteid, site
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.site IN ('Best-odds','222223','611111','722222','733333','222227')

--Offer all sites for HKD
INSERT INTO ProductLaunchedSiteCurrency (SportType, Currency, SiteID, IsLaunched, IsTest, BetType)
SELECT @Sporttype AS SportType, E.exchangeid AS Currency, s.siteid AS SiteID, 1 AS IsLaunched, 0 AS IsTest, @Bettype AS BetType
FROM #OfferedSites S WITH(NOLOCK) CROSS JOIN exchange E WITH (NOLOCK)
WHERE E.exchangeid IN (67) AND S.siteid NOT IN (16,25) --HKD 
UNION ALL
SELECT @Sporttype AS SportType, E.exchangeid AS Currency, s.siteid AS SiteID, 1 AS IsLaunched, 0 AS IsTest, @Bettype AS BetType
FROM #OfferedSites S WITH(NOLOCK) CROSS JOIN exchange E WITH (NOLOCK)
WHERE E.exchangeid IN (5) --HKD

DROP TABLE #OfferedSites

