/*
	Created by: Elodie
	Date: 20210914
	Task: Update LogAction
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

UPDATE l
SET l.IsInternal = 0
FROM dbo.LogAction l WITH (ROWLOCK)
WHERE l.ActionID = 1221
