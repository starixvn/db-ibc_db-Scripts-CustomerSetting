/*
	Created: Tiara
	Task: Insert CanSee Sexy Gaming for all sites [Redmine: #130678]
	DB: DBCUST/CustDB
	Date: 20200321
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


DELETE FROM ProductLaunchedSiteCurrency WHERE SportType = @Sporttype
--Offer all sites
INSERT INTO ProductLaunchedSiteCurrency (SportType, Currency, SiteID, IsLaunched, IsTest, BetType)
SELECT @Sporttype AS SportType, E.exchangeid AS Currency, s.siteid AS SiteID, 0 AS IsLaunched, 0 AS IsTest, @Bettype AS BetType
FROM #OfferedSites S WITH(NOLOCK) CROSS JOIN exchange E WITH (NOLOCK)

--Offer supported currencies on all sites 
UPDATE ps
SET ps.IsLaunched = 1
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #OfferedSites s ON s.siteid = ps.SiteID
WHERE SportType = @Sporttype AND BetType = @Bettype AND PS.Currency IN (16, 64, 35, 3, 74, 12, 2, 67, 5, 4, 43, 15, 22, 33, 34, 47, 20) --Supported currencies

DROP TABLE #OfferedSites

