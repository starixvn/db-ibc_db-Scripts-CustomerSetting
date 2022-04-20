/*
	Created: 20200505@Helen
	Task: https://nexdev.net/issues/130032
	DB: DBCUST.CUSTDB
*/
USE CustDB
GO
IF @@SERVERNAME NOT IN ('TESTDBCUST','DB-60\DevDBcust')
	RETURN
	
TRUNCATE TABLE dbo.tmpCustArchived
