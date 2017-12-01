/*
	Created: Elodie
	Task: Set MinPT = 0 for dummy and direct account
	DB: DBCUST/CustDB
	Date: 20171201
*/ 
USE CustDB
GO

PRINT N'Step 10.2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #OfferedSite (site VARCHAR(10))
INSERT INTO #OfferedSite (site)
VALUES  ('755555'), ('789y')

CREATE TABLE #DummySupers (custid int)

INSERT INTO #DummySupers(custid)
SELECT ci.custid
FROM dbo.Customer ci WITH(NOLOCK)
WHERE ci.custid IN (2,3,4,13,16,17,35,21278849,21278858) -- dummy account			
				          
CREATE TABLE #SMATemp
(
	CustID INT PRIMARY KEY CLUSTERED,
	roleid TINYINT
)
	
CREATE TABLE #DirectMaster (CustID INT PRIMARY KEY,roleid INT)
CREATE TABLE #DirectAgent (CustID INT PRIMARY KEY,mrecommend INT,roleid INT)
CREATE TABLE #DirectMember (CustID INT PRIMARY KEY,recommend INT,mrecommend INT,roleid INT)			
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
SELECT DISTINCT d.recommend, 2 -- agent of direct member
FROM #DirectMember D 	
UNION 
SELECT d.CustID, 2 -- Direct Agent
FROM #DirectAgent D	 	

DECLARE @ProductID TINYINT = 30
CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT)
INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType)
SELECT	1, 5, SportType, BetType, 0, SettingType
FROM dbo.ProductSettingDetail WITH (NOLOCK)
WHERE ProductID = @ProductID AND SettingType IN (1)

--------------------------------------PT Setting-------------------------------------------------	
--AGENT LEVEL
UPDATE cs
SET cs.MinPT = 0
FROM dbo.CustPTSetting3rd_Agent cs WITH(NOLOCK) 
	INNER JOIN #DestinationSportBetType dest WITH(NOLOCK) ON cs.sporttype = dest.tsporttype and cs.bettype = dest.tbettype
	INNER JOIN #SMATemp ci ON ci.custid = cs.custid
WHERE dest.SettingType = 1

DROP TABLE #SMATemp
DROP TABLE #DestinationSportBetType		

PRINT N'Step 10.2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 