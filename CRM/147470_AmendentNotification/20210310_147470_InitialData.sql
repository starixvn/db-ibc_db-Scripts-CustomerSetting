/*
	Created: 202010303@Winfred
	Task : initial system setting for Amendment Notification  CRM [redmine:#147470]
	DB: DBCRM/bodb_CRM
*/



USE [bodb_CRM]
GO

INSERT INTO SystemSetting(SettingName, Value, ServiceName)
SELECT 'JobStatus','Completed','AmendmentNotiFB'
UNION SELECT 'ServiceFlag','1','AmendmentNotiFB'
UNION SELECT 'BatchSize','10','AmendmentNotiFB'
UNION SELECT 'BatchSizeTicket','3000','AmendmentNotiFB'
UNION SELECT 'LastTicketID','0','AmendmentNotiFB'
UNION SELECT 'LastRuntime',CONVERT( VARCHAR(20),GETDATE(),20),'AmendmentNotiFB'
UNION SELECT 'ConfigUAT','1','AmendmentNotiFB'
UNION SELECT 'ConfigPRO','0','AmendmentNotiFB'
UNION SELECT 'IsCredit','1','AmendmentNotiFB'
UNION SELECT 'IsDeposit','0','AmendmentNotiFB'
UNION SELECT 'LastTicketIDUAT','0','AmendmentNotiFB'
UNION SELECT 'JobStatusUAT','0','AmendmentNotiFB'
UNION SELECT 'LastRuntimeUAT',CONVERT( VARCHAR(20),GETDATE(),20),'AmendmentNotiFB'