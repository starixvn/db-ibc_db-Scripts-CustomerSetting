/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211201@Johnson
	Task: Enable Cash Out for newly customers Athena000
	DB: DBCust/CustDB
*/

DECLARE @Custid INT, @max_custid INT

SELECT @max_custid = xxx

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT (0))

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'		
	AND ci.Enabled=1
	AND cs.site IN('Athena000')

CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)	
CREATE TABLE #tblCust (CustID INT PRIMARY KEY)
DECLARE @tmp TABLE (custid INT PRIMARY KEY)

DECLARE @BitmapOrder INT = 31
	
INSERT INTO #Dummy(CustID)
SELECT CustID 
FROM Customer WITH(NOLOCK) 
WHERE srecommend IN (SELECT custid FROM #Supers)
	AND roleid=3 
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%')

INSERT INTO #tblCust(CustID)
SELECT ci.CustID
FROM custInfo ci WITH(NOLOCK)
	INNER JOIN Dep_CustProductStatus cs WITH(NOLOCK) ON ci.custid = cs.custid
WHERE ci.srecommend IN (SELECT custid FROM #Supers)
	AND ci.custid > @max_custid 		
	AND ci.Enabled=1
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)
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
	FROM [dbo].[Dep_CustProductStatus] cs WITH(ROWLOCK)
	WHERE custid IN (SELECT custid FROM @tmp)
		
	DELETE @tmp		
END
	
DROP TABLE #tblCust	
DROP TABLE #Dummy