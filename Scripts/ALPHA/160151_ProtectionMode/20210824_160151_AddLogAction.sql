/*
	Created by: Elodie
	Date: 20210824
	Task: Insert LogAction
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)

INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT 953, 'Reset Protection Code', 'Age_CustomerUpdProtectionCode', 0, 4, NULL UNION ALL
SELECT 954, 'Update Protection Status By Upline', 'Age_CustomerUpdProtectedMode', 0, 4, NULL UNION ALL
SELECT 955, 'Update Protection Status By Login', 'Age_LoginVerifyDownline', 0, 4, NULL UNION ALL
SELECT 956, 'Update Protection Status By Login', 'Age_LoginDownLine', 0, 4, NULL UNION ALL
SELECT 957, 'Update Protection Status By Login', 'Age_LoginDownLine_Sub', 0, 4, NULL UNION ALL
SELECT 1338, 'Login by Protection Code via Agent''s Site', 'Age_LoginVerifyDownline', 0, NULL, NULL UNION ALL
SELECT 1339, 'Login by Protection Code via Agent''s Site', 'Age_LoginDownLine', 0, NULL, NULL UNION ALL
SELECT 1340, 'Login by Protection Code via Agent''s Site', 'Age_LoginDownLine_Sub', 0, NULL, NULL

DELETE FROM LogAction WITH (ROWLOCK) WHERE ActionID IN (SELECT ActionID FROM @tmpAction)

INSERT INTO dbo.LogAction (ActionID, SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName
FROM @tmpAction t

SELECT * 
FROM LogAction WITH (NOLOCK)
WHERE ActionID IN (SELECT ActionID FROM @tmpAction)

GO