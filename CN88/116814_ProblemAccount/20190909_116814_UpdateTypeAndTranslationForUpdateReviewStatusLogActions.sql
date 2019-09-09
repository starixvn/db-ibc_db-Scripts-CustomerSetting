/*
	Created: 20190909@Alvin
	Task: Update Type and Translation for Problem Account Update Review Status LogActions
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

UPDATE l
SET l.ActionTypeID = 6,
	l.ActionNameCN = N'更新总代理审查状态',
	l.ActionNameCH = N'更新總代理審查狀態'
FROM dbo.LogAction l WITH (NOLOCK)
WHERE l.ActionID = 31608

UPDATE l
SET l.ActionTypeID = 6,
	l.ActionNameCN = N'更新代理商审查状态',
	l.ActionNameCH = N'更新代理商審查狀態'
FROM dbo.LogAction l WITH (NOLOCK)
WHERE l.ActionID = 31609

UPDATE l
SET l.ActionTypeID = 6,
	l.ActionNameCN = N'更新会员审查状态',
	l.ActionNameCH = N'更新會員審查狀態'
FROM dbo.LogAction l WITH (NOLOCK)
WHERE l.ActionID = 31610