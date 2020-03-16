/*
	Created: Tiara
	Task: Rollback CanSee BullFighting for batch 1
	DB: DBCUST/CustDB
	Date: 20200316
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT
SELECT @Sporttype = 244

--Import sites which offered BullFighting for batch 1
SELECT siteid
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.site IN ('Indo')

UPDATE ps
SET ps.IsLaunched = 0
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #OfferedSites s ON s.siteid = ps.SiteID
WHERE SportType = @Sporttype
