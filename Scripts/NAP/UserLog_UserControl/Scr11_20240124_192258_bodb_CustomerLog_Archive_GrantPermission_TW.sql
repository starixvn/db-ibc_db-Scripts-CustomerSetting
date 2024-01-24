/*<info serverAlias="DBLOG-bodb_CustomerLog_Archive"></info>*/
/*
	Created by: Tacy@20240124
	Task: Grant permission ON dbo.UserLog_UserControl
		https://nexdev.net/issues/192258
	DB: DBLOG-bodb_CustomerLog_Archive
*/
USE bodb_CustomerLog_Archive
GO

GRANT SELECT ON dbo.UserLog_UserControl TO bodbLicenseeNet
GO