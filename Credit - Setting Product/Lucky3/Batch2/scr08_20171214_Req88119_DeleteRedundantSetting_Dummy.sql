/*
	Created: Elodie
	Task: Delete redundant setting and copy Setting for newly created customer
	DB: DBCUST/CustDB
	Date: 20171214
*/ 
USE CustDB
GO

PRINT N'Step 8: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

DECLARE @Sporttype SMALLINT = 160
DECLARE @MaxCustID INT, @MaxCustID_New INT
	
SELECT @MaxCustID = xxx
SELECT @MaxCustID_New = xxx
	
CREATE TABLE #OfferedSite (site VARCHAR(10))
INSERT INTO #OfferedSite (site)
VALUES  ('733333'), ('222223'), ('222225'), ('222227'), ('033333'), ('JPNIBC'), ('611111'), ('722222'), ('766666'), ('7aa666'), ('BEST-ODDS'), ('XYZbet')       

CREATE TABLE #DummySupers (custid int)

INSERT INTO #DummySupers(custid)
SELECT ci.custid
FROM dbo.Customer ci WITH(NOLOCK)
WHERE ci.custid IN (1,2,3,4,5,6,9,12,13,15,16,17,22,30,32,33,34,35,36,41,42) -- dummy account	
				          
CREATE TABLE #MemberTemp
(
	CustID INT PRIMARY KEY CLUSTERED,
	currency INT,
	Type BIT --0: Dummy account or Direct account, 1: Indirect account
)

