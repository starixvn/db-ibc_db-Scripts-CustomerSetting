/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20230425@Winfred
	Task: Update Notify abnormal login via Telegram chatbot [#RedmineID:#183746]
	DB: DBBOT/bodb_Chatbot
*/

-----------------------------------------------------
USE bodb_CustomerLog
GO

TRUNCATE TABLE CustAbnormalLogin
