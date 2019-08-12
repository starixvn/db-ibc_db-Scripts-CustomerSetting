/*
	Created: 20190807@Winnie
	Task : Keno Remove GameTypeID <> 1 new cust. RedmineID:#117501
	DB:  DBCUST/CustDB
*/


CREATE TABLE #Super(CustID INT, isfinished BIT DEFAULT(0))
DECLARE @max_custid INT,@srecommend INT
SELECT @max_custid = xxx						

INSERT INTO #Super(custid)
SELECT DISTINCT ds.custid
FROM custgametype cs (nolock)
INNER JOIN Dep_CustSuper ds (nolock) on cs.custid = ds.custid
	
--------------------------------------------------------------
	CREATE TABLE #MemberTemp
(
	CustID		INT PRIMARY KEY CLUSTERED		
)

	CREATE TABLE #MemberTempBatch
(
	CustID		INT PRIMARY KEY CLUSTERED	
)

INSERT INTO #MemberTemp (CustID)
SELECT custid
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN(SELECT CustID FROM #Super) AND roleid IN(1,2,3,4)  AND custid > @max_custid
	
WHILE EXISTS(SELECT 1 FROM #MemberTemp)
BEGIN
	DELETE TOP (150) #MemberTemp OUTPUT DELETED.* INTO #MemberTempBatch

	IF @@ROWCOUNT=0
		BREAK		

	DELETE g
	FROM CustGameType g WITH(ROWLOCK)
		INNER JOIN #MemberTempBatch t ON g.CustID=t.CustID
	WHERE g.GameTypeID <>1

	TRUNCATE TABLE #MemberTempBatch
END	
