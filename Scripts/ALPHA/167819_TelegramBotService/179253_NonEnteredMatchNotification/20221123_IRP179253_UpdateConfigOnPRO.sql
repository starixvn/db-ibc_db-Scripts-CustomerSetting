/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20221123@Johnson
	Task: updated config on PRO [#RedmineID:#179253]
	DB: DBBOT/bodb_Chatbot
*/

UPDATE b
SET Status = 0
FROM BotAction b WITH(ROWLOCK)
WHERE ActionID IN (44)
GO
