/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20220407@Winfred
	Task : config setting for voiding settled tickeds CRM UAT [redmine:#168783]
	DB: DBCRM/bodb_CRM
*/



USE [bodb_CRM]
GO

UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = '1'
WHERE SettingName = 'ConfigUAT'
	AND ServiceName = 'AutoVoidFB'	

UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = CONVERT( VARCHAR(20),GETDATE(),20)
WHERE SettingName = 'LastDateUAT'
	AND ServiceName = 'AutoVoidFB'		