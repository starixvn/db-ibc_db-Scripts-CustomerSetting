/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20220822@Johnson
	Task: update database structure for telegram bot service [#RedmineID:#165682]
	DB: DBBOT/bodb_Chatbot
*/

UPDATE b
SET Status = 0
FROM BotAction b WITH(ROWLOCK)
WHERE ActionID IN (33,41,42)
GO

UPDATE b
SET Status = 0
FROM BotFunction b WITH(ROWLOCK)
WHERE ActionID IN (11,13,14)
GO