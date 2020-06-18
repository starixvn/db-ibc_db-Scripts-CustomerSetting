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
	AND s.site IN ('789y')

--Offer Indo site
INSERT INTO ProductLaunchedSiteCurrency (SportType, Currency, SiteID, IsLaunched, IsTest, BetType)
SELECT @Sporttype AS SportType, E.exchangeid AS Currency, s.siteid AS SiteID, 0 AS IsLaunched, 0 AS IsTest, @Bettype AS BetType
FROM #OfferedSites S WITH(NOLOCK) CROSS JOIN exchange E WITH (NOLOCK)
WHERE ExchangeId IN (2,3,5,6,12,13,15,16,22,33,34,35,43,45,47,64,67,69,72,81)

--Offer all currency on Indo site exclude RMB and Won (KRW)
UPDATE ps
SET ps.IsLaunched = 1
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #OfferedSites s ON s.siteid = ps.SiteID
WHERE SportType = @Sporttype AND BetType = @Bettype AND PS.Currency NOT IN (13,45,5,67)

DROP TABLE #OfferedSites