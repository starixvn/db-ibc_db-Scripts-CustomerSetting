/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20220407@@Winfred
	Task : Update config UAT auto feedback [redmine:#168783]
	DB: DBCRM/bodb_CRM	
*/

USE [bodb_CRM]
GO

UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = 1
WHERE SettingName = 'ConfigUAT'
	AND ServiceName = 'AutoFB'
GO


UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = CONVERT( VARCHAR(20),GETDATE(),20)
WHERE SettingName = 'LastDateUAT'
	AND ServiceName = 'AutoFB'		