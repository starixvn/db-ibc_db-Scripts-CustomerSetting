/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20211202@Winfred
	Task : config setting for Abnormal Accounts CRM [redmine:#164342]
	DB: DBCRM/bodb_CRM
*/



USE [bodb_CRM]
GO
	

UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = '1' 
WHERE SettingName = 'ConfigUAT'
	AND ServiceName = 'AutoFB'	
	
	
UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = CONVERT( VARCHAR(20),GETDATE(),20)
WHERE SettingName = 'LastDateUAT'
	AND ServiceName = 'AutoFB'		

