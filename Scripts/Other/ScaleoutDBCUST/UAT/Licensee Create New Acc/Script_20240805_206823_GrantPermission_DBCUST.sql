/*<info serverAlias="DBCUST-bodb_CustomerLog"></info>*/
/*
	Created: Eden@20240805
	Task: Grant permission [Redmine: #206823]   
	DB: DBCUST-bodb_CustomerLog
*/
---------------------CustDB_History--------------------------
USE CustDB_History
GO
GRANT SELECT,UPDATE,INSERT TO asv_cust
GO
---------------------CustDB--------------------------
USE CustDB
GO
GRANT VIEW DEFINITION TO asv_cust AS [dbo]
GO
GRANT SELECT,INSERT ON site TO asv_cust
GO
GRANT SELECT ON siteDBConfig TO asv_cust
GO
GRANT SELECT ON CustInfoMini TO asv_cust
GO
GRANT SELECT ON exchange TO asv_cust
GO
GRANT SELECT ON Customer TO asv_cust

---------------------bodb_Licensee--------------------------
USE bodb_Licensee
GO
GRANT SELECT ON Licensees TO asv_cust
GO
GRANT SELECT ON LicenseeCust TO asv_cust
---------------------GlobCustDB--------------------------
USE GlobCustDB
GO
GRANT SELECT ON CustInfoMini TO asv_cust
GO
GRANT SELECT ON exchange TO asv_cust




