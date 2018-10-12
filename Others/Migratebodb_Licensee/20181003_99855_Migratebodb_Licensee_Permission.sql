/*
	Created: 20181003@Elodie
	Task: Grant permission on table
	DB: DBCUST/bodb_Licensee
*/
USE bodb_Licensee
GO

GRANT SELECT ON LicenseeUserFunctions TO bodbLicenseeNet
GRANT SELECT ON LicenseeSpecialCust TO bodbLicenseeNet
GRANT SELECT ON LicenseeCurrencyBAGroup TO bodbLicenseeNet
GRANT SELECT ON Licensees TO bodbLicenseeNet
GRANT SELECT ON LicenseeBAHistory TO bodbLicenseeNet
GRANT SELECT ON LicenseeCust TO bodbLicenseeNet
GRANT SELECT ON Users TO bodbLicenseeNet
GRANT SELECT ON LicenseeBAConfig TO bodbLicenseeNet

GRANT SELECT ON dbo.Product3rd TO bodbAdminNet
GRANT SELECT ON Licensees TO bodbAdminNet
GRANT SELECT ON LicenseeProduct3rd TO bodbAdminNet
GRANT SELECT ON LicenseeCust TO bodbAdminNet

GRANT SELECT ON Licensees TO Dot_Admin_Portal
GRANT SELECT ON Users TO Dot_Admin_Portal
GRANT SELECT ON LicenseeUser TO Dot_Admin_Portal
GRANT SELECT ON Functions TO Dot_Admin_Portal
GRANT SELECT ON LicenseeUserFunctions TO Dot_Admin_Portal
GRANT SELECT ON CurrencyUser TO Dot_Admin_Portal

GRANT SELECT ON LicenseeSourcedSetting TO Dot_Member
GRANT SELECT ON LicenseeBAHistory TO Dot_Member

USE CustDB
GO

GRANT SELECT ON Customer TO bodbLicenseeNet
GRANT SELECT ON custInfo TO bodbLicenseeNet

USE NAP_UserControl
GO

GRANT EXECUTE ON Acc_Con_CheckPermission TO bodbLicenseeNet
