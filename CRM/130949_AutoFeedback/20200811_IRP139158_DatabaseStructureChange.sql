/*
	Created: 20200811@Johnson
	Task: CRM - Missing create feedback for Void Abnormal Bet [redemine: #139158]
	DB: DBCRM/bodb_CRM
*/

ALTER TABLE crmMessageImport ADD RequestID INT 
GO

ALTER TABLE crmMessageImport ADD CONSTRAINT DF_crmMessageImport_IsProcessed DEFAULT 0 FOR IsProcessed
GO

ALTER TABLE  SystemSetting ADD ServiceName VARCHAR(100)
GO

UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET ServiceName = 'AutoFB'