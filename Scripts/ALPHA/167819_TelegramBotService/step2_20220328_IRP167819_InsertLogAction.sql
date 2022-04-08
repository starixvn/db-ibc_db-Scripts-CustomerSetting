/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20220328@Johnson
	Task: Insert log action for telegram bot service [#RedmineID:#165682]
	DB: DBLOG/bodb_CustomerLog
*/

DELETE LogAction 
WHERE ActionID IN (95064,95065,95066,95067,95068,95069)


;WITH T AS
(
	SELECT 95064 as ActionID, 0 as IsInternal, 'Age_Chatbot_CustBotAccountIns' spName, N'Link Telegram ID' ActionEn
	UNION SELECT 95065, 0, 'Age_Chatbot_CustBotAccountStatusUpd', 'Verify Telegram ID'
	UNION SELECT 95066, 0, 'Age_Chatbot_CustBotAccountStatusUpd', 'Unlink Telegram ID'
	UNION SELECT 95067, 0, 'Age_Chatbot_CustBotAccountLanguageUpd', 'Update Chatbot''s Language'
	UNION SELECT 95068, 1, 'NAP_Chatbot_CustBotAccountInfoUpd', 'Update Linking Status of Telegram Chatbot'
	UNION SELECT 95069, 0, 'Age_Chatbot_CustBotFunctionUpd','Update Telegram Chatbot''s Function'	
)
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],
	[ActionNameEN],
	[ActionNameCH],
	[ActionNameCS],
	[ActionNameJP],
	[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
SELECT ActionID, 4, spName, ActionEn, ActionEn, ActionEn, ActionEn, ActionEn, ActionEn, ActionEn, NULL, IsInternal, ActionEn, ActionEn
FROM T