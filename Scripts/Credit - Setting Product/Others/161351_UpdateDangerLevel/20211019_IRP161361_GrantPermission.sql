/*<info serverAlias="DBLOG-bodb_CustomerLog,DBCUST-bodb_CustomerLog"></info>*/
/*
	Created: 20211006@Johnson
	Task: grant permission for TW web account 
	DB: DBLOG-bodb_CustomerLog,DBCUST-bodb_CustomerLog
*/

USE bodb_CustomerLog
GO

GRANT EXECUTE ON Acc_WriteLog_UserLog_RunSP_MultipleLog TO Dot_Admin
GO
