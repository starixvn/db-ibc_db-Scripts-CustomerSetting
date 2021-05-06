/*
	Created: 20210505@Johnson
	Task : Initial data for system setting for auto feedback ProblemAccount[redmine:#153119]
	DB: DBCRM/bodb_CRM	
*/

INSERT INTO SystemSetting(SettingName, Value, ServiceName)
SELECT 'JobStatus','Completed','ProblemAccountFB'
UNION SELECT 'ServiceFlag','1','ProblemAccountFB'
UNION SELECT 'BatchSize','10','ProblemAccountFB'
UNION SELECT 'LastLogID','0','ProblemAccountFB'
UNION SELECT 'LastRuntime',CONVERT( VARCHAR(20),GETDATE(),20),'ProblemAccountFB'
UNION SELECT 'ConfigUAT','1','ProblemAccountFB'
UNION SELECT 'ConfigPRO','0','ProblemAccountFB'
UNION SELECT 'IsCredit','1','ProblemAccountFB'
UNION SELECT 'IsDeposit','0','ProblemAccountFB'