/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230316@Tacy
	Task: 02. Update Saba's Status - New Customers
		 https://nexdev.net/issues/185168 [RedmineID: #185168]
	Database: DBCUST/CustDB
*/
USE CustDB
GO

CREATE TABLE #supers (custid INT PRIMARY KEY CLUSTERED)
CREATE TABLE #Customer (CustID INT PRIMARY KEY CLUSTERED)

DECLARE @max_custid INT, @bitmapOrder TINYINT

SELECT @max_custid = xxx

SET @bitmapOrder=21

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
WHERE ci.roleid = 4  
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND site<>'789y'

INSERT INTO #Customer (CustID)
SELECT c.custid
FROM Custinfo c WITH (NOLOCK)
	INNER JOIN #supers s ON c.srecommend = s.custid
WHERE c.custid > @max_custid

DECLARE @batch int = 3000

-- Update Status 
CREATE TABLE #CustProductStatus(CustID INT PRIMARY KEY,bitmapIsHidden BINARY(32),bitmapIsDisabled BINARY(32),bitmapHasSynced BINARY(32),isfinished BIT DEFAULT(0))
CREATE TABLE #TempProductStatus(CustID INT PRIMARY KEY,bitmapIsHidden BINARY(32),bitmapIsDisabled BINARY(32),bitmapHasSynced BINARY(32))

INSERT INTO #CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled,bitmapHasSynced)
SELECT cs.CustID
	,bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cs.bitmapIsHidden,  @bitmapOrder, 1))
	,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cs.bitmapIsDisabled,  @bitmapOrder, 1))
	,bitmapHasSynced = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cs.bitmapHasSynced,  @bitmapOrder, 1))
FROM CustProductStatus cs WITH(NOLOCK)
	INNER JOIN  #Customer a ON a.CustID = cs.custid

WHILE 1 = 1 
BEGIN
	TRUNCATE TABLE #TempProductStatus

	UPDATE TOP (@batch) a WITH (ROWLOCK)
	SET a.isfinished = 1
	OUTPUT DELETED.CustID,DELETED.bitmapIsHidden,deleted.bitmapIsDisabled, deleted.bitmapHasSynced
		INTO #TempProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled,bitmapHasSynced)
	FROM #CustProductStatus a 
	WHERE a.isfinished = 0
		 
	IF @@ROWCOUNT = 0 
		BREAK;

	UPDATE c 
	SET  c.bitmapIsHidden = tmp.bitmapIsHidden
		,c.bitmapIsDisabled = tmp.bitmapIsDisabled
		,c.bitmapHasSynced = tmp.bitmapHasSynced
	FROM CustProductStatus c WITH(ROWLOCK, UPDLOCK)
		INNER JOIN #TempProductStatus tmp ON c.CustID = tmp.CustID

	WAITFOR DELAY '00:00:00.100'
END

DROP TABLE #Customer
DROP TABLE #supers
DROP TABLE #TempProductStatus
DROP TABLE #CustProductStatus