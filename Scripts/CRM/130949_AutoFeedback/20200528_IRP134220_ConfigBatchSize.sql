/*
	Created: 20200513@@Johnson
	Task : update system setting for auto feedback[redmine:#130949]
	DB: DBCRM/bodb_CRM	
*/

--Step 1:Config mode to turn off service
/*UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = '0'
WHERE SettingName = 'BatchSize'
GO
*/

--Step 2:Config mode to normal
UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = '10'
WHERE SettingName = 'BatchSize'
GO