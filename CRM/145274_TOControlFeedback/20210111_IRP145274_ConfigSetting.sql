/*
	Created: 20210111@Johnson
	Task: config setting for TOControl auto fb service
	DB: DBCRM/bodb_CRM
*/

UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = '1'
WHERE SettingName = 'ConfigPRO'
	AND ServiceName = 'TOControlFB'
	

UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = '0'
WHERE SettingName = 'ConfigUAT'
	AND ServiceName = 'TOControlFB'	