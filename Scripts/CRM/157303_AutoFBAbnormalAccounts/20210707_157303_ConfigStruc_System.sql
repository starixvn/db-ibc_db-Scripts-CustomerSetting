/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20210707@Winfred
	Task : Database structure for Auto generate Feedbacks for Abnormal Accounts CRM [redmine:#157303]
	DB: DBCRM/bodb_CRM
*/
USE [bodb_CRM]
GO


ALTER TABLE crmAutoFeedbackInfo ADD IssueTypeId tinyint
ALTER TABLE crmAutoFeedbackInfo ADD Environment varchar(20)
ALTER TABLE crmMessageImport ADD IsProcessedUAT BIT
ALTER TABLE crmMessageImport ADD CONSTRAINT DF_crmMessageImport_IsProcessedUAT DEFAULT 0 FOR IsProcessedUAT
GO
--SELECT * FROM SystemSetting WHERE ServiceName = 'AutoFB'

INSERT INTO SystemSetting(SettingName, Value, ServiceName)
SELECT 'JobStatusUAT','Completed','AutoFB'
UNION SELECT 'LastRuntimeUAT',CONVERT( VARCHAR(20),GETDATE(),20),'AutoFB'
UNION SELECT 'LastDateUAT',CONVERT( VARCHAR(20),GETDATE(),20),'AutoFB'