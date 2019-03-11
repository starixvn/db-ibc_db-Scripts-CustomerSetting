/*
	Created by: Johnson	
	Date: 20190221
	Task: Insert LogAction for tier0
	DB: DBLOG/bodb_CustomerLog
*/

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT)

INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId)
SELECT	934, 'Account closed by failed login 5 times', 'CS_AdminLoginVerifyBefore', 0, 4 UNION ALL
SELECT	1324, 'Login via Agent''s Site', 'CS_AdminLoginVerifyBefore', 0, NULL UNION ALL
SELECT	1325, 'Login via Agent''s Site', 'CS_AdminLoginVerifyBefore', 1, NULL UNION ALL
SELECT	935, 'Reset own Security Code', 'CS_Customer_SecurityCode_upd', 0, NULL UNION ALL
SELECT	936, 'Reset Security Code of downline', 'CS_Customer_SecurityCode_upd', 0, NULL 


INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)