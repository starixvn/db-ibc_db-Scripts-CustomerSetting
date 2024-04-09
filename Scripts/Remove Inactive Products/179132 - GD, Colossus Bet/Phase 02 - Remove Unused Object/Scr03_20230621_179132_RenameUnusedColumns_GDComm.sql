/*<info serverAlias="DBCUST-bodb_Licensee"></info>*/
/*	
	Created: 20230621@Tacy
	Task: Rename unused columns on LicenseeCustComm | LicenseeGroupComm
	Redmine: https://nexdev.net/issues/179132
	DB: DBCUST-bodb_Licensee
*/
USE bodb_Licensee
GO 

EXEC sp_rename 'LicenseeCustComm.GDComm','DEL_GDComm', 'COLUMN'
GO
EXEC sp_rename 'LicenseeGroupComm.GDComm','DEL_GDComm', 'COLUMN'
GO