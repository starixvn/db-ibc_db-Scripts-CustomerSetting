/*<info serverAlias="DBCUST-bodb_CustomerLog"></info>*/
/*
	Created: Eden@20240805
	Task: SIGNATURE CERTIFICATE for testing [Redmine: #206823]   
	DB: DBCUST-bodb_CustomerLog
*/
USE GlobCustDB
GO
ADD SIGNATURE TO Acc_CustomerIns_Rollback_UAT2 BY CERTIFICATE cert_scaleout_dbcust_UAT WITH PASSWORD = 'Admin!@#passwordagain'
GO
ADD SIGNATURE TO API_CustomerIns_Register_UAT2 BY CERTIFICATE cert_scaleout_dbcust_UAT WITH PASSWORD = 'Admin!@#passwordagain'
GO
ADD SIGNATURE TO API_CustomerIns_Generate_UAT2 BY CERTIFICATE cert_scaleout_dbcust_UAT WITH PASSWORD = 'Admin!@#passwordagain'
GO