/*
    Created: 20180320@Vicky 
    Task: Rollback CanSee for batch 2
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @tbl_OfferedSites TABLE (SportType SMALLINT, siteName VARCHAR(50))


INSERT INTO @tbl_OfferedSites (SportType, siteName)
VALUES (@var_sportType, '789Y')
      ,(@var_sportType, '755555')


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE ps
SET ps.IsLaunched = 0
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK)
    INNER JOIN site s ON s.siteId = ps.siteID
    INNER JOIN @tbl_OfferedSites os ON os.SportType = ps.SportType AND os.siteName = s.site
