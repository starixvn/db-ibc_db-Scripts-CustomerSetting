/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: Eden@20240805
	Task: Grant permission [Redmine: #206823]   
	DB: DBLOG-bodb_CustomerLog
*/
USE bodb02
GO

GRANT SELECT ON Customer TO asv_cust
GO
