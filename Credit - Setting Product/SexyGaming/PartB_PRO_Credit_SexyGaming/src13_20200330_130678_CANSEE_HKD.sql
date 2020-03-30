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

--Import all active sites
SELECT siteid
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0

--Offer all sites for HKD
INSERT INTO ProductLaunchedSiteCurrency (SportType, Currency, SiteID, IsLaunched, IsTest, BetType)
SELECT @Sporttype AS SportType, E.exchangeid AS Currency, s.siteid AS SiteID, 1 AS IsLaunched, 0 AS IsTest, @Bettype AS BetType
FROM #OfferedSites S WITH(NOLOCK) CROSS JOIN exchange E WITH (NOLOCK)
WHERE E.exchangeid IN (5,67) --HKD

DROP TABLE #OfferedSites

