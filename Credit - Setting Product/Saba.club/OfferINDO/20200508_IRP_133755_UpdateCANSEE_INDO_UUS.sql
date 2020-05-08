/*
	Created: Elodie
	Date: 20200508
	Task: Update CanSee for Saba.club - INDO site, UUS
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype SMALLINT
SELECT @Sporttype = 200, @Bettype = 1611


--Import sites which offered this game
SELECT siteid
INTO #OfferedSites
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.site IN ('Indo', 'IbcIndo')

UPDATE ps
SET ps.Currency = 20
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK)
	INNER JOIN #OfferedSites s ON s.siteid = ps.SiteID
WHERE SportType = @Sporttype AND BetType = @Bettype 



