/*
	Created: 20200609@Johnson
	Task : update system setting for auto feedback[redmine:#130949]
	DB: DBCRM/bodb_CRM	
*/
--step 1: run this script to turn off crm service

UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = '0'
WHERE SettingName = 'ServiceFlag'
GO


--step 2:run this script to turn on crm service

UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = '1'
WHERE SettingName = 'ServiceFlag'

GO