/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20210908@Winfred
	Task : config setting for Amendment Notification  CRM [redmine:#157481]
	DB: DBCRM/bodb_CRM
*/



USE [bodb_CRM]
GO

UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = '1'
WHERE SettingName = 'ConfigPRO'
	AND ServiceName = 'AutoVoidFB'
	
