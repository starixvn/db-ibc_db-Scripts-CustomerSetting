/*
	Created by: Johnson	
	Date: 20190327
	Task: Insert LogAction for tier0
	DB: DBLOG/bodb_CustomerLog
*/

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT)

INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId)
SELECT	937, 'Reset Password', 'CS_Acc_CustomerUpdPwdReset', 0, 4 UNION ALL
SELECT	938, 'Reset downline''s password', 'CS_Age_CustomerUpdPwd', 0, 4 


INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)