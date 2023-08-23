/*<info serverAlias="DBTXN-CUSTDB"></info>*/
/*	
	Created: 20230823@Eden
	Task: Correct data CustProductStatus of all sitedb [#193055]
	DB: DBTXN/CUSTDB (all siteDB)
*/
USE CustDB
GO

IF @@SERVERNAME = 'DBCUST' -- ^_^
	RETURN

DECLARE @MaxCustID INT
--Get MaxCustID to avoid scan new cust data (new cust maybe not ready for replicate data)
SELECT @MaxCustID = MAX(custid) FROM custinfo WITH(NOLOCK)

--WAIT 10s before scan ( wait replicate current data)
WAITFOR DELAY '00:00:10'

DECLARE @BatchNum INT = 5000
CREATE TABLE #TempCust (
	 CustID	int
	,bitmapHasSynced	binary(32)
	,bitmapIsHidden	binary(32)
	,bitmapIsDisabled	binary(32)
	,SuspendInfo	tinyint
	,Locked	tinyint
	,CloseInfo	tinyint
)
CREATE TABLE #TempCustBatch (
	 CustID	int
	,bitmapHasSynced	binary(32)
	,bitmapIsHidden	binary(32)
	,bitmapIsDisabled	binary(32)
	,SuspendInfo	tinyint
	,Locked	tinyint
	,CloseInfo	tinyint
)

--> Get all cust have different data with DBCUST --> Update Data
INSERT INTO #TempCust(
	 custid
	,bitmapHasSynced
	,bitmapIsDisabled
	,bitmapIsHidden
	,CloseInfo
	,Locked
	,SuspendInfo
)
SELECT s.CustID
	,s.bitmapHasSynced
	,s.bitmapIsDisabled
	,s.bitmapIsHidden
	,s.CloseInfo
	,s.Locked
	,s.SuspendInfo
FROM CustProductStatus d WITH(NOLOCK)
	INNER JOIN DBCUST.CUSTDB.dbo.CustProductStatus s WITH(NOLOCK) ON d.CustID = s.CustID
WHERE  NOT(
		d.bitmapHasSynced	= s.bitmapHasSynced
	AND d.bitmapIsDisabled	= s.bitmapIsDisabled
	AND d.bitmapIsHidden	= s.bitmapIsHidden
	AND d.CloseInfo			= s.CloseInfo
	AND d.Locked			= s.Locked
	AND d.SuspendInfo		= s.SuspendInfo
	)
	AND s.CustID <= @MaxCustID

--> Update data
WHILE 1=1
BEGIN
	TRUNCATE TABLE #TempCustBatch

	DELETE TOP (@BatchNum) t
	OUTPUT deleted.custid 
		,deleted.bitmapHasSynced
		,deleted.bitmapIsDisabled
		,deleted.bitmapIsHidden
		,deleted.CloseInfo
		,deleted.Locked
		,deleted.SuspendInfo
	INTO #TempCustBatch( 
		 custid
		,bitmapHasSynced
		,bitmapIsDisabled
		,bitmapIsHidden
		,CloseInfo
		,Locked
		,SuspendInfo
	)
	FROM #TempCust t

	IF @@ROWCOUNT = 0
		BREAK

	UPDATE d
	SET  d.bitmapHasSynced	= s.bitmapHasSynced
		,d.bitmapIsDisabled	= s.bitmapIsDisabled
		,d.bitmapIsHidden	= s.bitmapIsHidden
		,d.CloseInfo		= s.CloseInfo
		,d.Locked			= s.Locked
		,d.SuspendInfo		= s.SuspendInfo
	FROM CustProductStatus d WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #TempCustBatch s WITH(NOLOCK) ON d.custid = s.CustID
END

--> Get all cust have on DBCUST, but not on SiteDB/DBTXN --> Insert Data
INSERT INTO CustProductStatus(
	 custid
	,bitmapHasSynced
	,bitmapIsDisabled
	,bitmapIsHidden
	,CloseInfo
	,Locked
	,SuspendInfo
)
SELECT s.CustID
	,s.bitmapHasSynced
	,s.bitmapIsDisabled
	,s.bitmapIsHidden
	,s.CloseInfo
	,s.Locked
	,s.SuspendInfo
FROM CustProductStatus d WITH(NOLOCK)
	RIGHT JOIN DBCUST.CUSTDB.dbo.CustProductStatus s WITH(NOLOCK) ON d.CustID = s.CustID
WHERE d.CustID IS NULL
	AND s.CustID <= @MaxCustID

--> Get all cust not have on DBCUST, but have on SiteDB/DBTXN --> Delete Data
DELETE d
FROM CustProductStatus d WITH(ROWLOCK,UPDLOCK)
	LEFT JOIN DBCUST.CUSTDB.dbo.CustProductStatus s WITH(NOLOCK) ON d.CustID = s.CustID
WHERE s.CustID IS NULL

DROP TABLE #TempCust
DROP TABLE #TempCustBatch
GO