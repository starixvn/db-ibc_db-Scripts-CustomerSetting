USE CustDB
GO

DECLARE @tbl_OfferedSites TABLE (SportType SMALLINT)


--Import sites which offered
INSERT INTO @tbl_OfferedSites
VALUES (193), 
       (192)


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
DELETE FROM ProductLaunchedSiteCurrency 
WHERE SportType IN (SELECT DISTINCT SportType FROM @tbl_OfferedSites)


INSERT INTO ProductLaunchedSiteCurrency (SportType,     Currency,      SiteID,   IsLaunched, IsTest)
SELECT                                   spt.SportType, ex.exchangeid, s.siteid, 0,          1
FROM dbo.Site s
    CROSS JOIN (SELECT DISTINCT SportType FROM @tbl_OfferedSites ) AS spt
    CROSS JOIN (SELECT exchangeid FROM Exchange) as ex
WHERE s.isActive = 1 AND s.isLicensee = 0


-----offer for UUS
UPDATE ProductLaunchedSiteCurrency
SET IsLaunched = 1, IsTest = 0
WHERE SportType IN (SELECT SportType FROM @tbl_OfferedSites)
    AND Currency = 20
    