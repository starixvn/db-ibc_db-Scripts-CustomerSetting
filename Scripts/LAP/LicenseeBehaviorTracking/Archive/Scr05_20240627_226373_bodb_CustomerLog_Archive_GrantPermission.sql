/*<info serverAlias="DBLOG-bodb_CustomerLog_Archive"></info>*/
/*
	Created by: Tacy@20240627
	Task: Archive tables Lrf_UserLog_Session and Lrf_UserLog_LicenseeBehavior
		https://nexdev.net/issues/226373
	DB: DBLOG-bodb_CustomerLog_Archive
*/
USE bodb_CustomerLog_Archive
GO

GRANT SELECT ON dbo.Lrf_UserLog_Session TO wsv_lap
GO
GRANT SELECT ON dbo.Lrf_UserLog_LicenseeBehavior TO wsv_lap
GO 