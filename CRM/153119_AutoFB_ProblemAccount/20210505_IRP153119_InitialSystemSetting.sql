/*
	Created: 20210505@Johnson
	Task : Initial data for system setting for auto feedback ProblemAccount[redmine:#153119]
	DB: DBCRM/bodb_CRM	
*/

INSERT INTO SystemSetting(SettingName, Value, ServiceName)
SELECT 'JobStatus','Completed','ProblemAccountFB'
UNION SELECT 'JobStatusUAT','Completed','ProblemAccountFB'
UNION SELECT 'ServiceFlag','1','ProblemAccountFB'
UNION SELECT 'BatchSize','3000','ProblemAccountFB'
UNION SELECT 'LastLogIdUAT','2028','ProblemAccountFB'
UNION SELECT 'LastLogID','2028','ProblemAccountFB'
UNION SELECT 'LastRuntime',CONVERT( VARCHAR(20),GETDATE(),20),'ProblemAccountFB'
UNION SELECT 'LastRuntimeUAT',CONVERT( VARCHAR(20),GETDATE(),20),'ProblemAccountFB'
UNION SELECT 'ConfigUAT','1','ProblemAccountFB'
UNION SELECT 'ConfigPRO','1','ProblemAccountFB'
