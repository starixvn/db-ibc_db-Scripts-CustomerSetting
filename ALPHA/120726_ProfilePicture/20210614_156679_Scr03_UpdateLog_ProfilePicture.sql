/*
	Created by: Elodie
	Date: 20210614
	Task: Update log for Profile picture
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

CREATE TABLE #tmpLog (LogId BIGINT, ActionId INT)

INSERT INTO #tmpLog (LogId, ActionId)
SELECT LogId, ActionId
FROM UserLog_RunSP ul WITH (NOLOCK)
WHERE ActionId IN (700, 701)
	AND TrackingValue LIKE '<R ImageId%'

UPDATE ul
SET ul.ActionID = CASE WHEN t.ActionId = 700 THEN 95000 ELSE 95001 END
FROM UserLog_RunSP ul WITH (ROWLOCK)
	INNER JOIN #tmpLog t ON ul.logid = t.logid