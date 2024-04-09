/*<info serverAlias="DBCUST-bodb_Licensee"></info>*/
/*	
	Created: 20230621@Tacy
	Task: Rename unused columns on LicenseeCustComm | LicenseeGroupComm
	Redmine: https://nexdev.net/issues/179132
	DB: DBCUST-bodb_Licensee
*/
USE bodb_Licensee
GO 

--DROP CONSTRAINT
ALTER TABLE dbo.LicenseeCustComm DROP CONSTRAINT DF_LicenseeCustComm_GDComm
GO

ALTER TABLE dbo.LicenseeGroupComm DROP CONSTRAINT DF_LicenseeGroupComm_GDComm
GO

--DROP COLUMN
ALTER TABLE dbo.LicenseeCustComm DROP COLUMN DEL_GDComm
GO

ALTER TABLE dbo.LicenseeGroupComm DROP COLUMN DEL_GDComm
GO