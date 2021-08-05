/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20210804@Winfred
	Task : config setting for Abnormal Accounts CRM [redmine:#157303]
	DB: DBCRM/bodb_CRM
*/



USE [bodb_CRM]
GO
	

UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = '1'
WHERE SettingName = 'ConfigUAT'
	AND ServiceName = 'AutoFB'	

