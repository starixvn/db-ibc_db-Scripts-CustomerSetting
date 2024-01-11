/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created by: Tacy@20231012
	Task: Archive table UserLog_UserControl
		https://nexdev.net/issues/192258
	DB: DBLOG-bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

INSERT INTO dbo.Task_ArchiveData_TableList (TableName)
VALUES  ('UserLog_UserControl')
GO