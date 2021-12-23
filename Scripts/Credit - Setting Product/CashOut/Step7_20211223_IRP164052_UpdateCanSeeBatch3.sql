/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20211223@Johnson 
	Task: Insert CanSee Cash Out batch 1
	DB: DBCUST/CustDB	
*/ 
USE CustDB
GO
--Batch 3: 789y

DECLARE @Sporttype SMALLINT
SELECT @Sporttype = 9903

--Import sites which offered Lottery
SELECT siteid
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.site IN ('789y')

UPDATE ps
SET ps.IsLaunched = 1,
	currency = 0
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #OfferedSites s ON s.siteid = ps.SiteID
WHERE SportType = @Sporttype
GO




