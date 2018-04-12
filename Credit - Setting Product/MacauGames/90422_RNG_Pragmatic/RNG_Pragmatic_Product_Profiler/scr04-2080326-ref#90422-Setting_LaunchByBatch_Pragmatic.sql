/*
    Created: Vicky
    Date: 20180326
    Task: setting for Pragmatic game [RedmineID: 90422]
    DB:DBCust/CustDB
*/
DECLARE @var_sportType SMALLINT = 248,
        @var_bettype SMALLINT = 4101


------------------------------------------------------------------------------------------------
DELETE FROM ProductLaunchedSiteCurrency WHERE SportType =  @var_sportType

INSERT INTO ProductLaunchedSiteCurrency
       (SiteID, Currency, SportType,      IsLaunched, IsTest)
SELECT  siteId, 0       , @var_sportType, 0         , 1
FROM   [site]
WHERE IsLicensee = 0 AND isActive = 1

---update ProductLaunchedSiteCurrency for site BEST-ODDS
UPDATE ProductLaunchedSiteCurrency 
SET IsLaunched = 1
WHERE siteID = 1 AND SportType = @var_sportType
