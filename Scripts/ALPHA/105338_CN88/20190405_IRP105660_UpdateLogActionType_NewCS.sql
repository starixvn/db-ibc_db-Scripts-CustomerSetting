/*
	Created by: Elodie
	Date: 20190405
	Task: Update LogAction for New Simplified Chinese (CN88) 
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

UPDATE l
SET l.ActionTypeNameCN = N'占成数',
	l.ActionTypeNameCH = N'佔成數'
FROM dbo.LogActionType l WITH (ROWLOCK)
WHERE l.ActionTypeID = 1

UPDATE l
SET l.ActionTypeNameCN = N'退水',
	l.ActionTypeNameCH = N'退水'
FROM dbo.LogActionType l WITH (ROWLOCK)
WHERE l.ActionTypeID = 2

UPDATE l
SET l.ActionTypeNameCN = N'投注限额',
	l.ActionTypeNameCH = N'投注限額'
FROM dbo.LogActionType l WITH (ROWLOCK)
WHERE l.ActionTypeID = 3

UPDATE l
SET l.ActionTypeNameCN = N'一般信息',
	l.ActionTypeNameCH = N'一般資訊'
FROM dbo.LogActionType l WITH (ROWLOCK)
WHERE l.ActionTypeID = 4
