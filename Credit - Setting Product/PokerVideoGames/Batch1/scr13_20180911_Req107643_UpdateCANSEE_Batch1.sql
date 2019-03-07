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
	AND s.site IN ('789y')

INSERT INTO ProductLaunchedSiteCurrency (SportType,BetType, Currency, SiteID, IsLaunched, IsTest,LaunchedLevel)
SELECT @Sporttype AS SportType,1901, c.Currency AS Currency, s.siteid AS SiteID, 1 AS IsLaunched, 0 AS IsTest,0
FROM dbo.Site s WITH(NOLOCK)
	CROSS APPLY (SELECT 16 AS Currency UNION ALL SELECT 64) c
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.siteid IN (SELECT siteid FROM #OfferedSites)

UPDATE ProductLaunchedSiteCurrency WITH(ROWLOCK)
	SET IsTest=0
WHERE SportType=@Sporttype AND Currency=20


DROP TABLE #OfferedSites