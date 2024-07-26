/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: Luke
	Date: 20240611
	Task:  Telegram Chatbot - Notify Member Last bets [Redmine: #193689]
	DB: DBBOT/bodb_ChatBot
*/


UPDATE f
SET f.Status = 0
FROM BotFunction f WITH (ROWLOCK, UPDLOCK)
WHERE FunctionID IN (23)

UPDATE a
SET a.Status = 0
FROM BotAction a WITH (ROWLOCK, UPDLOCK)
WHERE ActionID IN (54)