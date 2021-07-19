/*
	Created by: Elodie
	Date: 20181218
	Task: Grant permission on SIT to use for CS_MsgCustReadStatus_SelUnread
	DB: SITDB05BK1/bodb02	
*/
USE bodb02
GO

GRANT SELECT ON CS_SubAccManagement TO bodbAdminNet
GRANT SELECT ON CS_SubAccManagement TO bodbDownlineNet
GRANT SELECT ON CS_SubAccManagement TO bodbDownlineNetView