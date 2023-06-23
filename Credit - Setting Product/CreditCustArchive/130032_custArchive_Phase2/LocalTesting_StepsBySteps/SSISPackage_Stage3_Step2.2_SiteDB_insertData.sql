/*
	Created: 20230623@Eden
	Task: https://nexdev.net/issues/130032
	DB: DBTXN.CUSTDB/ SiteDB.CUSTDB
*/
USE CUSTDB
GO
IF @@SERVERNAME NOT IN ('TESTDBTRANS','TESTSITEDB2')
	RETURN

INSERT INTO dbo.tmpCustArchived (Super, Master, Agent, MemCnt, recommend)
SELECT Super, Master, Agent, MemCnt, recommend 
FROM DBCUST.custDB.dbo.tmpCustArchived WITH(NOLOCK)
