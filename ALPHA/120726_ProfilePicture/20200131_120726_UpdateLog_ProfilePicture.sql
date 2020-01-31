/*
	Created by: Elodie
	Date: 20200131
	Task: Update log for Profile picture
	DB: DBLOG/bodb_CustomerLog
*/

UPDATE ul
SET ul.ActionID = 95001
FROM UserLog_RunSP ul WITH (NOLOCK)
WHERE ActionId = 701
	AND TrackingValue LIKE '<R ImageId%'

UPDATE ul
SET ul.ActionID = 95000
FROM UserLog_RunSP ul WITH (NOLOCK)
WHERE ActionId = 700
	AND TrackingValue LIKE '<R ImageId%'