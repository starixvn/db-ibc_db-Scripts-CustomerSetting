/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
USE bodb_CRM
GO

/*
	Created: 20221123@Winfred
	DB: DBCRM.bodb_CRM
	Task:  Add config feadback Archiving Dormant Accounts
	Revisions:
		- 20221123@Winfred:  Add config feadback Archiving Dormant Accounts [RedmineID: #158258]
*/

DECLARE @ServiceName VARCHAR(100) = 'ArchivedAccountFB'

INSERT INTO SystemSetting(SettingName, Value, ServiceName,DataType)
SELECT 'JobStatusUAT','Completed',@ServiceName,'String'
UNION SELECT 'BatchSize','10',@ServiceName,'Int32' 
UNION SELECT 'BatchSizeTicket','3000',@ServiceName,'Int32' 
UNION SELECT 'IsSyncArchivedAccount','1',@ServiceName,'Boolean'
UNION SELECT 'ConfigUAT','1',@ServiceName,'Boolean'
UNION SELECT 'ConfigPRO','0',@ServiceName,'Boolean'
UNION SELECT 'IsCredit','1',@ServiceName,'Boolean'
UNION SELECT 'IsDeposit','0',@ServiceName,'Boolean'
UNION SELECT 'JobStatus','Completed',@ServiceName,'String'
UNION SELECT 'LastRuntimeUAT',CONVERT( VARCHAR(20),GETDATE(),20),@ServiceName,'DateTime'
UNION SELECT 'LastRuntime',CONVERT( VARCHAR(20),GETDATE(),20),@ServiceName,'DateTime'
UNION SELECT 'ServiceFlag','1',@ServiceName,'Boolean'
UNION SELECT 'ServiceID','1',@ServiceName,'Int32' 
UNION SELECT 'MaxLogFBId','100',@ServiceName,'Int32' 