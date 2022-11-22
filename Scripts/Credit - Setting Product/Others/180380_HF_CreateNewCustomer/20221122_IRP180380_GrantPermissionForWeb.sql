/*<info serverAlias="DBMSG-bodb_Message"></info>*/
/*
	Date: 20221122
	Created: Johnson 
	Task: grant permission for web acc bodbExtAccNet connect to bodb_Message[redmine : #180380]
	DB: DBMSG/bodb_Message
*/
USE bodb_Message
GO

CREATE USER bodbExtAccNet FOR LOGIN bodbExtAccNet
GO

GRANT CONNECT TO bodbExtAccNet
