/*
	Created: 20200611@Max
	Task: https://nexdev.net/issues/130032
	DB: DBSPARE.CUSTDB
*/
USE CustDB
GO
IF @@SERVERNAME NOT IN ('DBSPARE')
	RETURN
	
TRUNCATE TABLE dbo.tmpCustArchived




