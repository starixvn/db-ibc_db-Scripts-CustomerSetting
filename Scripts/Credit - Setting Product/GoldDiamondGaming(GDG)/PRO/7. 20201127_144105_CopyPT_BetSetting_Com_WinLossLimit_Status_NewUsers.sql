/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20201127@Tina
	Task: Copy Setting for newly created customer for Gold Diamond Gaming (GDG) [Redmine: #144105]
	DB: DBCUST/CustDB
*/ 
PRINT N'Step 7: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
DECLARE @ProductID TINYINT = 41, @Sporttype INT = 236, @Bettype INT  = 5701
DECLARE @SettingType_PT INT = 18 , @SettingType_Comm INT = 19, @SettingType_WinLoss INT = 6
DECLARE @MaxCustID INT, @fSportType SMALLINT, @fBetType SMALLINT

SELECT @MaxCustID = xxx

CREATE TABLE #supers (custid int)

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
			AND ci.username NOT LIKE '3rdSuper%'
			AND cs.isinternal = 0
			AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
			AND ci.Site<>'CN88'
			AND s.islicensee = 0
			AND ci.currency IN (13,	--CNY(RMB)
								15,	--IDR(IN)
								22,	--IDR(IND)
								33,	--IDR(IDD)
								34,	--IDR(IDR)
								47,	--IDR(DDD)
								43,	--THB(THB)
								3,	--USD(US$)
								16,	--USD(Yen)
								35,	--USD($US)
								64,	--USD(UT)
								95,	--USD(USD)
								2,	--MYR(RM)
								5,	--HKD(HK$)
								67,	--HKD(HKK)
								69	--MMK(MMK)
					) --supported currencies

CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT, IsFinished BIT)
INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
SELECT	243, 3101, SportType, BetType, 0, SettingType, 0 --copy from AE Casino
FROM ProductSettingDetail WITH (NOLOCK)
WHERE ProductID = @ProductID AND SportType = @Sporttype AND SettingType IN (@SettingType_PT,@SettingType_Comm,@SettingType_WinLoss) --  PT, Comm, WinLoss 


CREATE TABLE #tmpSTListSMA (BettypeID INT, Currency INT, StakeLevelList VARCHAR(500))

CREATE TABLE #MemberTemp
(
	CustID INT PRIMARY KEY CLUSTERED,
	currency INT
)

