/*
	Created: Elodie
	Task: Copy Setting for newly created customer
	DB: DBCUST/CustDB
	Date: 20180815
*/ 
PRINT N'Step 9: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

DECLARE @MaxCustID INT, @fSportType SMALLINT, @fBetType SMALLINT
	
SELECT @MaxCustID = xxx
	
CREATE TABLE #OfferedSite (site VARCHAR(10))
INSERT INTO #OfferedSite (site)
VALUES  ('789y')

CREATE TABLE #DummySupers (custid int)

INSERT INTO #DummySupers(custid)
SELECT ci.custid
FROM dbo.Customer ci WITH(NOLOCK)
WHERE ci.custid IN (2,3,16,17,35,21278849,21278858) -- dummy account				
				          
CREATE TABLE #MemberTemp
(
	CustID INT PRIMARY KEY CLUSTERED,
	Type TINYINT --0: Direct member, 1: Member of Direct Agent, 2: Member of Direct Master
)

CREATE TABLE #SMATemp
(
	CustID INT PRIMARY KEY CLUSTERED,
	roleid TINYINT,
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

DECLARE @ProductID INT = 33, @currency INT

SELECT t.* 
INTO #SportBettypeFilter3
FROM ProductSettingDetail t WITH (NOLOCK)
WHERE t.SettingType = 3 AND t.ProductID = @ProductID

SELECT t.* 
INTO #SportBettypeFilter6
FROM ProductSettingDetail t WITH (NOLOCK)
WHERE t.SettingType = 6 AND t.ProductID = @ProductID

----------------------------------------Comm Setting-------------------------------------------------		
--Agent Level
INSERT INTO dbo.CustDiscount3rd_Agent (CustID, SportType, BetType, Discount)	        
SELECT ci.custid, sb.SportType, sb.BetType, 
	CASE	WHEN ci.Type = 0 THEN 0.85
			ELSE 0 END 
FROM #SMATemp ci WITH(NOLOCK)
	CROSS APPLY #SportBettypeFilter3 sb 

--Member Level
INSERT INTO dbo.CustDiscount3rd_Member(CustID, SportType, BetType, PlayerDiscount, AgentDiscount, MasterDiscount, SuperDiscount)
SELECT ci.custid, sb.SportType, sb.BetType, 
		CASE WHEN ci.Type = 0 THEN 0.85 ELSE 0 END,
		CASE WHEN ci.Type = 2 THEN 0 ELSE 0.85 END, 
		0.85, 0.85
FROM #MemberTemp ci WITH(NOLOCK)
	CROSS APPLY #SportBettypeFilter3 sb

----------------------------------------WinLoss Limit Setting-------------------------------------------------		
--Agent Level
INSERT INTO dbo.CustWinLossLimit_Agent (CustID, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
SELECT ci.custid, sb.SportType, sb.BetType, 0, 
	CASE	WHEN FLOOR(ci.Credit * 0.1) < cs.MinLossLimit THEN cs.MinLossLimit
			WHEN FLOOR(ci.Credit * 0.1) > cs.DefaultLossLimit THEN cs.DefaultLossLimit ELSE FLOOR(ci.Credit * 0.1) END, 1
FROM #SMATemp c WITH(NOLOCK)
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = c.CustID
	INNER JOIN dbo.LossLimit_GlobalSetting cs WITH(NOLOCK) ON ci.currency = cs.ExchangeId
	CROSS APPLY #SportBettypeFilter6 sb
WHERE cs.ProductId = @ProductID	
		 
--Member Level
INSERT INTO dbo.CustWinLossLimit_Member(CustID, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
SELECT ci.custid, sb.SportType, sb.BetType, 0,
	CASE	WHEN FLOOR(ci.Credit * 0.1) < cs.MinLossLimit THEN cs.MinLossLimit
			WHEN FLOOR(ci.Credit * 0.1) > cs.DefaultLossLimit THEN cs.DefaultLossLimit ELSE FLOOR(ci.Credit * 0.1) END, 1
FROM #MemberTemp c WITH(NOLOCK)
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = c.CustID
	INNER JOIN dbo.LossLimit_GlobalSetting cs WITH(NOLOCK) ON ci.currency = cs.ExchangeId
	CROSS APPLY #SportBettypeFilter6 sb
WHERE cs.ProductId = @ProductID	

/*******************************CUST PRODUCTSTATUS TABLE*******************************/	
DECLARE @xmlStrValue_0 XML, @xmlStrValue_1 XML, @Sporttype SMALLINT = 163

SET @xmlStrValue_0 =(
		SELECT (
				SELECT psp.bitmapOrder	AS '@b'
					, 0	AS '@s'
				FROM ProductStatusProfile psp WITH (NOLOCK)
				WHERE psp.Sporttype = @Sporttype AND Bettype BETWEEN 1401 AND 1404
				FOR XML PATH('r')
					, TYPE
				)
		FOR XML PATH('root')
			, TYPE
		)

SET @xmlStrValue_1 =(
		SELECT (
				SELECT psp.bitmapOrder	AS '@b'
					, 1	AS '@s'
				FROM ProductStatusProfile psp WITH (NOLOCK)
				WHERE psp.Sporttype = @Sporttype AND Bettype BETWEEN 1401 AND 1404
				FOR XML PATH('r')
					, TYPE
				)
		FOR XML PATH('root')
			, TYPE
		)

UPDATE cs
SET cs.bitmapIsHidden = (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsDisabled, CONVERT(VARCHAR(MAX),@xmlStrValue_0))),
	bitmapIsDisabled = (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsDisabled, CONVERT(VARCHAR(MAX),@xmlStrValue_0)))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #SMATemp ci WITH(NOLOCK) ON cs.CustID = ci.CustID

UPDATE cs
SET cs.bitmapIsHidden = (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsDisabled, CONVERT(VARCHAR(MAX),@xmlStrValue_0))),	
	--Should update disabled = 1 for newly member
	cs.bitmapIsDisabled = (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsDisabled, CONVERT(VARCHAR(MAX),@xmlStrValue_1)))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #MemberTemp ci WITH(NOLOCK) ON cs.CustID = ci.CustID

DROP TABLE #SMATemp
DROP TABLE #MemberTemp
DROP TABLE #SportBettypeFilter3
DROP TABLE #SportBettypeFilter6	

PRINT N'Step 9: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 