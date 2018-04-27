/*
    Created: 20180320@Vicky 
    Task: Insert CanSee for batch 1
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @tbl_OfferedSites TABLE (SportType SMALLINT, siteName VARCHAR(50), isLaunched TINYINT)


--Import sites which offered
INSERT INTO @tbl_OfferedSites
VALUES (193, 'Indo',1), 
       (193, 'KORIBC', 1)

--Virtual Soccer World Cup: All credit sites
INSERT INTO @tbl_OfferedSites
SELECT 192, s.site, 1
FROM site s
WHERE s.islicensee = 0 AND s.isActive = 1


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE ps
SET ps.IsLaunched = 1
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK)
    INNER JOIN site s ON s.siteId = ps.siteID
    INNER JOIN @tbl_OfferedSites os ON os.SportType = ps.SportType AND os.siteName = s.site
