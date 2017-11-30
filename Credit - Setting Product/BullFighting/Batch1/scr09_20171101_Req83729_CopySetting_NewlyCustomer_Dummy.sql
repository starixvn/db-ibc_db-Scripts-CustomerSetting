/*
	Created: Elodie
	Task: Copy Setting for newly created customer
	DB: DBCUST/CustDB
	Date: 20171101
*/ 
PRINT N'Step 9: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

DECLARE @MaxCustID INT, @fSportType SMALLINT, @fBetType SMALLINT
	
SELECT @MaxCustID = xxx
	
CREATE TABLE #OfferedSite (site VARCHAR(10))
INSERT INTO #OfferedSite (site)
VALUES  ('Indo'), ('KORIBC')

CREATE TABLE #DummySupers (custid int)

INSERT INTO #DummySupers(custid)
SELECT ci.custid
FROM dbo.Customer ci WITH(NOLOCK)
WHERE ci.custid IN (15) -- dummy account
				          
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
CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT, IsFinished BIT)
INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
SELECT	1, 5, SportType, BetType, 0, SettingType, 0
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
SELECT ci.custid, dest.tsporttype, dest.tbettype, 0, 0.1, 0.1	
FROM #SMATemp ci  
	CROSS APPLY #DestinationSportBetType dest
WHERE dest.SettingType = 16

