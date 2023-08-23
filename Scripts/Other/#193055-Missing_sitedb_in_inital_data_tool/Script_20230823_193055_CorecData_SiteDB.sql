/*<info serverAlias="DBTXN/CUSTDB"></info>*/
/*	
	Created: 20230823@Eden
	Task: Correct data CustProductStatus of all sitedb [#193055]
	DB: DBTXN/CUSTDB (all siteDB)
*/
USE CustDB
GO

DECLARE @BatchNum INT = 5000
CREATE TABLE #TempCust (custid INT)
CREATE TABLE #TempCustBatch (custid INT)

--> Get all cust have different data with DB CUST
INSERT INTO #TempCust(custid)
SELECT d.CustID 
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

--> Sync data from DBCUST
WHILE 1=1
BEGIN
	TRUNCATE TABLE #TempCustBatch

	DELETE TOP (@BatchNum) t
	OUTPUT deleted.custid INTO #TempCustBatch(custid)
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
		INNER JOIN #TempCustBatch t WITH(NOLOCK) ON t.custid = d.CustID
		INNER JOIN DBCUST.CUSTDB.dbo.CustProductStatus s WITH(NOLOCK) ON d.CustID = s.CustID
	WHERE  NOT(
			d.bitmapHasSynced	= s.bitmapHasSynced
		AND d.bitmapIsDisabled	= s.bitmapIsDisabled
		AND d.bitmapIsHidden	= s.bitmapIsHidden
		AND d.CloseInfo			= s.CloseInfo
		AND d.Locked			= s.Locked
		AND d.SuspendInfo		= s.SuspendInfo
		)
END
DROP TABLE #TempCust
DROP TABLE #TempCustBatch
GO