/*	
	Created: Elodie
	Date: 2019-05-03
	Task: Add log action
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT)

INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId)
SELECT	1221, 'Remove the unused account''s credit by IT Admin', '', 0, NULL

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)
