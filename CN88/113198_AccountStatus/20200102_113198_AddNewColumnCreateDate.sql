USE bodb_CustomerLog
GO

ALTER TABLE dbo.CS_UserLog_Credit ADD CreatedDate DATETIME NULL
ALTER TABLE dbo.CS_UserLog_Login ADD CreatedDate DATETIME NULL