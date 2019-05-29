/*
	Created by: Kan
	Date: 20190515
	Task: Insert LogAction for Unique Nickname of MBC
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)

INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT 688, 'Sub account creates nickname', 'Age_CustSubInsNickname', 0, 4, NULL UNION ALL
SELECT 689, 'Sub account sets login option by nickname only', 'Age_CustSubUpdNicknameLoginOnly', 0, 4, NULL UNION ALL
SELECT 690, 'Sub account creates nickname', 'CS_CustSubInsNickname', 0, 4, NULL UNION ALL
SELECT 691, 'Unlock access status for sub account', 'CS_CustSubUnlock', 0, 4, NULL

INSERT INTO dbo.LogAction (ActionID, SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)
GO

DECLARE @tmpActionAgain TABLE (ActionID INT, ActionNameCH NVARCHAR(256), ActionNameCN NVARCHAR(256))

INSERT INTO @tmpActionAgain (ActionID, ActionNameCH, ActionNameCN)
SELECT	688, N'', N'' UNION ALL
SELECT	689, N'此子帳戶僅能使用暱稱登入。', N'此子账户仅能使用昵称登入。' UNION ALL
SELECT	690, N'', N'' UNION ALL
SELECT	691, N'解除鎖定子帳戶', N'解除锁定子账户'

UPDATE l
SET l.ActionNameCN = t.ActionNameCN,
	l.ActionNameCH = t.ActionNameCH
FROM dbo.LogAction l WITH (ROWLOCK)
	INNER JOIN @tmpActionAgain t ON t.ActionID = l.ActionID
