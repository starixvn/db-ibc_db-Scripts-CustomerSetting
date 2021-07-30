/*<info serverAlias="DBARCCUST-bodb_Customer"></info>*/
/*
	Created: 20210607@Tina
	Task: All Sites - Lock account & indirect close account [redmine: #148600]
	DB: DBARCCUST.bodb_Customer
*/
USE [bodb_Customer]
GO
IF NOT EXISTS (SELECT 1
				FROM sys.tables t 
					JOIN sys.columns c ON t.object_id = c.object_id
				WHERE t.name = 'CustBackupClosed' AND C.name = 'CloseInfo')
BEGIN
	ALTER TABLE CustBackupClosed ADD CloseInfo TINYINT NULL CONSTRAINT DF_CustBackupClosed_CloseInfo DEFAULT (0);
END

IF NOT EXISTS (SELECT 1
				FROM sys.tables t 
					JOIN sys.columns c ON t.object_id = c.object_id
				WHERE t.name = 'CustBackupClosed' AND C.name = 'SuspendInfo')
BEGIN
	ALTER TABLE CustBackupClosed ADD SuspendInfo TINYINT NULL CONSTRAINT DF_CustBackupClosed_SuspendInfo DEFAULT (0);
END

IF NOT EXISTS (SELECT 1
				FROM sys.tables t 
					JOIN sys.columns c ON t.object_id = c.object_id
				WHERE t.name = 'CustBackupClosed' AND C.name = 'ClosedReason')
BEGIN
	ALTER TABLE CustBackupClosed ADD ClosedReason TINYINT NULL
END