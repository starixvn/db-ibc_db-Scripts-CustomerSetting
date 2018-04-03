/*
    Created: Vicky
    Date: 20180326
    Task: setting for Pragmatic game [RedmineID: 90422]
    DB:DBCust/CustDB
*/
DECLARE @var_sportType_delegate SMALLINT = 212,
        @var_bettype_delegate SMALLINT = 4001

        
---------------------------------------------------------------------------------------------------------
--update level to product
UPDATE ProductSettingDetail SET SettingLevel = 1 WHERE SettingType = 1  AND SportType = @var_sportType_delegate AND BetType = @var_bettype_delegate
UPDATE ProductSettingDetail SET SettingLevel = 1 WHERE SettingType = 3  AND SportType = @var_sportType_delegate AND BetType = @var_bettype_delegate
UPDATE ProductSettingDetail SET SettingLevel = 1 WHERE SettingType = 13 AND SportType = @var_sportType_delegate AND BetType = @var_bettype_delegate
UPDATE ProductSettingDetail SET SettingLevel = 1 WHERE SettingType = 6  AND SportType = @var_sportType_delegate AND BetType = @var_bettype_delegate

