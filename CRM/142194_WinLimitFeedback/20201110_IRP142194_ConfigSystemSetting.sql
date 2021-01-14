/*
	Created: 20201110@Johnson
	Task : config system setting for auto feedback winlimit[redmine:#142194]
	DB: DBCRM/bodb_CRM	
*/
--Step 1: ConfigUAT =1
UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = '1'
WHERE SettingName = 'ConfigUAT'
	AND ServiceName = 'WinLimitFB'

--Step 1: ConfigUAT =0 
UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = '0'
WHERE SettingName = 'ConfigUAT'
	AND ServiceName = 'WinLimitFB'
	
/*
--Step 2: Turn off service
UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = '0'
WHERE SettingName = 'ServiceFlag'
	AND ServiceName = 'WinLimitFB'	
	
--Step 3: Turn on service
UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = '1'
WHERE SettingName = 'ServiceFlag'
	AND ServiceName = 'WinLimitFB'	
*/	