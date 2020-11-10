/*
	Created: 20201110@Johnson
	Task : config system setting for auto feedback winlimit[redmine:#142194]
	DB: DBCRM/bodb_CRM	
*/

UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = '8652'
WHERE SettingName = 'LastLogID'
	AND ServiceName = 'WinLimitFB'