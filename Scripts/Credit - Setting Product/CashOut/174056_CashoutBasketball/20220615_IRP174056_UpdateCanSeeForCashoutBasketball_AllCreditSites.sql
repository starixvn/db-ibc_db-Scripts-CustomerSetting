/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220615@Tacy
	Task: Insert CanSee Cash Out basketball for All credit sites
	DB: DBCUST/CustDB	
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT
SELECT @Sporttype = 9905

--Import sites
SELECT siteid
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0

UPDATE ps
SET ps.IsLaunched = 1,
	currency = 0
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #OfferedSites s ON s.siteid = ps.SiteID
WHERE SportType = @Sporttype
GO