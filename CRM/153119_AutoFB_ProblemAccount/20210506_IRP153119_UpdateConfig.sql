/*
	Created: 20210505@Johnson
	Task : update system setting for auto feedback ProblemAccount[redmine:#153119]
	DB: DBCRM/bodb_CRM	
*/
--step 1: turn on PRO service
--get max logID of CustCategoryHistory at DBCUST/CustDB
declare @logid INT

SELECT @logid = max(logid)
FROM DBCUST.CustDB.dbo.CustCategoryHistory WITH(NOLOCK)

UPDATE SystemSetting
SET Value = @logid--maxLogID get from DBCUST
WHERE settingName = 'LastLogID'
	AND ServiceName = 'ProblemAccountFB'
	
UPDATE SystemSetting
SET Value = 1
WHERE settingName = 'ConfigPRO'
	AND ServiceName = 'ProblemAccountFB'	
GO

--step 2: config UAT ON 
UPDATE SystemSetting
SET Value = 1
WHERE settingName = 'ConfigUAT'
	AND ServiceName = 'ProblemAccountFB'

UPDATE SystemSetting
SET Value = 0--maxLogID get from DBCUST
WHERE settingName = 'LastLogID_UAT'
	AND ServiceName = 'ProblemAccountFB'
GO

--step 3: turn off UAT service	
UPDATE SystemSetting
SET Value = 0
WHERE settingName = 'ConfigUAT'
	AND ServiceName = 'ProblemAccountFB'