CREATE TABLE #MemberTempBatch
(
	CustID	INT PRIMARY KEY CLUSTERED,
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
WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 1  AND Enabled = 1 AND custid > @maxcustid	
	
INSERT INTO #SMATemp (CustID, roleid, currency)
SELECT custid, roleid, currency
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @maxcustid 

INSERT INTO #tmpSTListSMA(BettypeID, StakelevelList,Currency)
SELECT DISTINCT ST.GameTypeID, CAST (STUFF (STL, 1,1, '')AS VARCHAR(500)) as StakeLevelList,sma.currency
FROM #SMATemp SMA CROSS JOIN StakeLevel ST
CROSS APPLY (SELECT ',' + CAST(StakeLevelID AS VARCHAR(10))
		FROM StakeLevel S WITH (NOLOCK)
		WHERE S.GameTypeID =ST.GameTypeID AND S.ExchangeId= sma.currency
		FOR XML PATH ('') ) AS A(STL)
WHERE ST.GameTypeID = @Bettype
ORDER BY ST.GameTypeID

--------------------------------------PT Setting-------------------------------------------------	
SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType 
FROM #DestinationSportBetType		
WHERE SettingType = @SettingType_PT

--Agent Level
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
	C.custid, dest.tSportType, dest.tBetType
	,C.IsLive
	,C.SuperPT
	,C.MasterPT
	,C.AgentPT
	,C.IsAutoMasterPT
	,C.AutoMasterPT
	,C.IsAutoSuperPT
	,C.AutoSuperPT
	,C.MinPT
	,C.MaxPT
FROM dbo.CustPTSetting3rd_Agent C WITH(NOLOCK) 
	INNER JOIN #SMATemp ci ON ci.custid = C.custid
	CROSS APPLY #DestinationSportBetType dest
WHERE C.bettype = @fBetType AND C.SportType = @fSportType
	AND dest.SettingType = @SettingType_PT

--Member Level
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
	C.custid, dest.tSportType, dest.tBetType
	,C.IsLive
	,C.SuperPT
	,C.MasterPT
	,C.AgentPT
	,C.IsAutoMasterPT
	,C.AutoMasterPT
	,C.IsAutoSuperPT
	,C.AutoSuperPT
FROM CustPTSetting3rd_Member C WITH(NOLOCK) 
	INNER JOIN #MemberTemp ci ON C.CustID = ci.custid
	CROSS APPLY #DestinationSportBetType dest
WHERE C.bettype = @fBetType AND C.sporttype = @fSportType
	AND dest.SettingType = @SettingType_PT

--Group PT 
INSERT INTO dbo.CustPTGroupSetting3rd_Member
	(	[AgentID]
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
	)
SELECT 
	C.AgentID, dest.tSportType, dest.tBetType
	,C.IsLive
	,C.SuperPT
	,C.MasterPT
	,C.AgentPT
	,C.IsAutoMasterPT
	,C.AutoMasterPT
	,C.IsAutoSuperPT
	,C.AutoSuperPT
FROM dbo.CustPTGroupSetting3rd_Member C WITH(NOLOCK) 
	INNER JOIN #SMATemp ci ON ci.custid = C.AgentID
	CROSS APPLY #DestinationSportBetType dest
WHERE C.bettype = @fBetType AND C.SportType = @fSportType
	AND dest.SettingType = @SettingType_PT

--------------------------------------Commission Setting-------------------------------------------------
SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType 
FROM #DestinationSportBetType		
WHERE SettingType = @SettingType_Comm

--Super level
INSERT INTO dbo.CustDiscount3rd_Agent(CustID, SportType, BetType, Discount)
SELECT ci.custid, dest.tsporttype, dest.tbettype, C.Discount
FROM dbo.CustDiscount3rd_Agent C WITH(NOLOCK)
	INNER JOIN #SMATemp ci  ON C.CustID = ci.custid
	CROSS APPLY #DestinationSportBetType dest
WHERE C.bettype = @fBetType AND C.SportType = @fSportType
	AND dest.SettingType = @SettingType_Comm
	
--Member Level
INSERT INTO dbo.CustDiscount3rd_Member(CustID, SportType, BetType, PlayerDiscount, AgentDiscount, MasterDiscount, SuperDiscount)
SELECT DISTINCT ci.custid, dest.tsporttype, dest.tbettype, C.PlayerDiscount, C.AgentDiscount, C.MasterDiscount, C.SuperDiscount
FROM dbo.CustDiscount3rd_Member C WITH(NOLOCK) 
	INNER JOIN #MemberTemp ci WITH(NOLOCK) ON C.CustID = ci.custid
	CROSS APPLY #DestinationSportBetType dest
WHERE C.bettype = @fBetType AND C.SportType = @fSportType
	AND dest.SettingType = @SettingType_Comm
--------------------------------------Win Loss Limit-------------------------------------------------
SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType 
FROM #DestinationSportBetType		
WHERE SettingType = @SettingType_WinLoss
	
--Agent Level
INSERT INTO dbo.CustWinLossLimit_Agent (CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
SELECT ci.custid, dest.tsporttype, dest.tbettype, MaxWinLimit, MaxLossLimit, IsAutoReset
FROM CustWinLossLimit_Agent C WITH (NOLOCK) INNER JOIN #SMATemp ci WITH (NOLOCK) ON C.CustId = CI.CustID
	CROSS APPLY #DestinationSportBetType dest WITH(NOLOCK) 
WHERE dest.SettingType = @SettingType_WinLoss AND C.bettype = @fBetType AND C.SportType = @fSportType

--Member Level
INSERT INTO dbo.CustWinLossLimit_Member (CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
SELECT ci.custid, dest.tsporttype, dest.tbettype, MaxWinLimit, MaxLossLimit, IsAutoReset
FROM dbo.CustWinLossLimit_Member C WITH (NOLOCK) INNER JOIN #MemberTemp ci WITH(NOLOCK) ON C.CustId = CI.CustID
	CROSS APPLY #DestinationSportBetType dest WITH(NOLOCK) 
WHERE dest.SettingType = @SettingType_WinLoss AND C.bettype = @fBetType AND C.SportType = @fSportType

--------------------------------------BetSetting-------------------------------------------------
-->Agent level
INSERT INTO dbo.CustStakeLevel_Agent  ([CustID]
									,[SportType]
									,[BetType]
									,[StakeLevelList]) 
SELECT DISTINCT t.custid,@Sporttype, TB.BettypeID, TB.StakeLevelList
FROM StakeLevel S WITH(NOLOCK) INNER JOIN #tmpSTListSMA TB WITH (NOLOCK) ON S.GameTypeID = TB.BettypeID AND S.ExchangeId = TB.Currency
CROSS JOIN  #SMATemp t
WHERE ExchangeId=t.currency

--Member Level

WHILE EXISTS(SELECT 1 FROM #MemberTemp)
BEGIN
	DELETE TOP (3000) #MemberTemp OUTPUT DELETED.* INTO #MemberTempBatch

	IF @@ROWCOUNT=0
		BREAK		

	INSERT INTO dbo.CustStakeLevel_Member([CustID]
										,[SportType]
										,[BetType]
										,[StakeLevelList]
										,LastUpdated) 
	SELECT DISTINCT t.custid,@Sporttype, @Bettype BettypeID, CAST(StakeLevelID AS varchar(50)),GETDATE()
	FROM (SELECT StakeLevelID,GameTypeID,ExchangeId,ROW_NUMBER() OVER(PARTITION BY ExchangeId ORDER BY MaxStake ASC) AS STT 
			FROM StakeLevel WITH(NOLOCK)
			WHERE GameTypeID = @Bettype) S 
		  INNER JOIN  #MemberTempBatch t WITH (NOLOCK) ON S.ExchangeId = T.Currency
	WHERE S.ExchangeId=t.currency AND S.STT = 1


	TRUNCATE TABLE #MemberTempBatch
END

/*******************************CUST PRODUCTSTATUS TABLE*******************************/
DECLARE @BitmapOrder TINYINT = 31

SELECT custid, ci.roleid, ci.srecommend
INTO #CustList
FROM dbo.custInfo ci WITH (NOLOCK)
WHERE ci.srecommend IN (SELECT custid FROM #supers) AND custid > @MaxCustID AND Enabled = 1

UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
		bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,isDisabled.value)) 	
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #CustList ci WITH(NOLOCK) ON cs.CustID = ci.CustID
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, 22) as isDisabled --copy from AE Casino (22)

DROP TABLE #SMATemp
DROP TABLE #MemberTemp
DROP TABLE #DestinationSportBetType	
DROP TABLE #tmpSTListSMA
DROP TABLE #supers
DROP TABLE #CustList

PRINT N'Step 7: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
