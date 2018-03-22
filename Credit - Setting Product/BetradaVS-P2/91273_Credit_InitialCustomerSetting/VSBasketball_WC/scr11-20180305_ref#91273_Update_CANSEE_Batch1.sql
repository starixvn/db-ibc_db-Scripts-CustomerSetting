/*
    Created: 20180320@Vicky 
    Task: Insert CanSee for batch 1
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @tbl_SportType TABLE (SportType SMALLINT)
DECLARE @tbl_OfferedSites TABLE (siteName VARCHAR(50), isLaunched TINYINT)


INSERT INTO @tbl_SportType(SportType)
VALUES (193), (192)

--Import sites which offered
INSERT INTO @tbl_OfferedSites
VALUES ('Indo',1), ('KORIBC', 1), ('BEST-ODDS', 1)/*for testing*/


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
DELETE FROM ProductLaunchedSiteCurrency 
WHERE SportType IN (SELECT SportType FROM @tbl_SportType)

INSERT INTO ProductLaunchedSiteCurrency (SportType,    Currency, SiteID,   IsLaunched,                 IsTest)
SELECT                                   st.SportType, 0,        s.siteid, COALESCE(os.isLaunched,0),  0
FROM dbo.Site s
    LEFT JOIN @tbl_OfferedSites os ON os.siteName = s.site
    CROSS JOIN @tbl_SportType st
WHERE s.isActive = 1 AND s.isLicensee = 0
