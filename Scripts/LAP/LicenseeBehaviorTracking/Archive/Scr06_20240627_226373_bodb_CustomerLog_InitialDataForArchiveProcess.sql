/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created by: Tacy@20240627
	Task: Archive tables Lrf_UserLog_Session and Lrf_UserLog_LicenseeBehavior
		https://nexdev.net/issues/226373
	DB: DBLOG-bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

INSERT INTO dbo.Task_ArchiveData_TableList (TableName)
VALUES  ('Lrf_UserLog_Session'),
        ('Lrf_UserLog_LicenseeBehavior')
GO 