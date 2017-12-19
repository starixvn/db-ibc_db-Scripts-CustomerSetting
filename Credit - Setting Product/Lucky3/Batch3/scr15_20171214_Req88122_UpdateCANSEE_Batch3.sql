/*
	Created: Elodie 
	Task: Insert CanSee Lucky3 for batch 3
	DB: DBCUST/CustDB
	Date: 20171214
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT = 160

--Import sites which offered BullFighting for batch 3
SELECT siteid
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.site IN ('755555', '789y')

UPDATE ps
SET ps.IsLaunched = 1
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #OfferedSites s ON s.siteid = ps.SiteID
WHERE SportType = @Sporttype

SELECT *
FROM ProductLaunchedSiteCurrency WITH (NOLOCK)
WHERE SportType = @Sporttype