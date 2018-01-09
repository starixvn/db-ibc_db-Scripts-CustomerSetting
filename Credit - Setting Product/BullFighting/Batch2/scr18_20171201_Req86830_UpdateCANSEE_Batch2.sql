/*
	Created: Elodie 
	Task: Insert CanSee BullFighting for batch 2
	DB: DBCUST/CustDB
	Date: 20171201
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT = 207

--Import sites which offered BullFighting for batch 2
SELECT siteid
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.site IN ('733333', '222223', '222225', '222227', '033333', 'JPNIBC', '611111', '722222', '766666', '7aa666', 'BEST-ODDS', 'XYZbet')

UPDATE ps
SET ps.IsLaunched = 1
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #OfferedSites s ON s.siteid = ps.SiteID
WHERE SportType = @Sporttype

--Offer site BEST-ODDS
UPDATE ps
SET ps.IsLaunched = 1,
	currency = 0
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
WHERE SportType = @Sporttype AND siteid IN (1)

SELECT *
FROM ProductLaunchedSiteCurrency WITH (NOLOCK)
WHERE SportType = @Sporttype