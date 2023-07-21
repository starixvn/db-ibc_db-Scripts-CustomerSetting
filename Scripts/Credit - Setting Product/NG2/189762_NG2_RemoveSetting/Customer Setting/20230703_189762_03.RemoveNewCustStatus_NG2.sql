/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20230703
	Task: NG2 - Remove Setting - New customers
		https://nexdev.net/issues/189762
	DB: DBCust/CustDB
*/ 

CREATE TABLE #supers (custid INT PRIMARY KEY CLUSTERED)
CREATE TABLE #CustList (CustID INT PRIMARY KEY CLUSTERED)
CREATE TABLE #CustList_batch (CustID INT PRIMARY KEY CLUSTERED)

DECLARE @max_custid INT, @bitmapOrder tinyint

SELECT @max_custid = xxx

SET @bitmapOrder=4

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
INNER JOIN site s WITH (NOLOCK) ON s.site=ci.site
WHERE ci.roleid = 4  
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.SiteLabel='789y'

INSERT INTO #CustList (CustID)
SELECT c.custid
FROM Custinfo c WITH (NOLOCK)
	INNER JOIN #supers s ON c.srecommend = s.custid
WHERE c.custid > @max_custid

--Update Status
WHILE 1 = 1 
BEGIN
	DELETE FROM #CustList_batch

	DELETE TOP (3000) T OUTPUT deleted.CustID
		INTO #CustList_batch(CustID)
	FROM #CustList t 

	IF @@ROWCOUNT = 0 
		BREAK;

	UPDATE cs
	SET	bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cs.bitmapIsHidden, @bitmapOrder, 1)),
		bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cs.bitmapIsDisabled, @bitmapOrder, 1)),
		bitmapHasSynced = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cs.bitmapHasSynced, @bitmapOrder, 1))
	FROM [dbo].CustProductStatus cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #CustList_batch b ON cs.CustID = b.CustID 
	
	WAITFOR DELAY '00:00:0.050'
END

DROP TABLE #supers, #CustList, #CustList_batch
GO