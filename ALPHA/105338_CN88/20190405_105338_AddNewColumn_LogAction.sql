/*
	Created: 20190405@Elodie
	Task: Prepare structure for new credit site
	DB: DBLOG/bodb_CustomerLog
*/

USE bodb_CustomerLog
GO

ALTER TABLE dbo.LogActionType ADD ActionTypeNameCN NVARCHAR(50)
ALTER TABLE dbo.LogAction ADD ActionNameCN NVARCHAR(256)
