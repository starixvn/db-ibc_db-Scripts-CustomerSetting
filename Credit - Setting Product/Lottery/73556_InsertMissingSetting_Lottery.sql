/*
	Created: Elodie
	Task: Copy PT & Bet Setting & WinLossLimit of Lottery for accounts miss data
	DB: DBCUST/CustDB
	Date: 20180803
*/ 
USE CustDB
GO

CREATE TABLE #MissCust (CustId INT)
INSERT INTO #MissCust (CustId) 
SELECT 11237
UNION ALL SELECT 25196408
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

DECLARE @ProductID TINYINT = 28
CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT, IsFinished BIT)
INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
SELECT	202, 1501, SportType, BetType, 0, SettingType, 0
FROM dbo.ProductSettingDetail WITH (NOLOCK)
WHERE ProductID = @ProductID AND SettingType IN (1,6)

--get Bet Setting of Keno - Max Keno (bet type id  = 1515)  to apply for all game types of Lottery (Max5D, Max3D, Max11x5, MaxDice)
--Use GameTypeID = 15 in CustGameType table
INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
SELECT	202, 15, SportType, BetType, 0, SettingType, 0 
FROM dbo.ProductSettingDetail WITH (NOLOCK)
WHERE ProductID = @ProductID AND SettingType IN (2)

CREATE TABLE #MemberTemp
(
	CustID INT PRIMARY KEY CLUSTERED,
	currency INT
)

CREATE TABLE #SMATemp
(
	CustID INT PRIMARY KEY CLUSTERED,
	roleid TINYINT,
	currency INT
)
	
INSERT INTO #MemberTemp (CustID, currency)
SELECT custid, currency
FROM Custinfo WITH (NOLOCK)
WHERE roleid = 1  AND Enabled = 1 AND custid IN (SELECT custid FROM #MissCust)
	
INSERT INTO #SMATemp (CustID, roleid, currency)
SELECT custid, roleid, currency
FROM Custinfo WITH (NOLOCK)
WHERE roleid IN (2,3,4) AND Enabled = 1 AND custid IN (SELECT custid FROM #MissCust)

DECLARE @MaxPT TINYINT
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
	,co.minpositiontaking  *100
	,@MaxPT
FROM dbo.custSettingGame cs WITH(NOLOCK) 
	INNER JOIN dbo.CustOverrideGame co WITH(NOLOCK) ON cs.custid = co.custid and cs.sporttype = co.sporttype and cs.bettype = co.bettype
	INNER JOIN #SMATemp ci WITH(NOLOCK) ON ci.custid = cs.custid
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
FROM dbo.custSettingGame cs WITH(NOLOCK)
	INNER JOIN #MemberTemp ci WITH(NOLOCK) ON cs.CustID = ci.custid
	CROSS APPLY #DestinationSportBetType dest
WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType
	AND dest.SettingType = 1

--------------------------------------Bet Setting-------------------------------------------------		
SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType 
FROM #DestinationSportBetType		
WHERE SettingType = 2

--Agent Level
INSERT INTO dbo.CustBetSetting3rd_Agent(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
SELECT ci.custid, dest.tsporttype, dest.tbettype, cs.minbet, cs.maxbet, cs.MaxPerGameType			
FROM dbo.CustGameType cs WITH(NOLOCK)
	INNER JOIN #SMATemp ci WITH(NOLOCK) ON cs.CustID = ci.custid
	CROSS APPLY #DestinationSportBetType dest
WHERE cs.GameTypeID = @fBetType
	AND dest.SettingType = 2

--Member Level
INSERT INTO dbo.CustBetSetting3rd_Member(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
SELECT ci.custid, dest.tsporttype, dest.tbettype, cs.minbet, cs.maxbet, cs.MaxPerGameType					
FROM dbo.CustGameType cs WITH(NOLOCK)
	INNER JOIN #MemberTemp ci WITH(NOLOCK) ON cs.CustID = ci.custid
	CROSS APPLY #DestinationSportBetType dest
WHERE cs.GameTypeID = @fBetType
	AND dest.SettingType = 2
	AND cs.CustID <> 29472088
	
--------------------------------------Win Loss Limit-------------------------------------------------		
--Agent Level
INSERT INTO dbo.CustWinLossLimit_Agent (CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
SELECT ci.custid, dest.tsporttype, dest.tbettype, 0, cs.DefaultLossLimit, 1
FROM #SMATemp ci WITH(NOLOCK) 
	CROSS APPLY #DestinationSportBetType dest WITH(NOLOCK) 
	CROSS APPLY dbo.LossLimit_GlobalSetting cs WITH(NOLOCK)
WHERE dest.SettingType = 6 AND cs.ExchangeId = ci.currency AND cs.ProductId = @ProductID

--Member Level
INSERT INTO dbo.CustWinLossLimit_Member (CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
SELECT ci.custid, dest.tsporttype, dest.tbettype, 0, cs.DefaultLossLimit, 1
FROM #MemberTemp ci WITH(NOLOCK) 
	CROSS APPLY #DestinationSportBetType dest WITH(NOLOCK) 
	CROSS APPLY dbo.LossLimit_GlobalSetting cs WITH(NOLOCK)
WHERE dest.SettingType = 6 AND cs.ExchangeId = ci.currency AND cs.ProductId = @ProductID

DROP TABLE #SMATemp
DROP TABLE #MemberTemp
DROP TABLE #DestinationSportBetType			
