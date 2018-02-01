/*
	Created: Elodie	
	Task: Update Hide Status of AllBet & Macau Game
	DB: DBCUST/CustDB
	Date: 20180201
*/ 

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

DECLARE @bitmapOrder TINYINT	

INSERT INTO #Supers(custid)
SELECT ci.custid 
FROM dbo.customer c WITH (Nolock) 
	INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
	INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
WHERE ci.roleid = 4
	AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))	
	AND ci.custid NOT IN (SELECT custid FROM dbo.CustSuper WITH(NOLOCK) WHERE isInternal = 1)
	AND ci.Enabled = 1
	AND s.islicensee = 0
	AND c.username NOT LIKE '3rdSuper%'

SELECT ci.custid, ci.roleid
INTO #CustList
FROM dbo.custInfo ci WITH (NOLOCK)
	INNER JOIN #Supers s ON ci.srecommend = s.custid
WHERE ci.custid > @max_custid
	
SELECT @BitmapOrder = 6

UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #CustList ci WITH(NOLOCK) ON cs.CustID = ci.CustID
WHERE (SELECT value FROM dbo.f_CustSetting_ProductStatusSel(bitmapHasSynced, @BitmapOrder)) = 1	
	AND (SELECT value FROM dbo.f_CustSetting_ProductStatusSel(bitmapIsHidden, @BitmapOrder)) = 1

SELECT @BitmapOrder = 7
UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
	cs.bitmapHasSynced = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapHasSynced,@BitmapOrder,1))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #CustList ci WITH(NOLOCK) ON cs.CustID = ci.CustID
WHERE (SELECT value FROM dbo.f_CustSetting_ProductStatusSel(bitmapHasSynced, 6)) = 1	
	AND (SELECT value FROM dbo.f_CustSetting_ProductStatusSel(bitmapIsHidden, @BitmapOrder)) = 1	