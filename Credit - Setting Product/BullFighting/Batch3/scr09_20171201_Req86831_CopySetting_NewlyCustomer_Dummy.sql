/*
	Created: Elodie
	Task: Copy Setting for newly created customer
	DB: DBCUST/CustDB
	Date: 20171201
*/ 
PRINT N'Step 9: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

DECLARE @MaxCustID INT, @fSportType SMALLINT, @fBetType SMALLINT
	
SELECT @MaxCustID = xxx
	
CREATE TABLE #OfferedSite (site VARCHAR(10))
INSERT INTO #OfferedSite (site)
VALUES  ('755555'), ('789y')

CREATE TABLE #DummySupers (custid int)

INSERT INTO #DummySupers(custid)
SELECT ci.custid
FROM dbo.Customer ci WITH(NOLOCK)
WHERE ci.custid IN (2,3,4,13,16,17,35,21278849,21278858) -- dummy account			
				          
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
INSERT INTO #MemberTemp (CustID, currency)
SELECT  ci.custid, ci.currency, 1 -- member of direct master
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

DECLARE @ProductID TINYINT = 30
CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT)
INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType)
SELECT	1, 5, SportType, BetType, 0, SettingType
FROM dbo.ProductSettingDetail WITH (NOLOCK)
WHERE ProductID = @ProductID AND SettingType IN (1,3,6,16)

DECLARE @MaxPT TINYINT--, @MaxComm DECIMAL(9,8), @Currency INT
SELECT TOP 1 @MaxPT = MaxPT FROM dbo.ProductSettingDetail WITH (NOLOCK) WHERE ProductID = @ProductID AND SettingType = 1
--SELECT TOP 1 @MaxComm = MaxDiscount FROM dbo.ProductSettingDetail WITH (NOLOCK) WHERE ProductID = @ProductID AND SettingType = 3
	
--------------------------------------PT Setting-------------------------------------------------	
SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType 
FROM #DestinationSportBetType		
WHERE SettingType = 1

--AGENT LEVEL
INSERT INTO dbo.CustPTSetting3rd_Agent
	(	[CustID]
		,[SportType]
		,[BetType]
		,[IsLive]
		,[SuperPT]
		,[MasterPT]
		,[AgentPT]
		,[IsAutoMasterPT]
		,[AutoMasterPT]
		,[IsAutoSuperPT]
		,[AutoSuperPT]
		,[MinPT]
		,[MaxPT])
SELECT 
	cs.custid, dest.tSportType, dest.tBetType, dest.IsLive
	,cs.spositiontaking  *100
	,cs.mpositiontaking  *100
	,cs.apositiontaking  *100
	,cs.isautompositiontaking
	,cs.autompositiontaking *100
	,cs.isautopositiontaking 
	,cs.autopositiontaking  *100
	,CASE WHEN ci.Type = 0 THEN 0 ELSE co.minpositiontaking  *100 END
	,@MaxPT
FROM dbo.custSetting cs WITH(NOLOCK) 
	INNER JOIN dbo.CustOverride co WITH(NOLOCK) ON cs.custid = co.custid and cs.sporttype = co.sporttype and cs.bettype = co.bettype
	INNER JOIN #SMATemp ci ON ci.custid = cs.custid
	CROSS APPLY #DestinationSportBetType dest
WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType
	AND dest.SettingType = 1
	
--MEMBER LEVEL
INSERT INTO dbo.CustPTSetting3rd_Member
	(	[custid]
		,	[sporttype]
		,	[bettype]
		,	[islive]
		,	[superPT]
		,	[masterPT]
		,	[agentPT]
		,	[IsAutoMasterPT]
		,	[AutoMasterPT]
		,	[IsAutoSuperPT]
		,	[AutoSuperPT])
SELECT 
	cs.custid, dest.tSportType, dest.tBetType, dest.IsLive
	,cs.spositiontaking  *100
	,cs.mpositiontaking  *100
	,cs.apositiontaking  *100
	,cs.isautompositiontaking
	,cs.autompositiontaking *100
	,cs.isautopositiontaking 
	,cs.autopositiontaking  *100
FROM dbo.custSetting cs WITH(NOLOCK)
	INNER JOIN #MemberTemp ci ON cs.CustID = ci.custid
	CROSS APPLY #DestinationSportBetType dest
WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType
	AND dest.SettingType = 1
	
--------------------------------------Bet Setting-------------------------------------------------		
--Agent Level
INSERT INTO dbo.CustBetSetting3rd_Agent(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
SELECT ci.custid, dest.tsporttype, dest.tbettype, 
		CASE WHEN ci.roleid = 4 THEN ps.DefaultMinBet ELSE 0 END, 
		CASE WHEN ci.roleid = 4 THEN ps.DefaultMaxBet ELSE 0.1 END, 
		CASE WHEN ci.roleid = 4 THEN ps.DefaultMaxPerMatch ELSE 0.1 END			
FROM #SMATemp ci  
	CROSS APPLY #DestinationSportBetType dest
	INNER JOIN dbo.ProductBetSetting ps WITH (NOLOCK) ON dest.tSportType = ps.Sporttype AND dest.tBetType = ps.Bettype AND ps.Currency = ci.currency
WHERE dest.SettingType = 16

--Member Level
INSERT INTO dbo.CustBetSetting3rd_Member(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
SELECT ci.custid, dest.tsporttype, dest.tbettype, 0, 0.1, 0.1				
FROM #MemberTemp ci
	CROSS APPLY #DestinationSportBetType dest
WHERE dest.SettingType = 16
	
--------------------------------------Commission Setting-------------------------------------------------		
SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType 
FROM #DestinationSportBetType		
WHERE SettingType = 3

--Agent Level
INSERT INTO dbo.CustDiscount3rd_Agent(CustID, SportType, BetType, Discount)
SELECT ci.custid, dest.tsporttype, dest.tbettype, 
		CASE	WHEN roleid = 4 THEN cs.sdiscount
				WHEN roleid = 3 THEN cs.adiscount
				WHEN roleid = 2 THEN cs.discount END
FROM dbo.custSetting cs WITH(NOLOCK)
	INNER JOIN #SMATemp ci  ON cs.CustID = ci.custid
	CROSS APPLY #DestinationSportBetType dest
WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType
	AND dest.SettingType = 3
		 
--Member Level
INSERT INTO dbo.CustDiscount3rd_Member(CustID, SportType, BetType, PlayerDiscount, AgentDiscount, MasterDiscount, SuperDiscount)
SELECT ci.custid, dest.tsporttype, dest.tbettype, cs.playerdiscount, cs.discount, cs.adiscount, cs.sdiscount
FROM dbo.custSetting cs WITH(NOLOCK)
	INNER JOIN #MemberTemp ci WITH(NOLOCK) ON cs.CustID = ci.custid
	CROSS APPLY #DestinationSportBetType dest
WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType
	AND dest.SettingType = 3

--------------------------------------Win Loss Limit-------------------------------------------------		
--Agent Level
INSERT INTO dbo.CustWinLossLimit_Agent (CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
SELECT ci.custid, dest.tsporttype, dest.tbettype, 0, cs.DefaultLossLimit, 1
FROM #SMATemp ci WITH(NOLOCK) 
	INNER JOIN dbo.LossLimit_GlobalSetting cs WITH(NOLOCK) ON ci.currency = cs.ExchangeId
	CROSS APPLY #DestinationSportBetType dest WITH(NOLOCK) 	
WHERE dest.SettingType = 6 AND cs.ProductId = @ProductID

--Member Level
INSERT INTO dbo.CustWinLossLimit_Member (CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
SELECT ci.custid, dest.tsporttype, dest.tbettype, 0, cs.DefaultLossLimit, 1
FROM #MemberTemp ci WITH(NOLOCK) 
	INNER JOIN dbo.LossLimit_GlobalSetting cs WITH(NOLOCK) ON ci.currency = cs.ExchangeId
	CROSS APPLY #DestinationSportBetType dest WITH(NOLOCK) 
WHERE dest.SettingType = 6 AND cs.ProductId = @ProductID

/*******************************CUST PRODUCT STATUS TABLE*******************************/	
DECLARE @BitmapOrder TINYINT = 12
	
--Member level
UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
	bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,1))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #MemberTemp ci WITH(NOLOCK) ON cs.CustID = ci.CustID

DROP TABLE #SMATemp
DROP TABLE #MemberTemp
DROP TABLE #DestinationSportBetType		

PRINT N'Step 9: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 