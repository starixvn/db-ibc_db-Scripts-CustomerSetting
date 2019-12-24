/*
	Created: Eden
	Date: 20191029
	Task: Rollback CanSee for Virtual games batch 2 - - All Sites
	DB: DBCust/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype SMALLINT
SELECT @Sporttype = 245

--Import sites which offered this game for batch 1
SELECT siteid
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.site NOT IN ('KORIBC')

UPDATE ps
SET ps.IsLaunched = 0
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #OfferedSites s ON s.siteid = ps.SiteID
WHERE SportType = @Sporttype




