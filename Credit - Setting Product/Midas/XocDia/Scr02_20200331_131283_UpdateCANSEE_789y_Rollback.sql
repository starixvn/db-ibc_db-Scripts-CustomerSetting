/*
	Created: Eden
	Date: 20191029
	Task: Rollback CanSee for Virtual games batch 1 - KORIBC
	DB: DBCust/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype SMALLINT 
SELECT @Sporttype = 165, @Bettype = 1903

--Import sites which offered this game for 789y
SELECT siteid
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.site IN ('789y')

UPDATE ps
SET ps.IsLaunched = 0
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #OfferedSites s ON s.siteid = ps.SiteID
WHERE SportType = @Sporttype AND BetType = @Bettype




