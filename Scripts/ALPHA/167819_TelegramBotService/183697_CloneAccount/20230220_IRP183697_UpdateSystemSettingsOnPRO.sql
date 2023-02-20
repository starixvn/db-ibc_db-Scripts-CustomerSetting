/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20230220@Johnson
	Task: update system settings for chatbot on PRO [#RedmineID:#183697]
	DB: DBBOT/bodb_Chatbot
*/

UPDATE BotFunction WITH(ROWLOCK)
SET status = 0
WHERE FunctionID = 18
GO

UPDATE BotAction WITH(ROWLOCK)
SET Status = 0
WHERE ActionID IN (46,47)