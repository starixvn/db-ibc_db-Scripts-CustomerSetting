/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20231127
	Task: Credit - Update value Cash out Status for 611111 - New Customer
		https://nexdev.net/issues/197484
	DB: DBCust/CustDB
*/ 

CREATE TABLE #tbCustomer (CustID INT PRIMARY KEY CLUSTERED)
CREATE TABLE #tbCustomer_batch (CustID INT PRIMARY KEY CLUSTERED)

DECLARE @max_custid INT, @bitmapOrder tinyint

SELECT @max_custid = xxx

SET @bitmapOrder=36

INSERT INTO #tbCustomer(CustID)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
INNER JOIN custInfo c WITH (NOLOCK) ON c.custid=ci.custid
LEFT JOIN Dep_CustSuper cs WITH (NOLOCK) ON cs.custid=ci.srecommend
WHERE cs.custid IS NULL
	AND ci.custid > @max_custid
	AND ci.site='611111' AND c.Enabled=1

---------------------------------------------------------------------------------------------
DECLARE @msg_total NVARCHAR(200) = 'Total of new Customers Affected: %d.'
		,@Cust_cnt	INT	

SELECT @Cust_cnt = COUNT(1)
FROM #tbCustomer

RAISERROR (@msg_total, 0, 1, @Cust_cnt) WITH NOWAIT
---------------------------------------------------------------------------------------------

--Update Status
WHILE 1 = 1 
BEGIN
	DELETE FROM #tbCustomer_batch

	DELETE TOP (3000) T OUTPUT deleted.CustID
		INTO #tbCustomer_batch(CustID)
	FROM #tbCustomer t 

	IF @@ROWCOUNT = 0 
		BREAK;

	UPDATE cs
	SET	bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cs.bitmapIsHidden, @bitmapOrder, 1)),
		bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cs.bitmapIsDisabled, @bitmapOrder, 1))
	FROM [dbo].CustProductStatus cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #tbCustomer_batch b ON cs.CustID = b.CustID 
	
	WAITFOR DELAY '00:00:0.050'
END

DROP TABLE #tbCustomer, #tbCustomer_batch
GO