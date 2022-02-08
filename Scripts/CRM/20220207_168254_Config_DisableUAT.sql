/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20220207@Elodie
	Task : config setting for Auto void fb CRM [redmine:#168254]
	DB: DBCRM/bodb_CRM
*/



USE [bodb_CRM]
GO
	

UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = '0' 
WHERE SettingName = 'ConfigUAT'
	AND ServiceName = 'AutoVoidFB'	
	
	
UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = CONVERT( VARCHAR(20),GETDATE(),20)
WHERE SettingName = 'LastDateUAT'
	AND ServiceName = 'AutoVoidFB'		