--Member Level
INSERT INTO dbo.CustBetSetting3rd_Member(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
SELECT ci.custid, dest.tsporttype, dest.tbettype, 0, 0.1, 0.1				
FROM #MemberTemp ci
	CROSS APPLY #DestinationSportBetType dest
WHERE dest.SettingType = 16
	
-----Set global bet setting for dummy acounts,  direct Master, direct Agent and direct member level-----
--Update for dummy master of direct agent
UPDATE cs
SET cs.MinBet = ps.DefaultMinBet,
	cs.MaxBet = ps.DefaultMaxBet,
	cs.MaxPerMatch = ps.DefaultMaxPerMatch	
FROM #DirectAgent ci  	 
	INNER JOIN dbo.CustBetSetting3rd_Agent cs WITH (NOLOCK) ON cs.CustID = ci.mrecommend	
	INNER JOIN #DestinationSportBetType dest ON dest.tSportType = cs.Sporttype AND dest.tBetType = cs.Bettype
	INNER JOIN dbo.ProductBetSetting ps WITH (NOLOCK) ON dest.tSportType = ps.Sporttype AND dest.tBetType = ps.Bettype
	INNER JOIN #SMATemp c ON cs.CustID = c.CustID AND c.currency = ps.Currency
WHERE dest.SettingType = 16

--Update for dummy master of direct member
UPDATE cs
SET cs.MinBet = ps.DefaultMinBet,
	cs.MaxBet = ps.DefaultMaxBet,
	cs.MaxPerMatch = ps.DefaultMaxPerMatch	
FROM #DirectMember ci  
	INNER JOIN dbo.CustBetSetting3rd_Agent cs WITH (NOLOCK) ON cs.CustID = ci.mrecommend
	INNER JOIN #DestinationSportBetType dest ON dest.tSportType = cs.Sporttype AND dest.tBetType = cs.Bettype
	INNER JOIN dbo.ProductBetSetting ps WITH (NOLOCK) ON dest.tSportType = ps.Sporttype AND dest.tBetType = ps.Bettype
	INNER JOIN #SMATemp c ON cs.CustID = c.CustID AND c.currency = ps.Currency
WHERE dest.SettingType = 16

--Update for dummy agent
UPDATE cs
SET cs.MinBet = ps.DefaultMinBet,
	cs.MaxBet = ps.DefaultMaxBet,
	cs.MaxPerMatch = ps.DefaultMaxPerMatch	
FROM #DirectMember ci  		
	INNER JOIN dbo.CustBetSetting3rd_Agent cs WITH (NOLOCK) ON cs.CustID = ci.recommend
	INNER JOIN #DestinationSportBetType dest ON dest.tSportType = cs.Sporttype AND dest.tBetType = cs.Bettype
	INNER JOIN dbo.ProductBetSetting ps WITH (NOLOCK) ON dest.tSportType = ps.Sporttype AND dest.tBetType = ps.Bettype
	INNER JOIN #SMATemp c ON cs.CustID = c.CustID AND c.currency = ps.Currency
WHERE dest.SettingType = 16

--Update for direct master, agent
UPDATE cs
SET cs.MinBet = ps.DefaultMinBet,
	cs.MaxBet = ps.DefaultMaxBet,
	cs.MaxPerMatch = ps.DefaultMaxPerMatch	
FROM (SELECT custid FROM #DirectMaster UNION ALL SELECT custid FROM #DirectAgent) ci  
	INNER JOIN dbo.CustBetSetting3rd_Agent cs WITH (NOLOCK) ON cs.CustID = ci.CustID
	INNER JOIN #DestinationSportBetType dest ON dest.tSportType = cs.Sporttype AND dest.tBetType = cs.Bettype
	INNER JOIN dbo.ProductBetSetting ps WITH (NOLOCK) ON dest.tSportType = ps.Sporttype AND dest.tBetType = ps.Bettype
	INNER JOIN #SMATemp c ON cs.CustID = c.CustID AND c.currency = ps.Currency
WHERE dest.SettingType = 16

--Update for direct member
UPDATE cs
SET cs.MinBet = ps.DefaultMinBet,
	cs.MaxBet = ps.DefaultMaxBet,
	cs.MaxPerMatch = ps.DefaultMaxPerMatch	
FROM #DirectMember ci  
	INNER JOIN dbo.CustBetSetting3rd_Member cs WITH (NOLOCK) ON cs.CustID = ci.CustID
	INNER JOIN #DestinationSportBetType dest ON dest.tSportType = cs.Sporttype AND dest.tBetType = cs.Bettype
	INNER JOIN dbo.ProductBetSetting ps WITH (NOLOCK) ON dest.tSportType = ps.Sporttype AND dest.tBetType = ps.Bettype
	INNER JOIN #MemberTemp c ON cs.CustID = c.CustID AND c.currency = ps.Currency
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

/*******************************CUST PRODUCTSTATUS TABLE*******************************/	
DECLARE @BitmapOrder TINYINT = 12

SELECT custid, roleid
INTO #DisableLine
FROM custInfo WITH (NOLOCK) 
WHERE username IN (	'MMMRM','SBKHK','SBKRMB','SBKTB','MMPRM','SMM','SBKH','SBKT','SMH','SMMH','SMAH','SMAT','SMBT','SMBH','SMCH','SMK','M7RM','M7ARM','M7RMB','M7ARMB','M7BRMB',
					'M7BRM','S7RMB','M7ZRMB','M7CRM','HK7','MQRM','MQARM','MQRMB','MQR','SQHH','SDRM','SDRMB','SDH','SDHA','S188R','S188RM','S188AR','S188BH','S188HK','S188HL',
					'SV','S188M','M63H','M63IRMB','M63IHK','S63H','S63K','S63M','S70RMB','S70M','MK1','MK2','MK3','MK5','MK6','MK4C','TH7','MK8','MK9','MK10','MK11C','CKT',
					'CKT1','CKT2','MKM','MK12','TH88','MK17','CK18','MKTB','MK13','MKM1','MK19','MK20','MK21','MK16','MK15','TH25','MK22','TH26','MK23','JC2','JC8','MKI',
					'JC9','MK27','THM','JCM','JC10','TH89','MK31','MKM2','JC5','GAX','MK32','JC83','AK1','AKM1','MK33','MK35','MK36','TH3','M85TB','M85ATB','M85BTB','M85CTB',
					'M85DTB','S85BR','S85H','S85T','S85GTH','KJH','KJHB','KJM','KJI','KJD','KJT','KJMB','KJE','KJB','KJC','KJF','KJMC','KJMA','KJG','KJMD','KJL','KJO','KJME',
					'KJMF','KJMG','KJA','SZ','SBMW','YKM','CYKM','M822M','S822R','GEH','GFH','S822M','S822MA','GFJ','S822D','PPH','PPM','S27RMB','S27A','SADA','S9M','S9H',
					'XKS','POB','POM','POH','POJ','VAG','PYM','PYC','AC1','AC2','ACK','AC3','AC4','AC7','AC8','AC9','AC11','AC12','AC14','ACK2','AC15','AC16','AC17','AC18',
					'AC19','PPS','PPJ','PPN','PPQ','PPZ','PPP','PPA','PPT','PPU','TD1','TD2','TD3','TD4','TD5','TD6','YT1','TDA','TDB','YT2','TDC','TDD','YT3','DS1','DS2',
					'DS3','DS5','DS6','DS7','DS8','DS9','DS10','DS11','DS12','DS13','DS15','DS16','DS17','DS18','DS19','DS20','DS27','DS21','KDS','DS22','DS23','DS25','RC')

	AND roleid <> 4

UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #SMATemp ci WITH(NOLOCK) ON cs.CustID = ci.CustID

UPDATE cs
SET bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,0))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #SMATemp ci WITH(NOLOCK) ON cs.CustID = ci.CustID
	INNER JOIN dbo.custInfo c WITH(NOLOCK) ON cs.CustID = c.CustID
WHERE NOT EXISTS (SELECT 1 FROM #DisableLine WHERE custid = c.mrecommend)	

UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),	
	--Should update disabled = 1 for newly member
	cs.bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,1)) 
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #MemberTemp ci WITH(NOLOCK) ON cs.CustID = ci.CustID

DROP TABLE #SMATemp
DROP TABLE #MemberTemp
DROP TABLE #DestinationSportBetType		

PRINT N'Step 9: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 