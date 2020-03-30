/*
	Created: Tiara
	Task: Rollback CanSee Sexy Gaming for HKD [Redmine: #130678]
	DB: DBCUST/CustDB
	Date: 20200330
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 243, @Bettype = 3101

--Import all supported sites
SELECT siteid
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.site IN ('Best-odds','222223','611111','722222','733333','222227')

UPDATE ps
SET ps.IsLaunched = 0
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #OfferedSites s ON s.siteid = ps.SiteID
WHERE SportType = @Sporttype AND BetType = @Bettype AND PS.IsLaunched = 1 AND PS.Currency IN (5,67)

DROP TABLE #OfferedSites
