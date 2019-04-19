/*
	Created by: Elodie
	Date: 20190418
	Task: Update LogAction for New Simplified Chinese (CN88) 
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

--1056 affected rows
UPDATE l
SET l.ActionNameCN = l.ActionNameEN
FROM dbo.LogAction l WITH (ROWLOCK)
WHERE ActionNameCN IS NULL
