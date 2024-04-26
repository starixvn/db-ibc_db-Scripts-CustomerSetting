/*<info serverAlias="DBLIC-bodb_Licensee"></info>*/
/*
	Creator: 20240411@Tacy
	Task: Drop unused SP (moved to DBCust.CustDB)  [Redmine: #198008]
	Database:	DBLIC-bodb_Licensee
*/
USE bodb_Licensee
GO

DROP PROCEDURE Lrf_LicenseeProductByBetLimitSel 
GO

DROP PROCEDURE Lrf_LicenseeProductSel 
GO