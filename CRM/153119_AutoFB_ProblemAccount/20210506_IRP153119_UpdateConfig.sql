/*
	Created: 20210505@Johnson
	Task : update system setting for auto feedback ProblemAccount[redmine:#153119]
	DB: DBCRM/bodb_CRM	
*/
--step 1: turn on UAT service
--get max logID of CustCategoryHistory at DBCUST/CustDB
SELECT max(logid)
FROM CustCategoryHistory (NOLOCK)
GO

UPDATE SystemSetting
SET Value = 1
WHERE settingName = 'ConfigUAT'
	AND ServiceName = 'ProblemAccountFB'

UPDATE SystemSetting
SET Value = 0--maxLogID get from DBCUST
WHERE settingName = 'LastLogID_UAT'
	AND ServiceName = 'ProblemAccountFB'
GO

--step 2: turn off UAT service	
UPDATE SystemSetting
SET Value = 0
WHERE settingName = 'ConfigUAT'
	AND ServiceName = 'ProblemAccountFB'