/*<info serverAlias="DBCACC-bodb02"></info>*/
/*
    Created: Eden@20211213
    Task: DELETE Cust_TrackingLastBetDate when LastBetDate = NULL
    DB: DBCACC/bodb02
*/ 
CREATE TABLE #DeletedCust (custid int)
CREATE TABLE #DeletedCust_Batch (custid INT)

INSERT INTO #DeletedCust(custid)
SELECT a.CustID
FROM Cust_TrackingLastBetDate a WITH(NOLOCK)
WHERE a.LastBetDate IS NULL

WHILE 1 = 1
BEGIN
	TRUNCATE TABLE #DeletedCust_Batch

	DELETE TOP (5000) a
	OUTPUT deleted.custid INTO #DeletedCust_Batch(custid)
	FROM #DeletedCust a

	IF (@@ROWCOUNT = 0) 
		BREAK

	DELETE c
	FROM #DeletedCust_Batch a
		INNER JOIN Cust_TrackingLastBetDate c WITH(ROWLOCK,UPDLOCK)
			ON a.custid = c.CustID
	WHERE c.LastBetDate IS NULL
END