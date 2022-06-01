/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20220408@Johnson
	Task: Initial system setting for telegram bot service [#RedmineID:#167819]
	DB: DBBOT/bodb_Chatbot
*/

;WITH T AS (
SELECT 	'Function_Description'	ResourceName,	'5'	ResourceKey,	'en-US'	Language,	'Daily send the total row of Alpha Win Loss report of yesterday at 3:00PM (GMT-4)' Value
)
UPDATE b
SET b.VALUE = t.value
FROM BotResource b
	INNER JOIN T ON b.ResourceName = t.ResourceName 
					AND b.ResourceKey = t.ResourceKey
					AND b.Language = t.Language
GO