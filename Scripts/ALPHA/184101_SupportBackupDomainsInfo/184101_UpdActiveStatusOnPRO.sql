/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20230315@Helios
	Task: Initial data system setting for Backup Domain telegram bot service [#RedmineID:#184101]
	DB: DBBOT/bodb_Chatbot
	Original:

	Revisions:  
	- 20230315@Helios : Update Status Active on Production
*/
use bodb_Chatbot

--SELECT * 
UPDATE BF SET Status = 0
FROM BotFunction BF WITH (ROWLOCK , UPDLOCK) 
WHERE FunctionKey = 'AvailableDomains'

--SELECT *
UPDATE BA SET Status = 0
FROM BotAction BA WITH (ROWLOCK , UPDLOCK) 
WHERE ActionName = 'Available Domains' 
