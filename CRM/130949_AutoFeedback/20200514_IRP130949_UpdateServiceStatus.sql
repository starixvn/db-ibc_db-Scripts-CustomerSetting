/*
	Created: 20200513@@Johnson
	Task : update system setting for auto feedback[redmine:#130949]
	DB: DBCRM/bodb_CRM	
*/

--Step 1:Config mode for UUS tickets
UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = 'Completed'
WHERE SettingName = 'JobStatus'
GO