/*<info serverAlias="DBCUST-bodb_Licensee"></info>*/
/*	
	Created: 20221201@Tacy
	Task: Rename unused columns on LicenseeCustComm | LicenseeGroupComm - Script ROLLBACK
	Redmine: https://redmine.nexcel.vn/issues/174511
	DB: DBCUST-bodb_Licensee
*/
USE bodb_Licensee
GO 

EXEC sp_rename 'LicenseeCustComm.DEL_GDComm','GDComm', 'COLUMN'
EXEC sp_rename 'LicenseeGroupComm.DEL_GDComm','GDComm', 'COLUMN'
