/*<info serverAlias="DBCUST-bodb_Licensee"></info>*/
/*	
	Created: 20221201@Tacy
	Task: Drop unused columns on LicenseeCustComm | LicenseeGroupComm
	Redmine: https://redmine.nexcel.vn/issues/174511
	DB: DBCUST-bodb_Licensee
*/
USE bodb_Licensee
GO 

--DROP CONSTRAINT
ALTER TABLE dbo.LicenseeCustComm DROP CONSTRAINT DF_LicenseeCustComm_GDGComm
GO
ALTER TABLE dbo.LicenseeCustComm DROP CONSTRAINT DF_LicenseeCustComm_FWComm
GO

ALTER TABLE dbo.LicenseeGroupComm DROP CONSTRAINT DF_LicenseeGroupComm_GDGComm
GO
ALTER TABLE dbo.LicenseeGroupComm DROP CONSTRAINT DF_LicenseeGroupComm_FWComm
GO

--DROP COLUMN
ALTER TABLE dbo.LicenseeCustComm DROP COLUMN DEL_FWComm
GO
ALTER TABLE dbo.LicenseeCustComm DROP COLUMN DEL_GDGComm
GO

ALTER TABLE dbo.LicenseeGroupComm DROP COLUMN DEL_FWComm
GO
ALTER TABLE dbo.LicenseeGroupComm DROP COLUMN DEL_GDGComm
GO