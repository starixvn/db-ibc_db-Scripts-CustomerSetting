/*
	Created by: Kan
	Date: 20190612
	Task: Insert LogAction for Unique Nickname of CN88
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

-- CH: Traditional, CN: CN88, CS: Simplify
DECLARE @tmpAction TABLE (ActionID INT, ActionNameCH NVARCHAR(256), ActionNameCN NVARCHAR(256))

INSERT INTO @tmpAction (ActionID, ActionNameCH, ActionNameCN)
SELECT	690, N'子帳戶建立暱稱', N'子账户创建昵称' UNION ALL
SELECT	691, N'解除鎖定子帳戶', N'解除锁定子账户'

UPDATE l
SET l.ActionNameCN = t.ActionNameCN,
	l.ActionNameCH = t.ActionNameCH
FROM dbo.LogAction l WITH (ROWLOCK)
	INNER JOIN @tmpAction t ON t.ActionID = l.ActionID
GO
