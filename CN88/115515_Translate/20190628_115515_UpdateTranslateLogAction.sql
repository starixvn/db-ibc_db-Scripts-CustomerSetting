/*
	Created by: Elodie
	Date: 20190628
	Task: Update LogAction for New Simplified Chinese (CN88) 
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionNameEN NVARCHAR(256), ActionNameCH NVARCHAR(256), ActionNameCN NVARCHAR(256))

INSERT INTO @tmpAction (ActionID, ActionNameEN, ActionNameCN, ActionNameCH)
SELECT	690, NULL, N'子账户创建登入账号', N'子賬戶創建登入賬號' UNION ALL
SELECT	689, NULL, N'此子账户仅能使用登入账号登入。', N'此子賬戶僅能使用登入賬號登入。'

UPDATE l
SET l.ActionNameCN = t.ActionNameCN,
	l.ActionNameCH = t.ActionNameCH
FROM dbo.LogAction l WITH (ROWLOCK)
	INNER JOIN @tmpAction t ON t.ActionID = l.ActionID
