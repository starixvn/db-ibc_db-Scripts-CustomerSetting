/*
	Created: Elodie
	Date: 20200314
	Task: Insert CanSee for Midas - 789y site
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype SMALLINT, @LaunchedLevel TINYINT, @IsTest BIT
SELECT @Sporttype = 165, @Bettype = 1903, @LaunchedLevel = 1, @IsTest = 1

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

--Offer site BEST-ODDS, UUS
UPDATE ps
SET ps.IsLaunched = 1,
	currency = 20
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
WHERE SportType = @Sporttype AND BetType = @Bettype AND siteid = 1


