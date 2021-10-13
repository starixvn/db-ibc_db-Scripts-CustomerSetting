/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20210908@Winfred
	Task : initial system setting for voiding settle Amendment Notification  CRM [redmine:#157481]
	DB: DBCRM/bodb_CRM
*/



USE [bodb_CRM]
GO

DELETE FROM SystemSetting WHERE ServiceName = 'AutoVoidFB'

INSERT INTO SystemSetting(SettingName, Value, ServiceName)
SELECT 'JobStatus','Completed','AutoVoidFB'
UNION SELECT 'ServiceFlag','1','AutoVoidFB'
UNION SELECT 'BatchSize','10','AutoVoidFB'
UNION SELECT 'LastLogID','1','AutoVoidFB'
UNION SELECT 'LastRuntime',CONVERT( VARCHAR(20),GETDATE(),20),'AutoVoidFB'
UNION SELECT 'ConfigUAT','1','AutoVoidFB'
UNION SELECT 'ConfigPRO','0','AutoVoidFB'
UNION SELECT 'IsCredit','1','AutoVoidFB'
UNION SELECT 'IsDeposit','0','AutoVoidFB'
UNION SELECT 'LastLogIDUAT','1','AutoVoidFB'
UNION SELECT 'LastDateUAT',CONVERT( VARCHAR(20),GETDATE(),20),'AutoVoidFB'
UNION SELECT 'JobStatusUAT','Completed','AutoVoidFB'
UNION SELECT 'LastRuntimeUAT',CONVERT( VARCHAR(20),GETDATE(),20),'AutoVoidFB'