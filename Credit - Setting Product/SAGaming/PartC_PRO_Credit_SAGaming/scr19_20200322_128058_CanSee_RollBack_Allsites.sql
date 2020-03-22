/*
	Created: Tiara
	Task: Rollback CanSee SA Gaming for batch 1
	DB: DBCUST/CustDB
	Date: 20200316
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 244, @Bettype = 3001

--Import sites which offered SA Gaming
SELECT siteid
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0


UPDATE ps
SET ps.IsLaunched = 0
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #OfferedSites s ON s.siteid = ps.SiteID
WHERE SportType = @Sporttype AND BetType = @Bettype AND PS.IsLaunched = 1

DROP TABLE #OfferedSites
