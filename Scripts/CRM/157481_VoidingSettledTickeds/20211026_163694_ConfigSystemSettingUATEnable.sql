/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20211026@Winfred
	Task : config setting for Amendment Notification  CRM UAT [redmine:#163694]
	DB: DBCRM/bodb_CRM
*/



USE [bodb_CRM]
GO

UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = '1'
WHERE SettingName = 'ConfigUAT'
	AND ServiceName = 'AutoVoidFB'	

