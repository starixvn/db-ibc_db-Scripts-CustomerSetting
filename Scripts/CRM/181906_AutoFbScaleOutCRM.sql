/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20230131@Winfred
	Task : Scale Out for CRM [RedmineId : #181906]
	DB: DBCRM/bodb_CRM
*/


ALTER TABLE crmMessageImport ADD VoidingHistoryCollectionId INT
GO

CREATE NONCLUSTERED INDEX IX_VoidingHistoryCollectionId ON dbo.crmMessageImport (VoidingHistoryCollectionId)
GO

INSERT INTO SystemSetting(SettingName,Value,ServiceName,DataType)
SELECT 'MaxVoidingHistoryCollectionId',0,'AutoFB','Int32'
UNION SELECT 'MaxVoidingHistoryCollectionIdUAT',0,'AutoFB','Int32'