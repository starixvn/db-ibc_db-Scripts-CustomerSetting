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
VALUES  (248, '789Y' ,1) 
       ,(248, 'Thai', 1)


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE ps
SET ps.IsLaunched = 1
FROM dbo.ProductLaunchedSiteCurrency ps WITH (ROWLOCK)
    INNER JOIN site s ON s.siteId = ps.siteID
    INNER JOIN @tbl_OfferedSites os ON os.SportType = ps.SportType AND os.siteName = s.site
