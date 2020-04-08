/*
	Created: 20200406@Eden
	Task: Insert CanSee for BBIN [Redmine: #131363] 
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 241, @Bettype = 3300

--Import sites which offered this game
SELECT siteid
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.site NOT IN ('CN88')

DELETE FROM ProductLaunchedSiteCurrency WHERE SportType = @Sporttype

INSERT INTO ProductLaunchedSiteCurrency (SportType, BetType, Currency, SiteID, IsLaunched, IsTest, LaunchedLevel)
SELECT @Sporttype AS SportType, @Bettype AS BetType, 0 AS Currency, s.siteid AS SiteID, 0 AS IsLaunched, 0 AS IsTest, 1 AS LaunchedLevel
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0

UPDATE ps
SET ps.IsLaunched = 1
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #OfferedSites s ON s.siteid = ps.SiteID
WHERE SportType = @Sporttype AND BetType = @Bettype

----Offer site BEST-ODDS, UUS
--UPDATE ps
--SET ps.IsLaunched = 1,
--	currency = 20
--FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
--WHERE SportType = @Sporttype AND BetType = @Bettype AND siteid = 1

DROP TABLE #OfferedSites

--SELECT * FROM ProductLaunchedSiteCurrency WHERE SportType = 241



