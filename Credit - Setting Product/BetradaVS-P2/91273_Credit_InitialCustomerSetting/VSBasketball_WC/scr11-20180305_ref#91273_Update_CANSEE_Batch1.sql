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
DELETE FROM ProductLaunchedSiteCurrency 
WHERE SportType IN (SELECT DISTINCT SportType FROM @tbl_OfferedSites)

INSERT INTO ProductLaunchedSiteCurrency (SportType,     Currency, SiteID,   IsLaunched,                 IsTest)
SELECT                                   spt.SportType, 0,        s.siteid, COALESCE(os.isLaunched,0),  0
FROM dbo.Site s
    CROSS JOIN (SELECT DISTINCT SportType FROM @tbl_OfferedSites ) AS spt
    LEFT JOIN @tbl_OfferedSites os ON s.site = os.siteName AND os.SportType = spt.SportType
WHERE s.isActive = 1 AND s.isLicensee = 0
