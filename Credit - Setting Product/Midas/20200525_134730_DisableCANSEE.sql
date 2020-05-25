/*
	Created: Elodie
	Date: 20200525
	Task: DISABLE CAN SEE cho 1902 & 1903
	DB: DBCust/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype SMALLINT
SELECT @Sporttype = 165

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
WHERE SportType = @Sporttype AND BetType IN (1902,1903)




