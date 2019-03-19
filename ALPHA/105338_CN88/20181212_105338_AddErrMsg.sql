/*
	Created by: Elodie
	Date: 20181212
	Task: Insert ErrMsg for new credit site
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @tmpMsg TABLE (MsgID INT, MsgName NVARCHAR(500), MsgGroupId INT, IsActive BIT)

INSERT INTO @tmpMsg (MsgID, MsgName, MsgGroupId, IsActive)
SELECT	11, 'Please refresh the page and try again. Commission is out of range.', 1, 1 UNION ALL

SELECT	10040, 'Wrong Max per Bet/ Max per Event.', 2, 1 UNION ALL
SELECT	10041, 'Max per Bet must be less than Max per Event.', 2, 1 UNION ALL
SELECT	10042, 'Max per Bet is out of range.', 2, 1 UNION ALL
SELECT	10043, 'Max per Event is out of range.', 2, 1 UNION ALL

SELECT	20035, 'New SMA Possess is too low. It makes some lines'' Total Possess Taken become less than SMA Min Possess.', 3, 1 UNION ALL
SELECT	20036, 'New SMA Possess is too high. It makes some lines'' Total Possess Taken become greater than SMA Max Possess.', 3, 1 UNION ALL
SELECT	20037, 'Master Agent & Agent''s Total Possess is too low. It makes the line''s Total Possess less than SMA Min Possess.', 3, 1 UNION ALL
SELECT	20038, 'Master Agent & Agent''s Total Possess is too high. It makes the line''s Total Possess greater than SMA Max Possess.', 3, 1 UNION ALL
SELECT	20039, 'Master Agent''s Possess is too high. It makes the line''s Total Possess greater than SMA Max Possess.', 3, 1 UNION ALL
SELECT	20040, 'Agent''s Possess is too high. It makes the line''s Total Possess greater than SMA Max Possess.', 3, 1 UNION ALL
SELECT	20041, 'Wrong possess.', 3, 1 UNION ALL
SELECT	20042, 'You cannot update new possess value at this moment.', 3, 1 UNION ALL
SELECT	20043, 'Conflict between current possess and new possess values. Please try again after the new possess value takes effect.', 3, 1 UNION ALL

SELECT	30007, 'New SMA Min Possess is greater than the Total Possess Taken by some lines.', 3, 1 UNION ALL
SELECT	30008, 'New SMA Max Possess is less than the Total Possess Taken by some lines.', 3, 1 UNION ALL
SELECT	30009, 'SMA Min Possess must be less than or equal to SMA Max Possess.', 3, 1 UNION ALL

SELECT	40041, 'Invalid Headline.', 5, 1 UNION ALL

SELECT	70024, 'Insufficient credit.', 8, 1 UNION ALL
SELECT	70025, 'Credit must be positive.', 8, 1 

DELETE m
FROM dbo.MsgError m
	INNER JOIN @tmpMsg t ON t.MsgID = m.MsgID

INSERT INTO dbo.MsgError (MsgID, MsgGroupID, MsgNameEN, MsgNameCT, MsgNameCS, MsgNameJP, MsgNameTH, MsgNameKO, MsgNameES, MsgNameVI, IsActive, MsgNameCN)
SELECT t.MsgID, t.MsgGroupId, t.MsgName, t.MsgName, t.MsgName, t.MsgName, t.MsgName, t.MsgName, t.MsgName, t.MsgName, t.IsActive, t.MsgName
FROM @tmpMsg t
WHERE NOT EXISTS (SELECT 1 FROM MsgError WHERE MsgID = t.MsgID)

--SELECT * FROM dbo.MsgError WHERE MsgID > 100000