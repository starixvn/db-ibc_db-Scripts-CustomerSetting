/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20221012@@Winfred
	Task : Update config UAT TOControl  auto feedback [redmine:#145274]
	DB: DBCRM/bodb_CRM	
*/

USE [bodb_CRM]
GO

UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = 0
WHERE SettingName = 'ConfigUAT'
	AND ServiceName = 'TOControlFB'
GO

