/*
	Created by: Elodie
	Date: 20200303
	Task: Grant permission
	DB: DBLOG/bodb_CustomerLog_Archive
*/
USE bodb_CustomerLog_Archive
GO

GRANT SELECT ON dbo.UserLog_RunSP_MultiTarget TO bodbAdminNet
GRANT SELECT ON dbo.UserLog_RunSP_MultiTarget TO bodbDownlineNet
GRANT SELECT ON dbo.UserLog_RunSP_MultiTarget TO bodbDownlineNetView

GRANT SELECT ON dbo.UserLog_RunSP_LogTarget TO bodbAdminNet
GRANT SELECT ON dbo.UserLog_RunSP_LogTarget TO bodbDownlineNet
GRANT SELECT ON dbo.UserLog_RunSP_LogTarget TO bodbDownlineNetView
