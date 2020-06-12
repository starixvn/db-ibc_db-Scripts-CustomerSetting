/*
	Created: 20200505@Helen
	Task: https://nexdev.net/issues/130032
	DB: DBSPARE.CustDB_DBTRANS
*/
USE CustDB_DBTRANS
GO
IF @@SERVERNAME NOT IN ('DBSPARE')
	RETURN
	
TRUNCATE TABLE dbo.tmpCustArchived




