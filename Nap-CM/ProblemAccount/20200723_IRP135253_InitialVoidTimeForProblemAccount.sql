/*
	Created: 20200723@Johnson	
	Task: Initial data for Void time & limit amount for problem account
	DB: DBCUST/CUSTDB
*/
--select max(custid) from custInfo

DECLARE @maxcustid INT = xxx

CREATE TABLE #tblCust (custid INT PRIMARY KEY, isFinished BIT DEFAULT 0)
DECLARE @tmp TABLE (custid INT PRIMARY KEY)

INSERT INTO #tblCust(custid)
SELECT custid 
FROM ProblemAccount WITH(NOLOCK)
WHERE custid <= @maxcustid

WHILE(1=1)
BEGIN
	UPDATE TOP (5000) t
	SET isFinished = 1
	OUTPUT DELETED.custid INTO @tmp(custid)
	FROM #tblCust t
	WHERE isFinished = 0
	
	IF @@ROWCOUNT = 0
		BREAK;
		
	UPDATE p
	SET VoidTime = 'At Settlement',
		LimitAmount = 0
	FROM ProblemAccount p WITH(UPDLOCK,ROWLOCK)
	WHERE custid IN (SELECT custid FROM @tmp)
	
	WAITFOR DELAY '0:0:01'
END


UPDATE p
SET VoidTime = 'At Settlement',
	LimitAmount = 0
FROM ProblemAccount p WITH(UPDLOCK,ROWLOCK)
WHERE custid > @maxcustid

