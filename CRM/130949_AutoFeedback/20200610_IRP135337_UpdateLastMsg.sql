/*
	Created: 20200610@Johnson
	Task : update system setting for auto feedback[redmine:#130949]
	DB: DBCRM/bodb_CRM	
*/
--update lastMsgID
UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = '949353'
WHERE SettingName = 'LastMsgID'
GO