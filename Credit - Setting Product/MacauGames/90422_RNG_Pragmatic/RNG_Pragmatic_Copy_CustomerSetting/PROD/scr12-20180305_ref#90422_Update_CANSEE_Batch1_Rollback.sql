/*
    Created: 20180320@Vicky 
    Task: Rollback CanSee for batch 1
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @tbl_OfferedSites TABLE (SportType SMALLINT, siteName VARCHAR(50))


INSERT INTO @tbl_OfferedSites (SportType, siteName)
VALUES (@var_sportType, 'Indo')
      ,(@var_sportType, 'KORIBC')
      ,(@var_sportType, '733333')
      ,(@var_sportType, '222223')
      ,(@var_sportType, '222225')
      ,(@var_sportType, '222227')
      ,(@var_sportType, '033333')
      ,(@var_sportType, 'JPNIBC')
      ,(@var_sportType, '611111')
      ,(@var_sportType, '722222')
      ,(@var_sportType, '766666')
      ,(@var_sportType, '7aa666')
      ,(@var_sportType, 'BEST-ODDS')
      ,(@var_sportType, 'XYZbet')


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE ps
SET ps.IsLaunched = 0
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK)
    INNER JOIN site s ON s.siteId = ps.siteID
    INNER JOIN @tbl_OfferedSites os ON os.SportType = ps.SportType AND os.siteName = s.site
