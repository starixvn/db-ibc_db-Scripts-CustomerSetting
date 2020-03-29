/*
	Created: Elodie
	Date: 20200314
	Task: Insert CanSee for Saba.club - 789y site
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype SMALLINT, @LaunchedLevel TINYINT, @IsTest BIT
SELECT @Sporttype = 200, @Bettype = 1611, @LaunchedLevel = 0, @IsTest = 0

--Import sites which offered this game
SELECT siteid
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.site IN ('789y')

DELETE FROM ProductLaunchedSiteCurrency WHERE BetType = @Bettype

INSERT INTO ProductLaunchedSiteCurrency (SportType, BetType, Currency, SiteID, IsLaunched, IsTest, LaunchedLevel)
SELECT @Sporttype AS SportType, @Bettype AS BetType, 0 AS Currency, s.siteid AS SiteID, 0 AS IsLaunched, @IsTest, @LaunchedLevel
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0

UPDATE ps
SET ps.IsLaunched = 1
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #OfferedSites s ON s.siteid = ps.SiteID
WHERE SportType = @Sporttype AND BetType = @Bettype



