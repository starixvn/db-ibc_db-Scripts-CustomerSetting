/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20230425@Winfred
	Task: Update Notify abnormal login via Telegram chatbot [#RedmineID:#183746]
	DB: DBBOT/bodb_Chatbot
*/

-----------------------------------------------------
--Update functions
Update BotFunction Set Priority = 3, Type = 2 where FunctionID = 20
