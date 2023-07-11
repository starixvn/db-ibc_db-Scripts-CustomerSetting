/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20230425@Winfred
	Task: Granr permission select data  [#RedmineID:#183746]
	DB: DBBOT/bodb_Chatbot
*/

-----------------------------------------------------
USE bodb02
GO

GRANT SELECT ON dbo.Customer TO bodbDownlineNet
GRANT SELECT ON dbo.custsub TO bodbDownlineNet
