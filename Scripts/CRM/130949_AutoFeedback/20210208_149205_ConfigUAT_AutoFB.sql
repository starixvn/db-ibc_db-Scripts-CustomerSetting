/*
	Created: 20210208@@Winfred
	Task : Update config UAT auto feedback [redmine:#149205]
	DB: DBCRM/bodb_CRM	
*/

UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = 0
WHERE SettingName = 'ConfigUAT'
	AND ServiceName = 'AutoFB'
GO