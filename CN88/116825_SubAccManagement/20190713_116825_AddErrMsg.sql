/*
	Created by: Elodie
	Date: 20190715
	Task: Insert ErrMsg for sub account of CN88
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @tmpMsg TABLE (MsgID INT, MsgName NVARCHAR(500), MsgGroupId INT, IsActive BIT)

INSERT INTO @tmpMsg (MsgID, MsgName, MsgGroupId, IsActive)
SELECT	40048, 'Delete sub-account failed. Please try again.', 5, 1 UNION ALL
SELECT	40049, 'Action failed. Please try again.', 5, 1 UNION ALL
SELECT 40050, 'You do not have any Managed Accounts selected.Please select a Managed Account or select"All"', 5, 1

DELETE m 
FROM MsgError m 
	INNER JOIN @tmpMsg t ON t.MsgID = m.MsgID

INSERT INTO dbo.MsgError (MsgID, MsgGroupID, MsgNameEN, MsgNameCT, MsgNameCS, MsgNameJP, MsgNameTH, MsgNameKO, MsgNameES, MsgNameVI, IsActive, MsgNameCN)
SELECT t.MsgID, t.MsgGroupId, t.MsgName, t.MsgName, t.MsgName, t.MsgName, t.MsgName, t.MsgName, t.MsgName, t.MsgName, t.IsActive, t.MsgName
FROM @tmpMsg t
WHERE NOT EXISTS (SELECT 1 FROM MsgError WHERE MsgID = t.MsgID)

--SELECT * 
--FROM MsgError m 
--	INNER JOIN @tmpMsg t ON t.MsgID = m.MsgID