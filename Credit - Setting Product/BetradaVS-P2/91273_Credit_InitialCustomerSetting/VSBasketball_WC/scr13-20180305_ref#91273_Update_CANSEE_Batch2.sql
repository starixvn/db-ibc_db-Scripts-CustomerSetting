/*
    Created: 20180320@Vicky 
    Task: Insert CanSee for batch 2
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @tbl_OfferedSites TABLE (SportType SMALLINT, siteName VARCHAR(50), isLaunched TINYINT)


--Virtual Basketball: all remaining sites
INSERT INTO @tbl_OfferedSites
SELECT 193, s.site, 1
FROM site s
WHERE s.islicensee = 0 AND s.isActive = 1 AND site NOT IN ('Indo', 'KORIBC')


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE ps
SET ps.IsLaunched = 1
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK)
    INNER JOIN site s ON s.siteId = ps.siteID
    INNER JOIN @tbl_OfferedSites os ON os.SportType = ps.SportType AND os.siteName = s.site
