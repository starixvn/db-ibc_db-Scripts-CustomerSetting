/*
	Created by: Elodie
	Date: 20190329
	Task: Insert LogAction for Sub account of CN88
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)

INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT	685, 'Add new sub account', 'CS_CustSubIns', 0, 4, NULL UNION ALL
SELECT	686, 'Update sub account', 'CS_CustSubUpd', 0, 4, NULL

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)

/*
--DELETE dbo.LogAction WHERE ActionID >= 100000 OR ActionID BETWEEN 1213 AND 1216
--DELETE dbo.LogActionDetail WHERE ActionID >= 100000

SELECT * FROM dbo.LogAction WHERE ActionID > 100000
SELECT * FROM dbo.LogActionDetail INNER JOIN LogAction ON  WHERE ActionID > 100000
*/