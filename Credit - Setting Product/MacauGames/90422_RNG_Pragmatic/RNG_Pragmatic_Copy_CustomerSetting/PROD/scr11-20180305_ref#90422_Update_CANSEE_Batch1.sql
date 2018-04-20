/*
    Created: 20180320@Vicky 
    Task: update CanSee for batch 1
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @tbl_OfferedSites TABLE (SportType SMALLINT, siteName VARCHAR(50), isLaunched TINYINT)
DECLARE @var_sportType INT = 248

--Import sites which offered
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

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
DELETE FROM ProductLaunchedSiteCurrency 
WHERE SportType IN (SELECT DISTINCT SportType FROM @tbl_OfferedSites)

UPDATE @tbl_OfferedSites
SET isLaunched = 1

INSERT INTO ProductLaunchedSiteCurrency (SportType,     Currency, SiteID,   IsLaunched,                 IsTest)
SELECT                                   spt.SportType, 0,        s.siteid, COALESCE(os.isLaunched,0),  0
FROM dbo.Site s
    CROSS JOIN (SELECT DISTINCT SportType FROM @tbl_OfferedSites ) AS spt
    LEFT JOIN @tbl_OfferedSites os ON s.site = os.siteName AND os.SportType = spt.SportType
WHERE s.isActive = 1 AND s.isLicensee = 0
