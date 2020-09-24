/*
	Created: 20200505@Helen
	Task: https://nexdev.net/issues/130032
	DB: DBTRANS.CUSTDB
*/
USE CUSTDB
GO
IF @@SERVERNAME NOT IN ('db230','db206')
	RETURN
	
TRUNCATE TABLE dbo.tmpCustArchived




