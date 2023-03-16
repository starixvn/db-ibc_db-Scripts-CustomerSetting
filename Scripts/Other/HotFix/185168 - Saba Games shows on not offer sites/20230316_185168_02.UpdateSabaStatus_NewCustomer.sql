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
CREATE TABLE #Member (CustID INT PRIMARY KEY CLUSTERED, isfinished BIT DEFAULT(0))
CREATE TABLE #SMA (CustID INT PRIMARY KEY CLUSTERED, roleid TINYINT, isfinished BIT DEFAULT(0))

DECLARE @max_custid INT, @bitmapOrder TINYINT, @xmlStrHidden XML

SELECT @max_custid = xxx

SET @bitmapOrder=21
	
SET @xmlStrHidden = (
			SELECT DISTINCT
				@bitmapOrder AS '@b', 
				1 AS '@s'
			FOR XML PATH ('r'), ROOT ('root')
			)

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
WHERE ci.roleid = 4  
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))

INSERT INTO #Member (CustID)
SELECT c.custid
FROM Custinfo c WITH (NOLOCK)
	INNER JOIN #supers s ON c.srecommend = s.custid
WHERE roleid = 1  AND c.custid > @max_custid
	
INSERT INTO #SMA (CustID, roleid)
SELECT c.custid, roleid
FROM Custinfo c WITH (NOLOCK)
	INNER JOIN #supers s ON c.srecommend = s.custid
WHERE c.roleid IN (2,3,4) AND c.custid > @max_custid 

DECLARE @batch int = 3000

-- Update Status 
CREATE TABLE #AllUsers (CustID INT PRIMARY KEY, XmlDisable VARCHAR(MAX))
CREATE TABLE #CustProductStatus(CustID INT PRIMARY KEY,bitmapIsHidden BINARY(32),bitmapIsDisabled BINARY(32),bitmapHasSynced BINARY(32),isfinished BIT DEFAULT(0))
CREATE TABLE #TempProductStatus(CustID INT PRIMARY KEY,bitmapIsHidden BINARY(32),bitmapIsDisabled BINARY(32),bitmapHasSynced BINARY(32))

INSERT INTO #AllUsers (CustID,XmlDisable)
SELECT DISTINCT SMA.CustID, @xmlStrHidden 
FROM #SMA SMA WITH (NOLOCK)

INSERT INTO #CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled,bitmapHasSynced)
SELECT cs.CustID
	,bitmapIsHidden = (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsHidden, CONVERT(VARCHAR(MAX),a.XmlDisable)))
	,bitmapIsDisabled = (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsDisabled, CONVERT(VARCHAR(MAX),a.XmlDisable)))
	,bitmapHasSynced = (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapHasSynced, CONVERT(VARCHAR(MAX),a.XmlDisable)))
FROM CustProductStatus cs WITH(NOLOCK)
	INNER JOIN  #AllUsers a ON a.CustID = cs.custid

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

DROP TABLE #Member
DROP TABLE #SMA
DROP TABLE #supers
DROP TABLE #TempProductStatus
DROP TABLE #CustProductStatus
DROP TABLE #AllUsers
