/*
	Created by: Elodie
	Date: 20190405
	Task: Update LogAction for New Simplified Chinese (CN88) 
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

UPDATE l
SET l.ActionNameCN = '占成数'
FROM dbo.LogActionType l WITH (ROWLOCK)
WHERE l.ActionTypeID = 1

UPDATE l
SET l.ActionNameCN = '退水'
FROM dbo.LogActionType l WITH (ROWLOCK)
WHERE l.ActionTypeID = 2

UPDATE l
SET l.ActionNameCN = '投注限额'
FROM dbo.LogActionType l WITH (ROWLOCK)
WHERE l.ActionTypeID = 3

UPDATE l
SET l.ActionNameCN = '一般信息'
FROM dbo.LogActionType l WITH (ROWLOCK)
WHERE l.ActionTypeID = 4