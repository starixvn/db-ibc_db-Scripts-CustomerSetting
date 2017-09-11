/*
	Created: Elodie 
	Task: Insert CanSee BetRadarVS for batch 1
	DB: DBCUST/CustDB
	Date: 20170801
*/ 
USE CustDB
GO

--Import sites which offered BetRadarVS
SELECT siteid
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.site IN ('789y','XYZBET','611111','722222','755555','222223','222225','222227','spotico','033333','JPNIBC','IMBC','766666','7aa666')

UPDATE ps
SET ps.IsLaunched = 1
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #OfferedSites s ON s.siteid = ps.SiteID
WHERE SportType = 190

--Offer site BEST-ODDS all currency
UPDATE ps
SET ps.IsLaunched = 1,
	currency = 0
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
WHERE SportType = 190 AND siteid = 1

SELECT *
FROM ProductLaunchedSiteCurrency WITH (NOLOCK)
WHERE SportType = 190