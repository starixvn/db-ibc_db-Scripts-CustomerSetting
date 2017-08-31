/*
	Created: Elodie	
	Task: Initialize Product Status of Lottery for Credit customers
	DB: DBCUST/CustDB
	Date: 20170801
*/ 
PRINT N'Step 14: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

CREATE TABLE #OfferedSite (site VARCHAR(10))
INSERT INTO #OfferedSite (site)
VALUES  ('033333'), ('611111'), ('722222'), ('766666'), ('789y'), ('7aa666'), ('BEST-ODDS'), ('JPNIBC'), ('XYZBET')	          

CREATE TABLE #DummySupers (custid int)

INSERT INTO #DummySupers(custid)
SELECT ci.custid
FROM dbo.Customer ci WITH(NOLOCK)
WHERE ci.custid IN (1,2,3,4,5,6,9,12,13,15,16,17,22,30,32,33,34,35,36,41,42,21278849,21278858) -- dummy account	

CREATE TABLE #SMATemp
(
	CustID INT PRIMARY KEY CLUSTERED,
	roleid TINYINT
)
	
CREATE TABLE #DirectMaster (CustID INT PRIMARY KEY,roleid TINYINT,currency INT)
CREATE TABLE #DirectAgent (CustID INT PRIMARY KEY,mrecommend INT,roleid TINYINT,currency INT)
CREATE TABLE #DirectMember (CustID INT PRIMARY KEY,recommend INT,mrecommend INT,roleid TINYINT,currency INT)			
--- get direct master
INSERT INTO #DirectMaster (CustID,roleid,currency)
SELECT ci.custid, ci.roleid,c.currency
FROM Customer ci with(nolock)
INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
WHERE  EXISTS (SELECT 1 FROM #OfferedSite WHERE site = ci.site)
	AND  EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
	AND ci.roleid=3 AND ci.srecommend IN (SELECT custid FROM #DummySupers)
	AND c.Enabled=1
		
--- get direct agent
INSERT INTO #DirectAgent (CustID,mrecommend,roleid,currency)
SELECT ci.custid, ci.mrecommend,ci.roleid,c.currency
FROM Customer ci WITH(NOLOCK)
INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
WHERE  EXISTS (SELECT 1 FROM #OfferedSite WHERE site = ci.site)
	AND  EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
	and ci.roleid = 2 AND ci.srecommend IN (SELECT custid FROM #DummySupers)
	AND c.Enabled=1

INSERT INTO #DirectMember(CustID,recommend,mrecommend,roleid,currency)
SELECT c.custid, c.recommend,c.mrecommend,c.roleid,c.currency
FROM Customer c WITH(NOLOCK)
INNER JOIN Customer ca (nolock) on c.recommend=ca.custid 
INNER JOIN custInfo ci WITH(NOLOCK) ON ci.custid=c.custid
WHERE EXISTS (SELECT 1 FROM #OfferedSite WHERE site = ca.site)
	AND EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
	AND c.roleid=1 AND ci.srecommend IN (SELECT custid FROM #DummySupers)
	AND ci.Enabled=1

----------- For SMA  -----------
INSERT INTO #SMATemp (CustID,RoleID)
SELECT custid, 4 -- Super
FROM #DummySupers
UNION ALL
-----------------------Master--------------------------------------
SELECT d.CustID, 3 -- Direct Master 
FROM #DirectMaster d	
UNION 
SELECT DISTINCT d.mrecommend, 3 -- Master of direct agent
FROM #DirectAgent d
UNION 
SELECT DISTINCT d.mrecommend, 3 -- Master of direct member
FROM #DirectMember D 	
UNION 
-----------------------Agent--------------------------------------
SELECT ci.CustID,2 -- Agent of direct master
FROM custInfo ci WITH (NOLOCK)
	INNER JOIN #DirectMaster D ON ci.mrecommend = d.CustID 
WHERE ci.roleid = 2 AND ci.Enabled=1 
UNION
SELECT DISTINCT d.recommend, 2 -- agent of direct member
FROM #DirectMember D 	
UNION 
SELECT d.CustID, 2 -- Direct Agent
FROM #DirectAgent D
UNION ALL
--dummy account don't have member enabled
SELECT ci.custid
FROM Custinfo ci WITH (NOLOCK)
WHERE username IN ('WSNT','midrup','MLOTTO','MSSD')

/*******************************CUST PRODUCT STATUS TABLE*******************************/	
DECLARE @BitmapOrder TINYINT = 11
	
--SMA level
UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
	bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,0))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #SMATemp ci WITH(NOLOCK) ON cs.CustID = ci.CustID

PRINT N'Step 14: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 