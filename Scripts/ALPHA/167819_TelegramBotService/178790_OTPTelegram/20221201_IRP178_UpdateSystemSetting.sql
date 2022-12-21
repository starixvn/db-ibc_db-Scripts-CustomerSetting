/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20221201@Johnson
	Task: Initial system settings for chatbot [#RedmineID:#178790]
	DB: DBBOT/bodb_Chatbot
*/

UPDATE BotResource WITH(ROWLOCK)
SET Value = 'Top X Balance'
WHERE ResourceName = 'Action_Name'
	AND ResourceKey = '15'
	AND Language = 'en-US'
	
INSERT INTO BotResource(ResourceName,ResourceKey,Language,Value)
SELECT 'Action_Name', '43', 'en-US'	,	N'OTP'