/*
	Created: 20200908@Johnson
	Task: apply special customerClass for customers (7.5k accounts)
	DB: DBCUST/CustDB
*/

CREATE TABLE #tblCust (custid INT, customerClass SMALLINT, isFinished BIT DEFAULT 0)
DECLARE @tmp TABLE (custid INT,customerClass SMALLINT)

INSERT INTO #tblCust (custid, customerClass)
SELECT custid, customerClass
FROM custinfo WITH(NOLOCK)
WHERE customerClass IN (6,7)

WHILE(1=1)
BEGIN
	UPDATE TOP(2000)t
	SET isFinished = 1
	OUTPUT DELETED.custid, DELETED.customerClass
	INTO @tmp(custid,customerClass)
	FROM  #tblCust t
	WHERE isFinished = 0
	
	IF @@ROWCOUNT = 0
		BREAK;
		
	UPDATE ci
	SET ci.customerClass = CASE WHEN t.customerClass = 6 THEN 7 ELSE 6 END
	FROM custinfo ci WITH(UPDLOCK,ROWLOCK)
		INNER JOIN @tmp t ON ci.custid = t.custid
		
	DELETE @tmp	
	
	WAITFOR DELAY '0:0:0.28'
END