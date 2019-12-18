/*
	Created: Johnson
	Date: 2019-12-18
	Task: import setting to DBCUST
	DB: DBCUST/CUSTDB
*/

DECLARE @tmpCust TABLE(custid INT, seqNo INT, bitmapVirtual binary(64))

SELECT cs1.*, 0 isFinished 
INTO #Tmp_CustVirtual
FROM DBSPARE.custdb_tmp2.dbo.Tmp_CustVirtual2 cs1
	INNER JOIN DBSPARE.custdb_tmp2.dbo.Tmp_CustVirtual70k cs2 ON cs1.custid = cs2.custid
																AND cs1.seqNo = cs2.seqNo

WHILE(1=1)
BEGIN
	DELETE @tmpCust
	
	UPDATE TOP(500) t
	SET isFinished = 1
	OUTPUT DELETED.custid, DELETED.seqNo, DELETED.bitmapVirtual
	INTO @tmpCust(custid,seqNo,bitmapVirtual)
	FROM #Tmp_CustVirtual t 
	WHERE isFinished = 0
	
	SELECT @cnt = @@ROWCOUNT
	
	IF @cnt = 0 
		BREAK;
		
	UPDATE cs
	SET cs.bitmapVirtual = t.bitmapVirtual
	FROM CustVirtualSetting cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN @tmpCust t ON cs.custid = t.custid AND cs.seqNo = t.seqNo
		
	WAITFOR DELAY '00:00:00.28'
END

