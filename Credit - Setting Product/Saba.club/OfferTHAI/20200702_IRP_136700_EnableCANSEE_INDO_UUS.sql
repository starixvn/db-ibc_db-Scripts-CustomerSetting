/*
	Created: Elodie
	Date: 20200702
	Task: Update CanSee for Saba.club - INDO site, UUS
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype SMALLINT
SELECT @Sporttype = 200, @Bettype = 1611


--Import sites which offered this game
SELECT siteid
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.site IN ('755555')

UPDATE ps
SET ps.IsTest = 0
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK)
	INNER JOIN #OfferedSites s ON s.siteid = ps.SiteID
WHERE SportType = @Sporttype AND BetType = @Bettype 
	AND Currency = 20



