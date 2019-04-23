/*
	Created by: Elodie
	Date: 20190423
	Task: Update LogAction for New Simplified Chinese (CN88) 
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionNameCH NVARCHAR(256), ActionNameCN NVARCHAR(256))

INSERT INTO @tmpAction (ActionID, ActionNameCH, ActionNameCN)
SELECT	685, N'增加新的子帳戶', N'增添新的子账户' UNION ALL
SELECT	686, N'更新子帳戶', N'更新子账户' UNION ALL
SELECT	904, N'子帳戶已變更其密碼。', N'子帐户已变更其密码。' UNION ALL
SELECT	919, N'子账户已重置其安全代码。', N'子帳戶已重設其安全密碼。'


UPDATE l
SET l.ActionNameCN = t.ActionNameCN,
	l.ActionNameCH = t.ActionNameCH
FROM dbo.LogAction l WITH (ROWLOCK)
	INNER JOIN @tmpAction t ON t.ActionID = l.ActionID
