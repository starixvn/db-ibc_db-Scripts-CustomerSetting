/*
	Created: Elodie
	Date: 20200702
	Task: Rollback CanSee for Saba.club - 755555 site
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype SMALLINT 
SELECT @Sporttype = 200, @Bettype = 1611

--Import sites which offered this game for 789y
SELECT siteid
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.site IN ('755555')

UPDATE ps
SET ps.IsLaunched = 0
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #OfferedSites s ON s.siteid = ps.SiteID
WHERE SportType = @Sporttype AND BetType = @Bettype




