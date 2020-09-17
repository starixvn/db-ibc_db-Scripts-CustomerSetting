/*
	Created: 20200505@Helen
	Task: https://nexdev.net/issues/130032
	DB: DBCUST.CUSTDB
*/
USE CustDB
GO
IF @@SERVERNAME NOT IN ('DB233','DB230\SQLSERVER2008R2')
	RETURN
	
TRUNCATE TABLE dbo.tmpCustArchived




