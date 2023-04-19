/*<info serverAlias="DBMSG-bodb_Message"></info>*/
/*
	Created: 20230224@Tacy
	Task: Update systems on table [Announcements]
		 https://nexdev.net/issues/181596 [RedmineID: #181596]

	Database: DBMSG-bodb_Message
*/

USE bodb_Message
GO

--Update: 
/*
Current: B-
Expected: Bot-
*/
UPDATE a
SET a.Systems = REPLACE(a.Systems, 'B-', 'Bot-')
FROM Announcements a WITH (ROWLOCK, UPDLOCK)
WHERE Systems LIKE '%B-%'

/*
Current: IBCBet, 789y, IBCIndo
Expected: Nova88, 789y, IBC
*/
UPDATE a
SET a.Systems = REPLACE(a.Systems, 'IBCBet', 'Nova88')
FROM Announcements a WITH (ROWLOCK, UPDLOCK)
WHERE Systems LIKE '%IBCBet%'

UPDATE a
SET a.Systems = REPLACE(a.Systems, 'IBCIndo', 'IBC')
FROM Announcements a WITH (ROWLOCK, UPDLOCK)
WHERE Systems LIKE '%IBCIndo%'