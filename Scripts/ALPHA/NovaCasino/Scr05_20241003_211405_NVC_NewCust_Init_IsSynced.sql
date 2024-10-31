/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20241003
	Task: NovaCasino - Init default value - NEW CUST [Redmine: #211405]
	DB: DBCust/CustDB
*/ 
PRINT N'New Customer: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

CREATE TABLE #supers (custid INT PRIMARY KEY CLUSTERED)
CREATE TABLE #CustList (CustID INT PRIMARY KEY CLUSTERED, RoleId TINYINT)
CREATE TABLE #CustList_batch (CustID INT PRIMARY KEY CLUSTERED, RoleId TINYINT)

DECLARE @max_custid INT, @Default BINARY(2)=0x00

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
WHERE ci.roleid = 4  
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))

INSERT INTO #CustList (CustID,  RoleId)
SELECT c.custid, c.roleid
FROM Custinfo c WITH (NOLOCK)
	INNER JOIN #supers s ON c.srecommend = s.custid
WHERE c.custid > @max_custid AND c.Enabled=1
	AND c.roleid IN (2,3,4)

--Update Status
WHILE 1 = 1 
BEGIN
	DELETE FROM #CustList_batch

	DELETE TOP (2000) T OUTPUT deleted.CustID, deleted.RoleId
		INTO #CustList_batch(CustID, RoleId)
	FROM #CustList t 

	IF @@ROWCOUNT = 0 
		BREAK;

	IF EXISTS (SELECT TOP 1 1 FROM #CustList_batch WHERE RoleId=4)
	BEGIN
		UPDATE c
		SET c.IsSynced=@Default
		FROM CustSuper c WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #CustList_batch t ON t.CustID=c.custid
		WHERE t.RoleId=4
	END

	IF EXISTS (SELECT TOP 1 1 FROM #CustList_batch WHERE RoleId=3)
	BEGIN
		UPDATE c
		SET c.IsSynced=@Default
		FROM CustMaster c WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #CustList_batch t ON t.CustID=c.custid
		WHERE t.RoleId=3
	END

	IF EXISTS (SELECT TOP 1 1 FROM #CustList_batch WHERE RoleId=2)
	BEGIN
		UPDATE c
		SET c.IsSynced=@Default
		FROM CustAgent c WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #CustList_batch t ON t.CustID=c.custid
		WHERE t.RoleId=2
	END
	
	WAITFOR DELAY '00:00:0.050'
END

DROP TABLE #supers, #CustList, #CustList_batch

PRINT N'New Customer: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
GO