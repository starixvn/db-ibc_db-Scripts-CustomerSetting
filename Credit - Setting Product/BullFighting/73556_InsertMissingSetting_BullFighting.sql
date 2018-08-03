/*
	Created: Elodie
	Task: Copy PT & Bet Setting, Discount & WinLossLimit of BullFighting for accounts miss data
	DB: DBCUST/CustDB
	Date: 20180803
*/
CREATE TABLE #MissCust (CustId INT)
INSERT INTO #MissCust (CustId) 
SELECT 25196408
UNION ALL SELECT 25196451
UNION ALL SELECT 25196519
UNION ALL SELECT 25196533
UNION ALL SELECT 25323778
UNION ALL SELECT 25323806
UNION ALL SELECT 25323931
UNION ALL SELECT 25323959
UNION ALL SELECT 25324014
UNION ALL SELECT 25324037
UNION ALL SELECT 25324391
UNION ALL SELECT 25324405
UNION ALL SELECT 25324458
UNION ALL SELECT 25324472
UNION ALL SELECT 25324501
UNION ALL SELECT 25324524
UNION ALL SELECT 25324571
UNION ALL SELECT 25324581
UNION ALL SELECT 27471636
UNION ALL SELECT 29472088

DECLARE @fSportType SMALLINT, @fBetType SMALLINT

DECLARE @ProductID TINYINT = 30
CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT)
INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType)
SELECT	1, 5, SportType, BetType, 0, SettingType
FROM dbo.ProductSettingDetail WITH (NOLOCK)
WHERE ProductID = @ProductID AND SettingType IN (1,3,6,16)
	
CREATE TABLE #MemberTemp
(
	CustID INT PRIMARY KEY CLUSTERED,
)

CREATE TABLE #SMATemp
(
	CustID INT PRIMARY KEY CLUSTERED,
	roleid TINYINT
)
	
INSERT INTO #MemberTemp (CustID)
SELECT custid
FROM Custinfo WITH (NOLOCK)
WHERE roleid = 1  AND Enabled = 1 AND custid IN (SELECT custid FROM #MissCust)
	
	
INSERT INTO #SMATemp (CustID, roleid)
SELECT custid, roleid
FROM Custinfo WITH (NOLOCK)
WHERE roleid IN (2,3,4) AND Enabled = 1 AND custid IN (SELECT custid FROM #MissCust)

DECLARE @MaxPT TINYINT, @Currency INT--, @MaxComm DECIMAL(9,8)
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
	,CASE WHEN ci.roleid = 4 THEN 0 ELSE co.minpositiontaking  *100 END
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
	INNER JOIN dbo.ProductBetSetting ps WITH (NOLOCK) ON dest.tSportType = ps.Sporttype AND dest.tBetType = ps.Bettype
WHERE ps.Currency = @Currency AND dest.SettingType = 16

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
FROM #SMATemp ci  
	INNER JOIN dbo.custInfo c WITH (NOLOCK) ON c.custid = ci.CustID
	CROSS APPLY #DestinationSportBetType dest WITH(NOLOCK) 
	CROSS APPLY dbo.LossLimit_GlobalSetting cs WITH(NOLOCK)
WHERE dest.SettingType = 6 AND cs.ExchangeId = c.currency AND cs.ProductId = @ProductID

--Member Level
INSERT INTO dbo.CustWinLossLimit_Member (CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
SELECT ci.custid, dest.tsporttype, dest.tbettype, 0, cs.DefaultLossLimit, 1
FROM #MemberTemp ci WITH(NOLOCK) 
	INNER JOIN dbo.custInfo c WITH (NOLOCK) ON c.custid = ci.CustID
	CROSS APPLY #DestinationSportBetType dest WITH(NOLOCK) 
	CROSS APPLY dbo.LossLimit_GlobalSetting cs WITH(NOLOCK)
WHERE dest.SettingType = 6 AND cs.ExchangeId = c.currency AND cs.ProductId = @ProductID

DROP TABLE #SMATemp
DROP TABLE #MemberTemp
DROP TABLE #DestinationSportBetType			
