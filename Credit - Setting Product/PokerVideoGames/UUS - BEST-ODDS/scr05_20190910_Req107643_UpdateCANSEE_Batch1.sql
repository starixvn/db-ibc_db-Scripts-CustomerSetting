/*
	Created: Winnie 
	Task: Insert CanSee PokerGames for batch 1
	DB: DBCUST/CustDB
	Date: 20190110
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT
SELECT @Sporttype = 165

--Import sites which offered PokerGames
SELECT siteid
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.site IN ('BEST-ODDS')

INSERT INTO ProductLaunchedSiteCurrency (SportType, Currency, SiteID, IsLaunched, IsTest)
SELECT @Sporttype AS SportType,20 AS Currency, s.siteid AS SiteID, 1 AS IsLaunched, 1 AS IsTest
FROM dbo.Site s WITH(NOLOCK)	
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.siteid IN (SELECT siteid FROM #OfferedSites)



