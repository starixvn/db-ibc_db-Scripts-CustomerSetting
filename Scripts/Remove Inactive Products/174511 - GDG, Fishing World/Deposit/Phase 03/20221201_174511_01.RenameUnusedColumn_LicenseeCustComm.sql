/*<info serverAlias="DBCUST-bodb_Licensee"></info>*/
/*	
	Created: 20221201@Tacy
	Task: Rename unused columns on LicenseeCustComm | LicenseeGroupComm
	Redmine: https://redmine.nexcel.vn/issues/174511
	DB: DBCUST-bodb_Licensee
*/
USE bodb_Licensee
GO 

EXEC sp_rename 'LicenseeCustComm.FWComm','DEL_FWComm', 'COLUMN'
EXEC sp_rename 'LicenseeCustComm.GDGComm','DEL_GDGComm', 'COLUMN'
EXEC sp_rename 'LicenseeGroupComm.FWComm','DEL_FWComm', 'COLUMN'
EXEC sp_rename 'LicenseeGroupComm.GDGComm','DEL_GDGComm', 'COLUMN'