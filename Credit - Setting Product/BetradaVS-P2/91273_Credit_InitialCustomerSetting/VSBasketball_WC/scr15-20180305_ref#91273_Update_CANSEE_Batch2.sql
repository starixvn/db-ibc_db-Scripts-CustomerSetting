/*
    Created: 20180320@Vicky 
    Task: Insert CanSee for batch 2
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @tbl_OfferedSites TABLE (SportType SMALLINT, siteName VARCHAR(50), isLaunched TINYINT)


--all sites
INSERT INTO @tbl_OfferedSites(SportType)
VALUES (193), 
       (192)


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
DELETE FROM ProductLaunchedSiteCurrency 
WHERE SportType IN (SELECT DISTINCT SportType FROM @tbl_OfferedSites)


INSERT INTO ProductLaunchedSiteCurrency (SportType,     Currency,      SiteID,   IsLaunched, IsTest)
SELECT                                   spt.SportType, 0,             s.siteid, 1,          0
FROM dbo.Site s
    CROSS JOIN (SELECT DISTINCT SportType FROM @tbl_OfferedSites ) AS spt
WHERE s.isActive = 1 AND s.isLicensee = 0  