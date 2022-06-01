/*<info serverAlias="DBBOT-bodb02"></info>*/
/*
	Created: 20220328@Johnson
	Task: grant permission for web account [#RedmineID:#165682]
	DB: DBBOT/bodb02
*/

USE bodb02
GO

GRANT SELECT ON custSub TO bodbDownlineNet
GO

USE bodb_Chatbot
GO
CREATE USER bodbAdminNet FOR LOGIN bodbAdminNet