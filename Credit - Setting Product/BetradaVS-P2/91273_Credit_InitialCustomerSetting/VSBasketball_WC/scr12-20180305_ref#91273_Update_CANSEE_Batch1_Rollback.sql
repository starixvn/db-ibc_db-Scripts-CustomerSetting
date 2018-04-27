/*
    Created: 20180320@Vicky 
    Task: Rollback CanSee for batch 1
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @tbl_OfferedSites TABLE (SportType SMALLINT, siteName VARCHAR(50))


--for VSBasketball
INSERT INTO @tbl_OfferedSites
VALUES (193, 'Indo'), (193, 'KORIBC')

--for VSWC
--Virtual Soccer World Cup: All credit sites
INSERT INTO @tbl_OfferedSites
SELECT 192, s.site
FROM site s
WHERE s.islicensee = 0 AND s.isActive = 1

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE ps
SET ps.IsLaunched = 0
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK)
    INNER JOIN site s ON s.siteId = ps.siteID
    INNER JOIN @tbl_OfferedSites os ON os.SportType = ps.SportType AND os.siteName = s.site
WHERE ps.currency <> 20    
