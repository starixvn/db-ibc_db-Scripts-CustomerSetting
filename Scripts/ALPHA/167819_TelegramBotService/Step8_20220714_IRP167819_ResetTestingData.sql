/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20220714@Johnson
	Task: clean testing data [#RedmineID:#167819]
	DB: DBBOT/bodb_Chatbot
*/
TRUNCATE TABLE CustBotMessage
GO

TRUNCATE TABLE CustBotNotification
GO

TRUNCATE TABLE NotificationReferenceLog
GO