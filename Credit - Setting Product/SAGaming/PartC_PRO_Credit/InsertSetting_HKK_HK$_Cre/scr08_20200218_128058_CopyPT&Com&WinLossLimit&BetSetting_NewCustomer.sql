/*
	Created: 20200623@Eden
	Task: Copy Setting for newly created customer - HK$,HKK [Redmine: #128128]
	DB: DBCUST/CustDB
*/ 
PRINT N'Step 7: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
DECLARE @ProductID TINYINT = 41, @Sporttype INT = 244
DECLARE @MaxCustID INT, @fSportType SMALLINT, @fBetType SMALLINT
DECLARE @MaxPT TINYINT

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
			AND s.islicensee = 0
			AND ci.Site<>'CN88'
			AND ci.currency IN (5,67)

CREATE TABLE #TmpProductSettingDetail
	(
		SettingType SMALLINT,
		SportType SMALLINT,
		BetType SMALLINT,
		IsLive BIT,
		ProductID TINYINT,
		MaxPT TINYINT,
		MaxDiscount DECIMAL (9, 8),
		IsSync BIT,
		IsHidden BIT,
		IsDisabled BIT,
		SettingLevel TINYINT,
		DisplayOrder TINYINT,
		SettingStatus TINYINT,
		IntervalValue DECIMAL (19, 8) 
	)
	
	INSERT INTO #TmpProductSettingDetail ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(1,211,2401,0,41,93,NULL,NULL,NULL,NULL,2,3,0,NULL)
	INSERT INTO #TmpProductSettingDetail ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(3,211,2401,0,41,NULL,0.01,NULL,NULL,NULL,2,2,0,0.0005)
	INSERT INTO #TmpProductSettingDetail ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(6,211,2401,0,41,NULL,NULL,NULL,NULL,NULL,2,4,0,NULL)
	INSERT INTO #TmpProductSettingDetail ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(7,211,2401,0,41,NULL,NULL,NULL,NULL,NULL,2,5,0,NULL)
	INSERT INTO #TmpProductSettingDetail ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(13,211,2401,0,41,NULL,NULL,1,0,0,2,1,0,NULL)

	INSERT INTO #TmpProductSettingDetail ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(1,244,3001,0,41,93,NULL,NULL,NULL,NULL,2,3,0,NULL)
	INSERT INTO #TmpProductSettingDetail ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(3,244,3001,0,41,NULL,0.01,NULL,NULL,NULL,2,2,0,0.0005)
	INSERT INTO #TmpProductSettingDetail ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(6,244,3001,0,41,NULL,NULL,NULL,NULL,NULL,2,4,0,NULL)
	INSERT INTO #TmpProductSettingDetail ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(7,244,3001,0,41,NULL,NULL,NULL,NULL,NULL,2,5,0,NULL)
	INSERT INTO #TmpProductSettingDetail ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(13,244,3001,0,41,NULL,NULL,1,0,0,2,1,0,NULL)

SELECT TOP 1 @MaxPT = MaxPT FROM #TmpProductSettingDetail WITH (NOLOCK) WHERE ProductID = @ProductID AND SettingType = 1

CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT, IsFinished BIT)
INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
SELECT	211, 2401, SportType, BetType, 0, SettingType, 0
FROM #TmpProductSettingDetail WITH (NOLOCK)
WHERE ProductID = @ProductID AND SportType = @Sporttype AND SettingType IN (1,3,6) --PT, Comm, WinLossLimit

CREATE TABLE #tmpSTListSMA (BettypeID INT, Currency INT, StakeLevelList VARCHAR(500))
CREATE TABLE #tmpSTListMember(BettypeID INT, Currency INT, StakeLevelList VARCHAR(500))

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

INSERT INTO #tmpSTListSMA(BettypeID, Currency, StakeLevelList)
SELECT DISTINCT ST.GameTypeID,currency, CAST (STUFF (STL, 1,1, '')AS VARCHAR(500)) as StakeLevelList
FROM #SMATemp SMA INNER JOIN StakeLevel ST ON SMA.currency =ST.ExchangeId  
CROSS APPLY (SELECT ',' + CAST(StakeLevelID AS VARCHAR(10))
			FROM StakeLevel S WITH (NOLOCK)
			WHERE S.GameTypeID =ST.GameTypeID AND S.ExchangeId=SMA.currency
			FOR XML PATH ('') ) AS A(STL)
WHERE ST.GameTypeID = 3001
ORDER BY ST.GameTypeID

INSERT INTO #tmpSTListMember(BettypeID, Currency, StakeLevelList)
SELECT DISTINCT ST.GameTypeID,currency, CAST (STUFF (STL, 1,1, '')AS VARCHAR(500)) as StakeLevelList
FROM #MemberTemp M CROSS JOIN StakeLevel ST 
CROSS APPLY (SELECT ',' + CAST(StakeLevelID AS VARCHAR(10))
			FROM StakeLevel S WITH (NOLOCK)
			WHERE S.GameTypeID =ST.GameTypeID AND S.ExchangeId=M.currency
			FOR XML PATH ('') ) AS A(STL)
