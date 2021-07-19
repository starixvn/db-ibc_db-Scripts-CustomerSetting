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
