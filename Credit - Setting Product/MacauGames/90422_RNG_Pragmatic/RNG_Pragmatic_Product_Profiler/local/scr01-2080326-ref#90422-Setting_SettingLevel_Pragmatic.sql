/*
    Created: Vicky
    Date: 20180326
    Task: setting for Pragmatic game [RedmineID: 90422]
    DB:DBCust/CustDB
*/
DECLARE @var_sportType_delegate SMALLINT = 212,
        @var_bettype_delegate SMALLINT = 4001

        
---------------------------------------------------------------------------------------------------------
UPDATE ProductSettingDetail 
SET SettingType = 13, SettingLevel=1
WHERE SettingType = 4 AND SportType = @var_sportType_delegate AND BetType = @var_bettype_delegate

