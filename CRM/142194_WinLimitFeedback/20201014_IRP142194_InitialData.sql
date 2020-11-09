/*
	Created: 20201014@@Johnson
	Task : Initial data for system setting for auto feedback winlimit[redmine:#142194]
	DB: DBCRM/bodb_CRM	
*/

INSERT INTO SystemSetting(SettingName, Value, ServiceName)
SELECT 'JobStatus','Completed','WinLimitFB'
UNION SELECT 'ServiceFlag','1','WinLimitFB'
UNION SELECT 'BatchSize','10','WinLimitFB'
UNION SELECT 'LastLogID','55138','WinLimitFB'
UNION SELECT 'LastRuntime',CONVERT( VARCHAR(20),GETDATE(),20),'WinLimitFB'
UNION SELECT 'ConfigUAT','1','WinLimitFB'
UNION SELECT 'ConfigPRO','0','WinLimitFB'
UNION SELECT 'IsCredit','1','WinLimitFB'
UNION SELECT 'IsDeposit','0','WinLimitFB'