/*
	Created: 20190515@Elodie	
	Task: Update data for testing
	DB: DBCUST/CustDB
*/
USE CustDB
GO

UPDATE cg 
SET cg.IsDisabled = 1
FROM CustGameType cg WITH (ROWLOCK, UPDLOCK) 
WHERE custid = 19280167 AND GameTypeID IN (7,9)