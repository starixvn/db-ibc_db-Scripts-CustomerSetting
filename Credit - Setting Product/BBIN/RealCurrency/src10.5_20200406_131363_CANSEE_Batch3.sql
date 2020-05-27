/*
	Created: 20200406@Eden
	Task: Update CanSee for BBIN - Batch3 [Redmine: #131363] 
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 241, @Bettype = 3300

CREATE TABLE #OfferedSitesCurrency (SiteID INT, Currency INT)
INSERT INTO #OfferedSitesCurrency(SiteID,Currency)
SELECT 1, 35 UNION ALL --BEST-ODDS, $US
SELECT 11, 3 UNION ALL --INDO, US$
SELECT 1, 3 UNION ALL --BEST-ODDS, US$
SELECT 1, 64 UNION ALL --BEST-ODDS, UT
SELECT 1, 16  --BEST-ODDS, Yen

UPDATE ps
SET IsLaunched = 1
FROM ProductLaunchedSiteCurrency ps WITH(ROWLOCK)
	INNER JOIN #OfferedSitesCurrency s ON s.siteid = ps.SiteID AND s.Currency = ps.Currency
WHERE SportType = @Sporttype AND BetType = @Bettype

--SELECT * FROM ProductLaunchedSiteCurrency WITH(NOLOCK) WHERE SportType = 241 AND IsLaunched = 0

DROP TABLE #OfferedSitesCurrency


