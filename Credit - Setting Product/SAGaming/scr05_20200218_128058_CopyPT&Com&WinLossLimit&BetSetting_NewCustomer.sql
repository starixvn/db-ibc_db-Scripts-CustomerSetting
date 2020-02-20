/*
	Created: 20200218@Tiara
	Date: 20200218
	Task: Copy Setting for newly created customer  [Redmine: #128128]
	DB: DBCUST/CustDB
*/ 
PRINT N'Step 7: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
DECLARE @ProductID TINYINT = 41, @Sporttype INT = 244
DECLARE @MaxCustID INT, @fSportType SMALLINT, @fBetType SMALLINT
DECLARE @MaxPT TINYINT

SELECT TOP 1 @MaxPT = MaxPT FROM dbo.ProductSettingDetail WITH (NOLOCK) WHERE ProductID = @ProductID AND SettingType = 1
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
			AND ci.currency NOT IN (45,13) --Won (KRW) and RMB

CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT, IsFinished BIT)
INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
SELECT	211, 2401, SportType, BetType, 0, SettingType, 0
FROM dbo.ProductSettingDetail WITH (NOLOCK)
WHERE ProductID = @ProductID AND SettingType IN (1,3,6) --PT, Comm, WinLossLimit

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

INSERT INTO #tmpSTListSMA(BettypeID, Currency, StakeLevelList)
SELECT DISTINCT ST.GameTypeID,currency, CAST (STUFF (STL, 1,1, '')AS VARCHAR(500)) as StakeLevelList
FROM #SMATemp SMA INNER JOIN StakeLevel ST ON SMA.currency =ST.ExchangeId  
CROSS APPLY (SELECT ',' + CAST(StakeLevelID AS VARCHAR(10))
			FROM StakeLevel S WITH (NOLOCK)
			WHERE S.GameTypeID =ST.GameTypeID AND S.ExchangeId=SMA.currency
			FOR XML PATH ('') ) AS A(STL)
WHERE ST.GameTypeID BETWEEN 3001 AND 3007
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
		FROM StakeLevel S WITH(NOLOCK) INNER JOIN #tmpSTListSMA TB WITH (NOLOCK) ON S.GameTypeID = TB.BettypeID AND S.ExchangeId = TB.Currency
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
WHERE ci.srecommend IN (SELECT custid FROM #supers) AND custid > @MaxCustID

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

PRINT N'Step 7: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
