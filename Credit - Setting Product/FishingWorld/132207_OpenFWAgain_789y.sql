/*
	Created: Elodie
	Task: Fishing World - Enable can-see status for Fishing World again
	DB: DBCUST/CustDB
	Date: 20200410
*/ 
USE CustDB
GO

UPDATE ProductLaunchedSiteCurrency WITH(ROWLOCK)
SET IsLaunched = 1
WHERE sporttype = 219
	AND siteid = 3

