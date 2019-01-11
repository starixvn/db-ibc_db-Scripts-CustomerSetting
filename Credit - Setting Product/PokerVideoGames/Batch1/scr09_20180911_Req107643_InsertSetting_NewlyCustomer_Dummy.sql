/*
	Created: Winnie
	Task: Copy Setting for newly created customer
	DB: DBCUST/CustDB
	Date: 20190110
*/ 
PRINT N'Step 9: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

DECLARE @MaxCustID INT
	
SELECT @MaxCustID = xxx

DECLARE @Sporttype INT
SELECT @Sporttype=165	
DECLARE @BitOrder INT,@BitOrder1402 INT,@Bettype INT =1901
SELECT @BitOrder= bitmapOrder from ProductStatusProfile WITH(NOLOCK) where SportType=@Sporttype
SELECT @BitOrder1402= bitmapOrder from ProductStatusProfile WITH(NOLOCK) where SportType=163 AND Bettype=1402

CREATE TABLE #OfferedSite (site VARCHAR(10))
INSERT INTO #OfferedSite (site)
VALUES  ('789y')

CREATE TABLE #DummySupers (custid int)

INSERT INTO #DummySupers(custid)
SELECT ci.custid
FROM dbo.Customer ci WITH(NOLOCK)
WHERE ci.custid IN (16) -- dummy account				
				          
CREATE TABLE #MemberTemp
(
	CustID INT PRIMARY KEY CLUSTERED,
	currency INT,
	Type TINYINT --0: Direct member, 1: Member of Direct Agent, 2: Member of Direct Master
)

CREATE TABLE #SMATemp
(
	CustID INT PRIMARY KEY CLUSTERED,
	roleid TINYINT,
	currency INT,
	Type BIT --0: Dummy account or Direct account, 1: Indirect account
)
	
CREATE TABLE #DirectMaster (CustID INT PRIMARY KEY,roleid INT,currency INT)
CREATE TABLE #DirectAgent (CustID INT PRIMARY KEY,mrecommend INT,roleid INT,currency INT)
CREATE TABLE #DirectMember (CustID INT PRIMARY KEY,recommend INT,mrecommend INT,roleid INT,currency INT)			
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
INSERT INTO #SMATemp (CustID,RoleID,currency, Type)
-----------------------Master--------------------------------------
SELECT d.CustID, 3, currency, 0 -- Direct Master 
FROM #DirectMaster d
WHERE d.CustID > @MaxCustID	
UNION 
SELECT DISTINCT d.mrecommend, 3, currency, 0 -- Master of direct agent
FROM #DirectAgent d
WHERE d.mrecommend > @MaxCustID
UNION 
SELECT DISTINCT d.mrecommend, 3, currency, 0 -- Master of direct member
FROM #DirectMember D 	
WHERE d.mrecommend > @MaxCustID
UNION 
-----------------------Agent--------------------------------------
SELECT ci.CustID,2, ci.currency, 1 -- Agent of direct master
FROM custInfo ci WITH (NOLOCK)
	INNER JOIN #DirectMaster D ON ci.mrecommend = d.CustID 
WHERE ci.roleid = 2 AND ci.Enabled=1 AND ci.custid > @maxcustid 
UNION
SELECT DISTINCT d.recommend, 2, currency, 0 -- agent of direct member
FROM #DirectMember D 	
WHERE d.recommend > @MaxCustID
UNION 
SELECT d.CustID, 2, currency, 0 -- Direct Agent
FROM #DirectAgent D
WHERE d.CustID > @MaxCustID	
	 	
---------- For members ---------
INSERT INTO #MemberTemp (CustID, currency, Type)
SELECT  ci.custid, ci.currency, 2 -- member of direct master
FROM Custinfo ci WITH (NOLOCK)
	INNER JOIN #DirectMaster m ON ci.mrecommend = m.CustID
WHERE ci.roleid = 1	AND ci.custid > @maxcustid AND ci.Enabled = 1 			
UNION ALL -- member of direct agent
SELECT  ci.custid, ci.currency, 1
FROM Custinfo ci WITH (NOLOCK)
	INNER JOIN #DirectAgent a ON ci.recommend = a.CustID
WHERE ci.roleid = 1 AND ci.custid > @maxcustid AND ci.Enabled = 1 			
-- Direct member		
UNION ALL
SELECT ci.custid, currency, 0
FROM #DirectMember ci
WHERE ci.CustID > @MaxCustID


----------------------------------------Betlimit Setting-------------------------------------------------		
--Agent Level
INSERT INTO dbo.CustStakeLevel_Agent  ([CustID]
										,[SportType]
										,[BetType]
										,[StakeLevelList]) 
SELECT t.custid,@Sporttype, @Bettype, CAST(StakeLevelID AS varchar(50))
FROM StakeLevel WITH(NOLOCK) 
CROSS JOIN  #SMATemp t
WHERE GameGroupID=9 AND GameTypeID=1901 AND ExchangeId=t.currency

--Member Level
INSERT INTO dbo.CustStakeLevel_Member([CustID]
									,[SportType]
									,[BetType]
									,[StakeLevelList]
									,LastUpdated) 
SELECT t.custid,@Sporttype, @Bettype, CAST(StakeLevelID AS varchar(50)),GETDATE()
FROM StakeLevel WITH(NOLOCK) 
CROSS JOIN  #MemberTemp t
WHERE GameGroupID=9 AND GameTypeID=1901 AND ExchangeId=t.currency

CREATE TABLE #tempMember (CustID INT PRIMARY KEY,DisableVideoGame BIT DEFAULT(1))
CREATE TABLE #tempSMA (CustID INT PRIMARY KEY,DisableVideoGame BIT DEFAULT(1))

INSERT INTO #tempMember(CustID,DisableVideoGame)
SELECT ci.custid,dbo.f_GetProductStatus(s.bitmapIsDisabled,@BitOrder1402)
FROM #MemberTemp CI WITH (NOLOCK) 
	INNER JOIN CustProductStatus s WITH(NOLOCK) ON ci.custid=s.CustID

INSERT INTO #tempSMA(CustID,DisableVideoGame)
SELECT ci.custid,dbo.f_GetProductStatus(s.bitmapIsDisabled,@BitOrder1402)
FROM #SMATemp CI WITH (NOLOCK) 
	INNER JOIN CustProductStatus s WITH(NOLOCK) ON ci.custid=s.CustID


UPDATE cs
	SET								
			bitmapIsHidden =  dbo.f_GenerateProductStatus (cs.bitmapIsHidden,@BitOrder,0),
			bitmapIsDisabled = dbo.f_GenerateProductStatus (cs.bitmapIsDisabled,@BitOrder,DisableVideoGame)
	FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #tempMember CI WITH (NOLOCK) ON cs.CustID = ci.CustID

UPDATE cs
	SET								
			bitmapIsHidden =  dbo.f_GenerateProductStatus (cs.bitmapIsHidden,@BitOrder,0),
			bitmapIsDisabled = dbo.f_GenerateProductStatus (cs.bitmapIsDisabled,@BitOrder,DisableVideoGame)
	FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #tempSMA CI WITH (NOLOCK) ON cs.CustID = ci.CustID


DROP TABLE #SMATemp
DROP TABLE #MemberTemp


PRINT N'Step 9: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 