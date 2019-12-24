/*
	Created: Eden
	Date: 20191029
	Task: Insert CanSee for Virtual games batch 1 - KORIBC
	DB: DBCust/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype SMALLINT
SELECT @Sporttype = 245

--Import sites which offered this game
SELECT siteid
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.site IN ('KORIBC')

DELETE FROM ProductLaunchedSiteCurrency WHERE SportType = @Sporttype

INSERT INTO ProductLaunchedSiteCurrency (SportType, Currency, SiteID, IsLaunched, IsTest)
SELECT @Sporttype AS SportType, 0 AS Currency, s.siteid AS SiteID, 0 AS IsLaunched, 0 AS IsTest
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0

UPDATE ps
SET ps.IsLaunched = 1
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #OfferedSites s ON s.siteid = ps.SiteID
WHERE SportType = @Sporttype

--Offer site BEST-ODDS, UUS
UPDATE ps
SET ps.IsLaunched = 1,
	currency = 20
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
WHERE SportType = @Sporttype AND siteid = 1


