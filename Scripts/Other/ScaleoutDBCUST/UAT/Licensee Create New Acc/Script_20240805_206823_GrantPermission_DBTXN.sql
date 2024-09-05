/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: Eden@20240805
	Task: Grant permission [Redmine: #206823]   
	DB: DBTXN-bodb02
*/
USE CustDB
GO
GRANT SELECT ON exchange TO asv_cust
GO
GRANT SELECT ON customer TO asv_cust
GO
GRANT SELECT ON custinfo TO asv_cust
GO