/*
	Created: 20201125@Johnson
	Task: initial system setting for TO Control auto FB service [redmine:#145274]
	DB: DBCRM/bodb_CRM
*/


INSERT INTO SystemSetting(SettingName, Value, ServiceName)
SELECT 'JobStatus','Completed','TOControlFB'
UNION SELECT 'ServiceFlag','1','TOControlFB'
UNION SELECT 'BatchSize','10','TOControlFB'
UNION SELECT 'LastLogID','0','TOControlFB'
UNION SELECT 'LastRuntime',CONVERT( VARCHAR(20),GETDATE(),20),'TOControlFB'
UNION SELECT 'ConfigUAT','1','TOControlFB'
UNION SELECT 'ConfigPRO','1','TOControlFB'
UNION SELECT 'IsCredit','1','TOControlFB'
UNION SELECT 'IsDeposit','0','TOControlFB'