/*
	Created by: Elodie
	Date: 20181212
	Task: Insert ErrMsg for new credit site
	DB: DBLOG/bodb_CustomerLog
*/
USE CustDB
GO

DECLARE @tmpMsg TABLE (MsgID INT, MsgName NVARCHAR(500), MsgGroupId INT, IsActive BIT)

INSERT INTO @tmpMsg (MsgID, MsgName, MsgGroupId, IsActive)
SELECT	11, 'Commission is out of range.', 1, 1 UNION ALL

SELECT	10040, 'Wrong Max bet/ Max per match.', 2, 1 UNION ALL
SELECT	10041, 'Max bet must be less than max bet per match.', 2, 1 UNION ALL
SELECT	10042, 'Max bet is out of range.', 2, 1 UNION ALL

SELECT	20035, 'New Super PT is too low. It makes some lines'' Total PT Taken become less than Super Min PT', 3, 1 UNION ALL
SELECT	20036, 'New Super PT is too high. It makes some lines'' Total PT Taken become greater than Super Max PT', 3, 1 UNION ALL
SELECT	20037, 'Master & Agent''s Total PT is too low. It makes the line''s Total PT less than Super Min PT', 3, 1 UNION ALL
SELECT	20038, 'Master & Agent''s Total PT is too high. It makes the line''s Total PT greater than Super Max PT', 3, 1 UNION ALL
SELECT	30007, 'New Super Min PT is greater than the Total PT Taken by some lines.', 3, 1 UNION ALL
SELECT	30008, 'New Super Max PT is less than the Total PT Taken by some lines.', 3, 1 UNION ALL
SELECT	30009, 'Super Min PT must be less than or equal to Super Max PT.', 3, 1 UNION ALL

SELECT	70024, 'Insufficient credit.', 8, 1 

INSERT INTO dbo.MsgError (MsgID, MsgGroupID, MsgNameEN, MsgNameCT, MsgNameCS, MsgNameJP, MsgNameTH, MsgNameKO, MsgNameES, MsgNameVI, IsActive, MsgNameCN)
SELECT t.MsgID, t.MsgGroupId, t.MsgName, t.MsgName, t.MsgName, t.MsgName, t.MsgName, t.MsgName, t.MsgName, t.MsgName, t.IsActive, t.MsgName
FROM @tmpMsg t
--WHERE NOT EXISTS (SELECT 1 FROM MsgError WHERE MsgID = t.MsgID)

--DELETE dbo.MsgError WHERE ActionID > 100000

--SELECT * FROM dbo.MsgError WHERE MsgID > 100000