WHERE ST.GameTypeID = 3001 
ORDER BY ST.GameTypeID
--------------------------------------PT Setting-------------------------------------------------

SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType 
FROM #DestinationSportBetType		
WHERE SettingType = 1

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
		AND dest.SettingType = 1

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
		AND dest.SettingType = 1

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
		AND dest.SettingType = 1	
--------------------------------------Commission Setting-------------------------------------------------
SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType 
FROM #DestinationSportBetType		
WHERE SettingType = 3

--Agent Level
INSERT INTO dbo.CustDiscount3rd_Agent(CustID, SportType, BetType, Discount)
SELECT ci.custid, dest.tsporttype, dest.tbettype, 
			C.Discount
FROM dbo.CustDiscount3rd_Agent C WITH(NOLOCK)
		INNER JOIN #SMATemp ci  ON C.CustID = ci.custid
		CROSS APPLY #DestinationSportBetType dest
WHERE C.bettype = @fBetType AND C.sporttype = @fSportType
		AND dest.SettingType = 3
		 
--Member Level
INSERT INTO dbo.CustDiscount3rd_Member(CustID, SportType, BetType, PlayerDiscount, AgentDiscount, MasterDiscount, SuperDiscount)
SELECT ci.custid, dest.tsporttype, dest.tbettype, C.PlayerDiscount, C.AgentDiscount, C.MasterDiscount, C.SuperDiscount
FROM dbo.CustDiscount3rd_Member C WITH(NOLOCK)
		INNER JOIN #MemberTemp ci WITH(NOLOCK) ON C.CustID = ci.custid
		CROSS APPLY #DestinationSportBetType dest
WHERE C.bettype = @fBetType AND C.sporttype = @fSportType
		AND dest.SettingType = 3
--------------------------------------Win Loss Limit-------------------------------------------------
SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType 
FROM #DestinationSportBetType		
WHERE SettingType = 6
--Agent Level
INSERT INTO dbo.CustWinLossLimit_Agent (CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
SELECT ci.custid, dest.tsporttype, dest.tbettype, MaxWinLimit, MaxLossLimit, IsAutoReset
FROM CustWinLossLimit_Agent C WITH (NOLOCK) INNER JOIN #SMATemp ci WITH (NOLOCK) ON C.CustId = CI.CustID
		CROSS APPLY #DestinationSportBetType dest WITH(NOLOCK) 
WHERE dest.SettingType = 6 AND C.bettype = @fBetType AND C.SportType = @fSportType

--Member Level
INSERT INTO dbo.CustWinLossLimit_Member (CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
SELECT ci.custid, dest.tsporttype, dest.tbettype, MaxWinLimit, MaxLossLimit, IsAutoReset
FROM dbo.CustWinLossLimit_Member C WITH (NOLOCK) INNER JOIN #MemberTemp ci WITH(NOLOCK) ON C.CustId = CI.CustID
		CROSS APPLY #DestinationSportBetType dest WITH(NOLOCK) 
WHERE dest.SettingType = 6 AND C.bettype = @fBetType AND C.SportType = @fSportType
--------------------------------------BetSetting-------------------------------------------------
--Agent Level
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
		SELECT DISTINCT t.custid,@Sporttype,TB.BettypeID, CAST(MIN(StakeLevelID) AS varchar(50)),GETDATE()
		FROM StakeLevel S WITH(NOLOCK) INNER JOIN #tmpSTListMember TB WITH (NOLOCK) ON S.GameTypeID = TB.BettypeID AND S.ExchangeId = TB.Currency
										CROSS JOIN  #MemberTempBatch t
		WHERE S.ExchangeId=t.currency
		GROUP BY t.custid, TB.BettypeID

	TRUNCATE TABLE #MemberTempBatch
END
/*******************************CUST PRODUCTSTATUS TABLE*******************************/
DECLARE @BitmapOrder TINYINT = 20

SELECT custid, ci.roleid, ci.srecommend
INTO #CustList
FROM dbo.custInfo ci WITH (NOLOCK)
WHERE ci.srecommend IN (SELECT custid FROM #supers) AND custid > @MaxCustID AND Enabled = 1

UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
		bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,isDisabled.value)) 	
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #CustList ci WITH(NOLOCK) ON cs.CustID = ci.CustID
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, 6) as isDisabled

DROP TABLE #SMATemp
DROP TABLE #MemberTemp
DROP TABLE #DestinationSportBetType	
DROP TABLE #tmpSTListSMA
DROP TABLE #supers
DROP TABLE #CustList
DROP TABLE #TmpProductSettingDetail

PRINT N'Step 7: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
