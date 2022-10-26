/*
	Created: 20221020@Johnson
	Task : update system setting for auto feedback ProblemAccount[redmine:#179370]
	DB: DBCRM/bodb_CRM	
*/

--step 1: config UAT ON 
--get max logID of CustCategoryHistory at DBCUST/CustDB
declare @logid INT

SELECT @logid = max(logid)
FROM DBCUST.CustDB.dbo.CustCategoryHistory WITH(NOLOCK)

UPDATE SystemSetting
SET Value = 1
WHERE settingName = 'ConfigUAT'
	AND ServiceName = 'ProblemAccountFB'

UPDATE SystemSetting
SET Value = @logid--maxLogID get from DBCUST
WHERE settingName = 'LastLogIdUAT'
	AND ServiceName = 'ProblemAccountFB'
GO

/*
--step 2: turn off UAT service	
UPDATE SystemSetting
SET Value = 0
WHERE settingName = 'ConfigUAT'
	AND ServiceName = 'ProblemAccountFB'
*/	