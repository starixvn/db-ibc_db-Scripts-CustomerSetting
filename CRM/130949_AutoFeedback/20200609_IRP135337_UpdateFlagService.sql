/*
	Created: 20200609@Johnson
	Task : update system setting for auto feedback[redmine:#130949]
	DB: DBCRM/bodb_CRM	
*/

--turn off crm servic
/*
UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = '0'
WHERE SettingName = 'ServiceFlag'
GO
*/

--turn on crm service

UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = '1'
WHERE SettingName = 'ServiceFlag'

GO