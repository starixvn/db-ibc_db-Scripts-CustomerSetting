/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20211223@Johnson 
	Task: Insert CanSee Cash Out for UUS on UAT
	DB: DBCUST/CustDB	
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT
SELECT @Sporttype = 9903

--Import sites which offered Lottery
SELECT siteid
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.site IN ('BEST-ODDS','611111','733333','755555','222223','7aa666','KORIBC','722222','XYZBet',
	'Indo', 'IBCIndo', '76666B', '789y')

DELETE FROM ProductLaunchedSiteCurrency WHERE SportType = @Sporttype

INSERT INTO ProductLaunchedSiteCurrency (SportType, Currency, SiteID, IsLaunched, IsTest, BetType, LaunchedLevel)
SELECT @Sporttype AS SportType, 0 AS Currency, s.siteid AS SiteID, 0 AS IsLaunched, 0 AS IsTest, 1, 0
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0

UPDATE ps
SET ps.IsLaunched = 1,
	currency = 20
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #OfferedSites s ON s.siteid = ps.SiteID
WHERE SportType = @Sporttype
GO




