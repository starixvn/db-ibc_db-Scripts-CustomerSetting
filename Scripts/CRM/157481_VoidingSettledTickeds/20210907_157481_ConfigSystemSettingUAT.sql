/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20210908@Winfred
	Task : config setting for Amendment Notification  CRM UAT [redmine:#157481]
	DB: DBCRM/bodb_CRM
*/



USE [bodb_CRM]
GO

UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = '0'
WHERE SettingName = 'ConfigUAT'
	AND ServiceName = 'AutoVoidFB'	

