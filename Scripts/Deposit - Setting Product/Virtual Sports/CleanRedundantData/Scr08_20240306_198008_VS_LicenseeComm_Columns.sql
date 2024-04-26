/*<info serverAlias="DBCUST-bodb_Licensee"></info>*/
/*	
	Created: 20240306@Tacy
	Task: Drop unused columns on LicenseeCustComm | LicenseeGroupComm
	Redmine: https://nexdev.net/issues/198008
	DB: DBCUST-bodb_Licensee
*/
USE bodb_Licensee
GO 

--DROP CONSTRAINT
ALTER TABLE dbo.LicenseeCustComm DROP CONSTRAINT [DF_LicenseeCustComm_VS2Comm]
GO

ALTER TABLE dbo.LicenseeCustComm DROP CONSTRAINT [DF_LicenseeCustComm_VS3Comm]
GO

ALTER TABLE dbo.LicenseeGroupComm DROP CONSTRAINT [DF_LicenseeGroupComm_VS2Comm]
GO

ALTER TABLE dbo.LicenseeGroupComm DROP CONSTRAINT [DF_LicenseeGroupComm_VS3Comm]
GO


--DROP COLUMN
ALTER TABLE dbo.LicenseeCustComm DROP COLUMN [VS2Comm]
GO

ALTER TABLE dbo.LicenseeCustComm DROP COLUMN [VS3Comm]
GO

ALTER TABLE dbo.LicenseeGroupComm DROP COLUMN [VS2Comm]
GO

ALTER TABLE dbo.LicenseeGroupComm DROP COLUMN [VS3Comm]
GO