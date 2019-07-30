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

GRANT SELECT ON dbo.CS_UserLog_RunSP_LogTarget TO bodbAdminNet
GRANT SELECT ON dbo.CS_UserLog_RunSP_LogTarget TO bodbDownlineNet
GRANT SELECT ON dbo.CS_UserLog_RunSP_LogTarget TO bodbDownlineNetView

REVOKE INSERT ON dbo.CS_UserLog_Credit TO bodbAdminNet
REVOKE INSERT ON dbo.CS_UserLog_Credit TO bodbDownlineNet
REVOKE INSERT ON dbo.CS_UserLog_Credit TO bodbDownlineNetView

REVOKE INSERT ON dbo.CS_UserLog_RunSP TO bodbAdminNet
REVOKE INSERT ON dbo.CS_UserLog_RunSP TO bodbDownlineNet
REVOKE INSERT ON dbo.CS_UserLog_RunSP TO bodbDownlineNetView

REVOKE INSERT ON dbo.CS_UserLog_RunSP_MultiTarget TO bodbAdminNet
REVOKE INSERT ON dbo.CS_UserLog_RunSP_MultiTarget TO bodbDownlineNet
REVOKE INSERT ON dbo.CS_UserLog_RunSP_MultiTarget TO bodbDownlineNetView

REVOKE INSERT ON dbo.CS_UserLog_Login TO bodbAdminNet
REVOKE INSERT ON dbo.CS_UserLog_Login TO bodbDownlineNet
REVOKE INSERT ON dbo.CS_UserLog_Login TO bodbDownlineNetView

REVOKE INSERT ON dbo.CS_UserLog_RunSP_LogTarget TO bodbAdminNet
REVOKE INSERT ON dbo.CS_UserLog_RunSP_LogTarget TO bodbDownlineNet
REVOKE INSERT ON dbo.CS_UserLog_RunSP_LogTarget TO bodbDownlineNetView