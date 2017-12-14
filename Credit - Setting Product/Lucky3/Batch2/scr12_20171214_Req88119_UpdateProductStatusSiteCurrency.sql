/*
	Created: Elodie
	Task: Update ProductStatusSiteCurrency for Lucky3
	DB: DBCUST/CustDB
	Date: 20171214
*/ 
 
DECLARE @Sporttype INT
SELECT @Sporttype = 160

--Import sites which offered BullFighting for batch 2
SELECT siteid
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.site IN ('733333', '222223', '222225', '222227', '033333', 'JPNIBC', '611111', '722222', '766666', '7aa666', 'BEST-ODDS', 'XYZbet')
		
DELETE ps
FROM ProductStatusSiteCurrency ps
	INNER JOIN #OfferedSites s ON ps.siteid = s.siteid
WHERE SportType = @Sporttype

	