USE [bodb_CustomerLog]
GO

/*
	Created: 20190411@Percy
	DB: DBLOG.bodb_CustomerLog
	Task: CN88 -- Correct translation
*/

UPDATE.dbo.LogAction WITH (ROWLOCK, UPDLOCK)
SET ActionNameCH = N'為會員建立帳戶狀態'
WHERE ActionID = 165002