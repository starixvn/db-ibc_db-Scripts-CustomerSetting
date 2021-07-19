/*
	Created by: Elodie
	Date: 20190709
	Task: Update LogAction for New Simplified Chinese (CN88) 
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionNameEN NVARCHAR(256), ActionNameCH NVARCHAR(256), ActionNameCN NVARCHAR(256))

INSERT INTO @tmpAction (ActionID, ActionNameEN, ActionNameCN, ActionNameCH)
SELECT	1217, 'Update Member''s Credits', N'', N'' UNION ALL
SELECT	1218, 'Update Agent''s Credits', N'', N'' UNION ALL
SELECT	1219, 'Update Master Agent''s Credits', N'', N'' UNION ALL
SELECT	1220, 'Update SMA''s Credits', N'', N''

UPDATE l
SET l.ActionNameEN = t.ActionNameEN
FROM dbo.LogAction l WITH (ROWLOCK)
	INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

SELECT * FROM dbo.LogAction WHERE ActionID BETWEEN 1217 AND 1220