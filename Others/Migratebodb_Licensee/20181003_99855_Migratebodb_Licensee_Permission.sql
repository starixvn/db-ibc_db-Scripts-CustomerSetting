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

GRANT SELECT ON dbo.Product3rd TO bodbAdminNet
