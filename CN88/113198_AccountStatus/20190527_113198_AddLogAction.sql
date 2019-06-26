/*
	Created by: Elodie
	Date: 20190626
	Task: Grant permission
	DB: DBLOG/bodb_CustomerLog_Archive
*/
USE bodb_CustomerLog_Archive
GO

GRANT SELECT ON dbo.CS_UserLog_Credit TO bodbAdminNet
GRANT SELECT ON dbo.CS_UserLog_Credit TO bodbDownlineNet
GRANT SELECT ON dbo.CS_UserLog_Credit TO bodbDownlineNetView


GRANT SELECT ON dbo.CS_UserLog_RunSP TO bodbAdminNet
GRANT SELECT ON dbo.CS_UserLog_RunSP TO bodbDownlineNet
GRANT SELECT ON dbo.CS_UserLog_RunSP TO bodbDownlineNetView

GRANT SELECT ON dbo.CS_UserLog_RunSP_MultiTarget TO bodbAdminNet
GRANT SELECT ON dbo.CS_UserLog_RunSP_MultiTarget TO bodbDownlineNet
GRANT SELECT ON dbo.CS_UserLog_RunSP_MultiTarget TO bodbDownlineNetView

GRANT SELECT ON dbo.CS_UserLog_Login TO bodbAdminNet
GRANT SELECT ON dbo.CS_UserLog_Login TO bodbDownlineNet
GRANT SELECT ON dbo.CS_UserLog_Login TO bodbDownlineNetView