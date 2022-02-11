/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211125@Johnson
	Task: Enable Cash Out for newly customers
	DB: DBCust/CustDB
*/
DECLARE @Custid INT, @max_custid INT

SELECT @max_custid = xxx

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT (0))

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN custInfo C WITH (NOLOCK) ON C.custid = ci.custid	
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid	
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'	
	AND Enabled = 1	
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND ci.currency = 20
	AND cs.isinternal = 0
	AND s.islicensee = 0
	
CREATE TABLE #tblCust (custid INT PRIMARY KEY)
DECLARE @tmp TABLE (custid INT PRIMARY KEY)

DECLARE @BitmapOrder TINYINT = 36

INSERT INTO #tblCust(custid)
SELECT ci.custid
FROM custInfo ci WITH(NOLOCK)
	INNER JOIN CustProductStatus cs WITH(ROWLOCK) ON cs.custid = ci.custid
WHERE srecommend IN (SELECT custid FROM #Supers)
	AND ci.custid > @max_custid
	AND Enabled = 1
	AND ((SELECT value FROM dbo.f_CustSetting_ProductStatusSel(cs.bitmapIsHidden, @bitmapOrder)) = 1
		OR (SELECT value FROM dbo.f_CustSetting_ProductStatusSel(cs.bitmapIsDisabled, @bitmapOrder)) = 1)
	
WHILE(1=1)
BEGIN
	DELETE TOP (500) t
	OUTPUT DELETED.custid INTO @tmp(custid)
	FROM #tblCust t
	
	IF @@ROWCOUNT = 0
		BREAK;
		
	UPDATE cs
	SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
		bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,0)) 	
	FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK)
	WHERE custid IN (SELECT custid FROM @tmp)
		
	DELETE @tmp		
	
	WAITFOR DELAY '0:0:1'
END
	
DROP TABLE #tblCust			
