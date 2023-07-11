/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20230425@Winfred
	Task: Update Status pro [#RedmineID:#183746]
	DB: DBBOT/bodb_Chatbot
*/

-----------------------------------------------------
--Update functions
Update BotAction Set Status = 0 where ActionID = 49
Update BotFunction Set Status = 0 where FunctionID = 20