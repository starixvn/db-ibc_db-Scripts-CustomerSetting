/*
	Created: 20200626@Johnson
	Task: update site = 'IBCIndo' for INDOBS
	DB: DBCUST/CustDB
*/

DECLARE @maxcustid INT = xxx

--9043 rows affected
SELECT custid, 0 isFinished
INTO #tblCust 
FROM customer WITH(NOLOCK)
WHERE srecommend IN (
	SELECT custid
	FROM Acc_CustGroup WITH(NOLOCK)
	where groupname = 'indobs'
)
AND roleid IN (2,3,4)
AND custid <= @maxcustid

--update new site for INDOBS
WHILE(1=1)
BEGIN
	UPDATE TOP(5000) t
	SET isFinished = 1
	FROM #tblCust t
	WHERE isFinished = 0
	
	IF @@ROWCOUNT = 0
		BREAK;
	
	UPDATE c
	SET site = 'IBCIndo'
	FROM Customer c WITH(UPDLOCK,ROWLOCK)
	WHERE custid IN (SELECT custid FROM #tblCust WHERE isFinished = 1)
	
	DELETE #tblCust WHERE isFinished = 1
END

--newly customers
UPDATE c
SET site = 'IBCIndo'
FROM Customer c WITH(NOLOCK)
WHERE srecommend IN (
	SELECT custid 
	FROM Acc_CustGroup WITH(NOLOCK)
	where groupname = 'indobs'
	)
AND roleid IN (2,3,4)	
AND custid > @maxcustid
GO	
