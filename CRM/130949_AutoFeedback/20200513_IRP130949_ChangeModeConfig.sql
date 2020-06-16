/*
	Created: 20200513@@Johnson
	Task : Initial data for system setting for auto feedback[redmine:#130949]
	DB: DBCRM/bodb_CRM	
*/

--Step 1:Config mode for UUS tickets
UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = 1
WHERE SettingName = 'ConfigUAT'
GO

--Step 2:Config mode for real tickets
--UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
--SET Value = 1
--WHERE SettingName = 'ConfigPRO'
--GO