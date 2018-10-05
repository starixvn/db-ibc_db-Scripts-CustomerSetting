/*
	Created: 20181003@Elodie
	Task: Grant permission on table
	DB: DBCUST/bodb_Licensee
*/
USE bodb_Licensee
GO

GRANT SELECT ON LicenseeSpecialCust TO bodbLicenseeNet
GRANT SELECT ON Licensees TO bodbLicenseeNet