CREATE TABLE #SMATemp
(
	CustID INT PRIMARY KEY CLUSTERED,
	roleid TINYINT,
	currency INT,
	Type BIT --0: Dummy account or Direct account, 1: Indirect account
)
	
	
CREATE TABLE #DirectMaster (CustID INT PRIMARY KEY,roleid TINYINT)
CREATE TABLE #DirectAgent (CustID INT PRIMARY KEY,mrecommend INT,roleid TINYINT)
CREATE TABLE #DirectMember (CustID INT PRIMARY KEY,recommend INT,mrecommend INT,roleid TINYINT)			
--- get direct master
INSERT INTO #DirectMaster (CustID,roleid)
SELECT ci.custid, ci.roleid
FROM Customer ci with(nolock)
INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
WHERE  EXISTS (SELECT 1 FROM #OfferedSite WHERE site = ci.site)
	AND  EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
	AND ci.roleid=3 AND ci.srecommend IN (SELECT custid FROM #DummySupers)
	AND c.Enabled=1
		
--- get direct agent
INSERT INTO #DirectAgent (CustID,mrecommend,roleid)
SELECT ci.custid, ci.mrecommend,ci.roleid
FROM Customer ci WITH(NOLOCK)
INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
WHERE  EXISTS (SELECT 1 FROM #OfferedSite WHERE site = ci.site)
	AND  EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
	and ci.roleid = 2 AND ci.srecommend IN (SELECT custid FROM #DummySupers)
	AND c.Enabled=1

INSERT INTO #DirectMember(CustID,recommend,mrecommend,roleid)
SELECT c.custid, c.recommend,c.mrecommend,c.roleid
FROM Customer c WITH(NOLOCK)
INNER JOIN Customer ca (nolock) on c.recommend=ca.custid 
INNER JOIN custInfo ci WITH(NOLOCK) ON ci.custid=c.custid
WHERE EXISTS (SELECT 1 FROM #OfferedSite WHERE site = ca.site)
	AND EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
	AND c.roleid=1 AND ci.srecommend IN (SELECT custid FROM #DummySupers)
	AND ci.Enabled=1

----------- For SMA  -----------
INSERT INTO #SMATemp (CustID,RoleID, Type)
-----------------------Master--------------------------------------
SELECT d.CustID, 3, 0 -- Direct Master 
FROM #DirectMaster d 
WHERE d.CustID > @MaxCustID	AND d.custid <= @MaxCustID_New
UNION 
SELECT DISTINCT d.mrecommend, 3, 0 -- Master of direct agent
FROM #DirectAgent d
WHERE d.mrecommend > @MaxCustID	AND d.mrecommend <= @MaxCustID_New
UNION 
SELECT DISTINCT d.mrecommend, 3, 0 -- Master of direct member
FROM #DirectMember D 	
WHERE d.mrecommend > @MaxCustID	AND d.mrecommend <= @MaxCustID_New
UNION 
-----------------------Agent--------------------------------------
SELECT ci.CustID,2, 1 -- Agent of direct master
FROM custInfo ci WITH (NOLOCK)
	INNER JOIN #DirectMaster D ON ci.mrecommend = d.CustID 
WHERE ci.roleid = 2 AND ci.Enabled=1 AND ci.custid > @maxcustid	AND ci.custid <= @MaxCustID_New 
UNION
SELECT DISTINCT d.recommend, 2, 0 -- agent of direct member
FROM #DirectMember D 	
WHERE d.recommend > @MaxCustID	AND d.recommend <= @MaxCustID_New
UNION 
SELECT d.CustID, 2, 0 -- Direct Agent
FROM #DirectAgent D
WHERE d.CustID > @MaxCustID AND d.custid <= @MaxCustID_New 	
	 	
---------- For members ---------
INSERT INTO #MemberTemp (CustID, Type)
SELECT  ci.custid, 1 -- member of direct master
FROM Custinfo ci WITH (NOLOCK)
	INNER JOIN #DirectMaster m ON ci.mrecommend = m.CustID
WHERE ci.roleid = 1	AND ci.custid > @maxcustid AND ci.Enabled = 1 AND ci.custid <= @MaxCustID_New  			
UNION ALL -- member of direct agent
SELECT  ci.custid, 1
FROM Custinfo ci WITH (NOLOCK)
	INNER JOIN #DirectAgent a ON ci.recommend = a.CustID
WHERE ci.roleid = 1 AND ci.custid > @maxcustid AND ci.Enabled = 1 AND ci.custid <= @MaxCustID_New  			
-- Direct member		
UNION ALL
SELECT ci.custid, 0
FROM #DirectMember ci
WHERE ci.CustID > @MaxCustID AND ci.custid <= @MaxCustID_New 	

----Delete setting
DELETE cg
FROM dbo.CustDiscount3rd_Agent cg WITH(UPDLOCK,ROWLOCK)	
	INNER JOIN #SMATemp c WITH (NOLOCK) ON cg.CustID = c.custid
WHERE SportType = @Sporttype

DELETE cg
FROM dbo.CustDiscount3rd_Member cg WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #MemberTemp c WITH (NOLOCK) ON cg.CustID = c.custid
WHERE SportType = @Sporttype

----Insert setting
DECLARE @ProductID TINYINT = 26
CREATE TABLE #DestinationSportBetType(tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT)
INSERT INTO #DestinationSportBetType (tSportType, tBetType, IsLive, SettingType)
SELECT	SportType, BetType, 0, SettingType
FROM dbo.ProductSettingDetail WITH (NOLOCK)
WHERE ProductID = @ProductID AND SettingType IN (14)	

DECLARE @TicketComm DECIMAL(9,8) = 0.1
--------------------------------------Ticket Commission Setting-------------------------------------------------		
--Agent Level
INSERT INTO dbo.CustDiscount3rd_Agent(CustID, SportType, BetType, Discount)
SELECT ci.custid, dest.tsporttype, dest.tbettype, 
		CASE WHEN Type = 0 THEN @TicketComm ELSE 0 END
FROM #SMATemp ci 
	CROSS APPLY #DestinationSportBetType dest
WHERE dest.SettingType = 14
		 
--Member Level
INSERT INTO dbo.CustDiscount3rd_Member(CustID, SportType, BetType, PlayerDiscount, AgentDiscount, MasterDiscount, SuperDiscount)
SELECT ci.custid, dest.tsporttype, dest.tbettype, 0, 0, 0, 0
FROM #MemberTemp ci WITH(NOLOCK) 
	CROSS APPLY #DestinationSportBetType dest
WHERE dest.SettingType = 14

/*******************************CUST PRODUCT STATUS TABLE*******************************/	
DECLARE @BitmapOrder TINYINT = 9
	
--Member level
UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
	bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,1))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #MemberTemp ci WITH(NOLOCK) ON cs.CustID = ci.CustID

DROP TABLE #SMATemp
DROP TABLE #MemberTemp
DROP TABLE #DestinationSportBetType	

PRINT N'Step 8: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 