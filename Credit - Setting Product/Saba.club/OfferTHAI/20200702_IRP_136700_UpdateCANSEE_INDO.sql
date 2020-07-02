/*
	Created: Elodie
	Date: 20200508
	Task: Insert CanSee for Saba.club - Indo site
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype SMALLINT, @LaunchedLevel TINYINT, @IsTest BIT
SELECT @Sporttype = 200, @Bettype = 1611, @LaunchedLevel = 0, @IsTest = 1

--Import sites which offered this game
SELECT siteid
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.site IN ('Indo', 'IbcIndo')

DELETE ps
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK)
	INNER JOIN #OfferedSites s ON s.siteid = ps.SiteID
WHERE SportType = @Sporttype AND BetType = @Bettype

INSERT INTO ProductLaunchedSiteCurrency (SportType, BetType, Currency, SiteID, IsLaunched, IsTest, LaunchedLevel)
SELECT @Sporttype AS SportType, @Bettype AS BetType, e.exchangeid AS Currency, s.siteid AS SiteID, 1 AS IsLaunched, @IsTest, @LaunchedLevel
FROM dbo.#OfferedSites s
	CROSS JOIN dbo.exchange e WITH (NOLOCK) 
WHERE  e.ExchangeId IN (15, 22, 33, 34, 47, 20) -- ('IDD', 'IDR', 'IN', 'IND','DDD', 'UUS')



