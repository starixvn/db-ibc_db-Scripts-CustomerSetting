/*
    Created: 20180320@Vicky 
    Task: Rollback CanSee for batch 1
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @tbl_OfferedSites TABLE (siteName VARCHAR(50))
DECLARE @tbl_SportType TABLE (SportType SMALLINT)


INSERT INTO @tbl_SportType(SportType)
VALUES (193), (192)

--Import sites which offered
INSERT INTO @tbl_OfferedSites
VALUES ('Indo'), ('KORIBC'), ('BEST-ODDS')


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE ps
SET ps.IsLaunched = 0
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK)
    INNER JOIN site s ON s.siteId = ps.siteID
    INNER JOIN @tbl_OfferedSites os ON os.siteName = s.site
    INNER JOIN @tbl_SportType spt ON ps.SportType = spt.SportType
