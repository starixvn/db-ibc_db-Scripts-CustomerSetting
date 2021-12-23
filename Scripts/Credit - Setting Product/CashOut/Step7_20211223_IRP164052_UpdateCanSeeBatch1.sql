/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20211223@Johnson 
	Task: Insert CanSee Cash Out batch 1
	DB: DBCUST/CustDB	
*/ 
USE CustDB
GO
--Batch 1: BEST-ODDS, 611111, 733333, 755555, 222223, 7aa666, KORIBC, 722222, XYZBet

DECLARE @Sporttype SMALLINT
SELECT @Sporttype = 9903

--Import sites which offered Lottery
SELECT siteid
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.site IN ('BEST-ODDS','611111','733333','755555','222223','7aa666','KORIBC','722222','XYZBet')

UPDATE ps
SET ps.IsLaunched = 1,
	currency = 0
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #OfferedSites s ON s.siteid = ps.SiteID
WHERE SportType = @Sporttype
GO




