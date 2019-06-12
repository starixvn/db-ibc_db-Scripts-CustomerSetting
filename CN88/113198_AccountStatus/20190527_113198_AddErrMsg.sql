/*
	Created by: Elodie
	Date: 20190329
	Task: Insert ErrMsg for sub account of CN88
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @tmpMsg TABLE (MsgID INT, MsgName NVARCHAR(500), MsgGroupId INT, IsActive BIT)

INSERT INTO @tmpMsg (MsgID, MsgName, MsgGroupId, IsActive)
SELECT	40047, 'Update status failed. Upline level is not active.', 5, 1 UNION ALL
SELECT	40043, 'You cannot do this action because this account''s upline is not active.', 5, 1 UNION ALL
SELECT	80009, 'Your account has been inactive. Please contact your upline for assistance.', 5, 1 UNION ALL 
SELECT	80010, 'Your account has been suspended. Please contact your upline to activate your account!', 9, 1 UNION ALL
SELECT	40044, 'Your sub account has been locked due to multiple failed security check attempts. Please contact the main account user to unlock. ', 5, 1 UNION ALL 
SELECT	40045, 'Your account has been locked due to multiple failed security check attempts. Please contact your upline to unlock.', 5, 1 UNION ALL 
SELECT	40046, 'Update status failed. Please try again.', 5, 1

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