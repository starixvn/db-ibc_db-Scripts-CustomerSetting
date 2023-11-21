/*<info serverAlias="DBBOT-bodb_chatbot"></info>*/
/*
	Created: 20231110@Johnson
	Task: Add Bot System for 7a5555
	DB: DBBOT/bodb_chatbot
*/
/*
INSERT INTO [dbo].[Bot]
           ([username]
           ,[System]
           ,[Accesstoken]
           ,[Status]
           ,[IsTest]
           ,[DisplayName])
SELECT 'AlphaUAT5Bot', 'TH7a5', '5946299684:AAH6JHmNPr-WWXT2Vk5UDEZBIZ5RcOK2H-k', 1, 1, 'TH7a5'
UNION SELECT 'LaylaAgBot', 'TH7a5', '6344069201:AAHlBh4QcdmQUbT7cKivfZA4XWHlVRWZ37s', 1, 0, 'TH7a5'
*/

UPDATE BOT WITH(ROWLOCK)
SET DisplayName = 'AlphaUATTH7a5'
WHERE username = 'AlphaUAT5Bot'
