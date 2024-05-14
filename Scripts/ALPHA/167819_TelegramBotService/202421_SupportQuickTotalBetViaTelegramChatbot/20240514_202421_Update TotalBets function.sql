/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20240514@Kelvin	
	Task: Set up config TotalBets function [Redmine: #202421]
	DB: DBBOT/bodb_Chatbot
*/

UPDATE [BotFunction]
SET [Status] = 0
WHERE [FunctionID] = 24

UPDATE [BotAction]
SET [Status] = 0
WHERE ActionID = 55
				 



