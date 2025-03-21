/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20250319@Tacy	
	Task: Revoking permission on view [Dep_StakeLevel] - CustDB & GlobCustDB [RedmineID: #216870]
	DB: DBCUST-CUSTDB
*/
USE CUSTDB
GO

REVOKE INSERT ON Dep_StakeLevel TO asv_cust;
GO

REVOKE UPDATE ON Dep_StakeLevel TO asv_cust;
GO

REVOKE DELETE ON Dep_StakeLevel TO asv_cust;
GO

--------------------------------------------------
--On GlobCustDB
USE GlobCustDB
GO

REVOKE INSERT ON Dep_StakeLevel TO asv_cust;
GO

REVOKE UPDATE ON Dep_StakeLevel TO asv_cust;
GO

REVOKE DELETE ON Dep_StakeLevel TO asv_cust;
GO
