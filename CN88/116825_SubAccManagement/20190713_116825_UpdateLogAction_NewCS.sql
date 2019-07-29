/*
	Created by: Elodie
	Date: 20190729
	Task: Update LogAction for New Simplified Chinese (CN88) 
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionNameEN NVARCHAR(256), ActionNameCH NVARCHAR(256), ActionNameCN NVARCHAR(256))

INSERT INTO @tmpAction (ActionID, ActionNameEN, ActionNameCN, ActionNameCH)
SELECT	691, 'Delete sub account', N'删除子账户', N'刪除子帳戶' UNION ALL
SELECT	692, 'Add new managed account for sub account', N'新增子账户管理账户', N'新增子帳戶管理帳戶' UNION ALL
SELECT	693, 'Managed account on sub account', N'子账户管理账户', N'子帳戶管理帳戶'

UPDATE l
SET l.ActionNameCN = t.ActionNameCN,
	l.ActionNameCH = t.ActionNameCH
FROM dbo.LogAction l WITH (ROWLOCK)
	INNER JOIN @tmpAction t ON t.ActionID = l.ActionID
