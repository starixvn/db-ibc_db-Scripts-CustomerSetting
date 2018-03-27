/*
    Created: Vicky
    Date: 20180326
    Task: setting for Pragmatic game [RedmineID: 90422]
    DB:DBCust/CustDB
*/
DECLARE @var_sportType SMALLINT = 248,
        @var_bettype SMALLINT = 4101
        
--update level to product
UPDATE ProductSettingDetail SET SettingLevel = 1 WHERE SettingType = 1 AND SportType = 212 AND BetType = 4001
UPDATE ProductSettingDetail SET SettingLevel = 1 WHERE SettingType = 3 AND SportType = 212 AND BetType = 4001
UPDATE ProductSettingDetail SET SettingLevel = 1 WHERE SettingType = 13 AND SportType = 212 AND BetType = 4001
UPDATE ProductSettingDetail SET SettingLevel = 1 WHERE SettingType = 6 AND SportType = 212 AND BetType = 4001

                          
INSERT INTO [ProductLaunchedSiteCurrency]
       (SiteID, Currency, SportType,      IsLaunched, IsTest)
SELECT  siteId, 0       , @var_sportType, 0         , 1
FROM   [site]
WHERE IsLicensee = 0 AND isActive = 1

---update ProductLaunchedSiteCurrency for site BEST-ODDS
UPDATE ProductLaunchedSiteCurrency 
SET IsLaunched = 1
WHERE siteID = 1 AND SportType = @var_sportType
