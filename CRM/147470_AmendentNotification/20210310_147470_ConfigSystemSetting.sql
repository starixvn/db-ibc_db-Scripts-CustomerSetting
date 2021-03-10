/*
	Created: Winfred
	Task : config setting for Amendment Notification  CRM [redmine:#147470]
	DB: DBCRM/bodb_CRM
*/



USE [bodb_CRM]
GO

UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = '1'
WHERE SettingName = 'ConfigPRO'
	AND ServiceName = 'AmendmentNotiFB'
	

UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = '0'
WHERE SettingName = 'ConfigUAT'
	AND ServiceName = 'AmendmentNotiFB'	

