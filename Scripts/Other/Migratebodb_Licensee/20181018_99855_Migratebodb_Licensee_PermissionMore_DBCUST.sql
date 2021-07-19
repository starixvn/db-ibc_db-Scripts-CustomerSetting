/*
	Created: 20181003@Elodie
	Task: Grant permission on table
	DB: DBCUST/bodb_Licensee
*/
USE bodb_Licensee
GO

GRANT SELECT ON LicenseeBAConfig TO bodbDownlineNet
GRANT SELECT ON LicenseeBAConfig TO bodbExtAccNet
GRANT SELECT ON LicenseeBAHistory TO bodbAdminNet
GRANT SELECT ON LicenseeBAHistory TO bodbDownlineNet
GRANT SELECT ON LicenseeBAHistory TO bodbExtAccNet
GRANT SELECT ON LicenseeCurrencyBAGroup TO bodbDownlineNet
GRANT SELECT ON LicenseeCurrencyBAGroup TO bodbExtAccNet
GRANT SELECT ON LicenseeCust TO Dot_Member
GRANT SELECT ON Licensees TO Dot_Member
GRANT SELECT ON LicenseeSpecialCust TO bodbDownlineNet
GRANT SELECT ON LicenseeSpecialCust TO bodbExtAccNet
GRANT SELECT ON LicenseeUserFunctions TO bodbAdminNet
GRANT SELECT ON LicenseeUserFunctions TO bodbDownlineNet
GRANT SELECT ON LicenseeUserFunctions TO bodbExtAccNet
GRANT EXECUTE ON Lrf_CustomerSetDefaultComm_UAT4 TO bodbDownlineNet
GRANT EXECUTE ON Lrf_CustomerSetDefaultComm_UAT4 TO bodbExtAccNet
GRANT EXECUTE ON Lrf_LicenseeBACustUpdComm_UAT4 TO bodbAdminNet
GRANT EXECUTE ON Lrf_LicenseeBACustUpdComm_UAT4 TO bodbDownlineNet
GRANT EXECUTE ON Lrf_LicenseeBACustUpdComm_UAT4 TO bodbExtAccNet
GRANT EXECUTE ON Lrf_LicenseeBACustUpdComm_UAT4 TO Dot_Member
GRANT EXECUTE ON Lrf_LicenseeBAHistoryIns_UAT4 TO bodbDownlineNet
GRANT EXECUTE ON Lrf_LicenseeBAHistoryIns_UAT4 TO bodbExtAccNet
GRANT EXECUTE ON Lrf_LicenseeBAHistoryIns_UAT4 TO Dot_Member
GRANT EXECUTE ON Lrf_LicenseeBAHistoryUpdDone_UAT4 TO bodbDownlineNet
GRANT EXECUTE ON Lrf_LicenseeBAHistoryUpdDone_UAT4 TO bodbExtAccNet
GRANT EXECUTE ON Lrf_LicenseeBAHistoryUpdDone_UAT4 TO Dot_Member
GRANT SELECT ON Lrf_view_site_list TO bodbLicenseeNet
GRANT SELECT ON Product3rd TO bodbDownlineNet
GRANT SELECT ON Product3rd TO bodbExtAccNet
GRANT SELECT ON Users TO bodbAdminNet
GRANT SELECT ON Users TO bodbDownlineNet
GRANT SELECT ON Users TO bodbExtAccNet
GRANT SELECT ON Users TO Dot_Member

USE CustDB
GO

GRANT SELECT ON Exchange TO bodbLicenseeNet
GRANT EXECUTE ON Lrf_f_Get_MsgNamebyMsgID_UAT4 TO bodbAdminNet
GRANT EXECUTE ON Lrf_f_Get_MsgNamebyMsgID_UAT4 TO Dot_Member
GRANT SELECT ON strSplit TO bodbLicenseeNet

GRANT EXECUTE ON Lrf_f_Get_MsgNamebyMsgID_UAT4 TO bodbDownlineNet
GRANT EXECUTE ON Lrf_f_Get_MsgNamebyMsgID_UAT4 TO bodbExtAccNet
GRANT EXECUTE ON Lrf_LicenseeBACust_Playerdiscount_Upd TO bodbDownlineNet
GRANT EXECUTE ON Lrf_LicenseeBACust_Playerdiscount_Upd TO bodbExtAccNet
GRANT EXECUTE ON Lrf_LicenseeBACust_Playerdiscount_Upd TO Dot_Member
