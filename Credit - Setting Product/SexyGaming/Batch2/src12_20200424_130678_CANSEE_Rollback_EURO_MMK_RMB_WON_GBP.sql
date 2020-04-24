/*
	Created: 20200424@Tiara
	Task: Rollback CanSee Sexy Gaming Batch 2 [Redmine: #132551]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 243, @Bettype = 3101

--Import sites which offered Sexy Gaming

USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 243, @Bettype = 3101

--Import sites which offered Sexy Gaming
SELECT siteid
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.site IN ('Best-odds','xyzbet','222223','611111','722222','733333','7aa666','KORIBC')

UPDATE ps
SET ps.IsLaunched = 0
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #OfferedSites s ON s.siteid = ps.SiteID
WHERE SportType = @Sporttype AND BetType = @Bettype AND PS.IsLaunched = 1
	AND PS.Currency IN (6,69,13,45,12) --EURO,MMK,RMB,WON,GBP

DROP TABLE #OfferedSites