/*
	Created by: Elodie
	Date: 20190524
	Task: Insert LogAction for login process of CN88
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)

INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT	687, 'Create nickname', 'CS_CustomerInsNickName', 0, 4, NULL UNION ALL
SELECT	939, 'Sub account is locked due to failed logins 5 times', 'CS_LoginVerifyDownline', 0, 4, NULL UNION ALL
SELECT	940, 'Account is locked due to failed logins 5 times', 'CS_LoginVerifyDownline', 0, 4, NULL UNION ALL
SELECT	1326, 'Login via Agent''s Site', 'CS_LoginVerifyDownline', 0, NULL, NULL UNION ALL
SELECT	1327, 'Login via Agent''s Site', 'CS_LoginVerifyDownline', 1, NULL, NULL UNION ALL
SELECT	1328, 'Login via Agent''s Site', 'CS_LoginVerifyDownline', 1, NULL, NULL UNION ALL
SELECT	1329, 'Login via Agent''s Site', 'CS_LoginClaimDownline', 1, NULL, NULL 

DELETE l FROM dbo.LogAction l INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)
