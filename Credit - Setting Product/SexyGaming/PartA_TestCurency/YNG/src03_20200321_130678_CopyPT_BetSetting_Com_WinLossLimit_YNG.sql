/*
	Created: 20200321@Tiara
	Date: 20200321
	Task: Copy PT & Comm & WinLossLimit for Sexy Gaming from Allbet - YNG [Redmine: #130678]
	DB: DBCUST/CustDB
	
*/ 

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@srecommend INT	
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('StakeLevel') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('ProductSettingDetail') = 0 RETURN
	
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
	INSERT INTO #TmpProductSettingDetail ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(1,211,2401,0,41,93,NULL,NULL,NULL,NULL,2,3,0,0.0005)
	INSERT INTO #TmpProductSettingDetail ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(3,211,2401,0,41,NULL,0.01,NULL,NULL,NULL,2,2,0,0.0005)
	INSERT INTO #TmpProductSettingDetail ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(6,211,2401,0,41,NULL,NULL,NULL,NULL,NULL,2,4,0,0.0005)
	INSERT INTO #TmpProductSettingDetail ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(7,211,2401,0,41,NULL,NULL,NULL,NULL,NULL,2,5,0,0.0005)
	INSERT INTO #TmpProductSettingDetail ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(13,211,2401,0,41,NULL,NULL,1,0,0,2,1,0,0.0005)

	INSERT INTO #TmpProductSettingDetail ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(1,243,3101,0,41,93,NULL,NULL,NULL,NULL,2,3,0,0.0005)
	INSERT INTO #TmpProductSettingDetail ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(3,243,3101,0,41,NULL,0.005,NULL,NULL,NULL,2,2,0,0.0005)
	INSERT INTO #TmpProductSettingDetail ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(6,243,3101,0,41,NULL,NULL,NULL,NULL,NULL,2,4,0,0.0005)
	INSERT INTO #TmpProductSettingDetail ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(7,243,3101,0,41,NULL,NULL,NULL,NULL,NULL,2,5,0,0.0005)
	INSERT INTO #TmpProductSettingDetail ([SettingType] ,[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue]) VALUES(13,243,3101,0,41,NULL,NULL,1,0,0,2,1,0,0.0005)

	DECLARE @ProductID TINYINT = 41, @Sporttype INT = 243
	DECLARE @fSportType SMALLINT, @fBetType SMALLINT
	DECLARE @MaxPT TINYINT, @Currency INT
	SELECT TOP 1 @MaxPT = MaxPT FROM #TmpProductSettingDetail WITH (NOLOCK) WHERE ProductID = @ProductID AND SettingType = 1
	SELECT @currency = ci.currency FROM dbo.custInfo ci WITH (NOLOCK) WHERE ci.custid = @srecommend

	CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT, IsFinished BIT)
	INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
	SELECT	211, 2401, SportType, BetType, 0, SettingType, 0
	FROM #TmpProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SportType = @Sporttype AND SettingType IN (1,3,6) --PT, Comm, WinLossLimit
	
	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
	)
	CREATE TABLE #MemberTempBatch
	(
		CustID	INT PRIMARY KEY CLUSTERED	
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		roleid TINYINT
	)

		CREATE TABLE #DirectTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		roleid TINYINT
	)


	CREATE TABLE #tmpSTListSMA (BettypeID INT PRIMARY KEY, StakeLevelList VARCHAR(500))


	INSERT INTO #MemberTemp (CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1  AND Enabled = 1 AND custid <= @maxcustid
	
	
	INSERT INTO #SMATemp (CustID, roleid)
	SELECT custid, roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND Enabled = 1 AND custid <= @maxcustid 

	
	INSERT INTO #DirectTemp (CustID,roleid) --Direct Master, Agent
	SELECT ci.custid, ci.roleid
	FROM Custinfo ci WITH (NOLOCK)
	WHERE  EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		AND ci.srecommend = @srecommend 
		AND ci.Enabled=1
		AND ci.roleid IN (2,3)
		AND ci.custid <= @maxcustid 


	INSERT INTO #tmpSTListSMA(BettypeID, StakelevelList)
	SELECT DISTINCT ST.GameTypeID, CAST (STUFF (STL, 1,1, '')AS VARCHAR(500)) as StakeLevelList
	FROM #SMATemp SMA CROSS JOIN StakeLevel ST
	CROSS APPLY (SELECT ',' + CAST(StakeLevelID AS VARCHAR(10))
			FROM StakeLevel S WITH (NOLOCK)
			WHERE S.GameTypeID =ST.GameTypeID AND S.ExchangeId=@Currency
			FOR XML PATH ('') ) AS A(STL)
	WHERE ST.GameTypeID BETWEEN 3101 AND 3105
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
	--Super level
	INSERT INTO dbo.CustDiscount3rd_Agent(CustID, SportType, BetType, Discount)
	SELECT DISTINCT ci.custid, dest.tsporttype, dest.tbettype, 
			0.005
	FROM dbo.CustDiscount3rd_Agent C WITH(NOLOCK)
		INNER JOIN #SMATemp ci  ON C.CustID = ci.custid
		CROSS APPLY #DestinationSportBetType dest
	WHERE dest.SettingType = 3
		AND ci.roleid = 4
	
	--Direct (Master, Agent)
	INSERT INTO dbo.CustDiscount3rd_Agent(CustID, SportType, BetType, Discount)
	SELECT DISTINCT ci.custid, dest.tsporttype, dest.tbettype, 
			0.005
	FROM dbo.CustDiscount3rd_Agent C WITH(NOLOCK)
		INNER JOIN #DirectTemp ci  ON C.CustID = ci.custid
		CROSS APPLY #DestinationSportBetType dest
	WHERE  dest.SettingType = 3
		AND CI.roleid IN (2,3)
	
	--Master, Agent level
	INSERT INTO dbo.CustDiscount3rd_Agent(CustID, SportType, BetType, Discount)
	SELECT DISTINCT ci.custid, dest.tsporttype, dest.tbettype, 
			0
	FROM dbo.CustDiscount3rd_Agent C WITH(NOLOCK)
		INNER JOIN #SMATemp ci  ON C.CustID = ci.custid
		CROSS APPLY #DestinationSportBetType dest
	WHERE dest.SettingType = 3
		AND ci.roleid IN (2,3)
		AND NOT EXISTS (SELECT 1 FROM #DirectTemp D WITH (NOLOCK) WHERE D.CustID = CI.CustID)
	--Member Level
	INSERT INTO dbo.CustDiscount3rd_Member(CustID, SportType, BetType, PlayerDiscount, AgentDiscount, MasterDiscount, SuperDiscount)
	SELECT DISTINCT ci.custid, dest.tsporttype, dest.tbettype, 0, 0 , 0, 0.005
	FROM dbo.CustDiscount3rd_Member C WITH(NOLOCK) 
		INNER JOIN #MemberTemp ci WITH(NOLOCK) ON C.CustID = ci.custid
		CROSS APPLY #DestinationSportBetType dest
	WHERE  dest.SettingType = 3
	--Update Discount info for members of direct master accounts
	UPDATE C
	SET  C.MasterDiscount = 0.005
	FROM dbo.CustDiscount3rd_Member C WITH(ROWLOCK, UPDLOCK)
		INNER JOIN custInfo CI WITH (NOLOCK) ON C.CustID = CI.custid
	WHERE EXISTS (SELECT 1 FROM #DirectTemp D WITH (NOLOCK) WHERE CI.mrecommend = D.CustID)

	--Update Discount info for members of direct agent accounts
	UPDATE C
	SET  C.AgentDiscount = 0.005, C.MasterDiscount = 0.005
	FROM dbo.CustDiscount3rd_Member C WITH(ROWLOCK, UPDLOCK)
		INNER JOIN custInfo CI WITH (NOLOCK) ON C.CustID = CI.custid
	WHERE EXISTS (SELECT 1 FROM #DirectTemp D WITH (NOLOCK) WHERE CI.recommend = D.CustID)

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
	FROM StakeLevel S WITH(NOLOCK) INNER JOIN #tmpSTListSMA TB WITH (NOLOCK) ON S.GameTypeID = TB.BettypeID
	CROSS JOIN  #SMATemp t
	WHERE ExchangeId=@currency

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
		FROM StakeLevel S WITH(NOLOCK) INNER JOIN #tmpSTListSMA TB WITH (NOLOCK) ON S.GameTypeID = TB.BettypeID
		CROSS JOIN  #MemberTempBatch t
		WHERE ExchangeId=@currency
		GROUP BY t.custid, TB.BettypeID

		TRUNCATE TABLE #MemberTempBatch
	END

	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
	DROP TABLE #tmpSTListSMA
	DROP TABLE #DestinationSportBetType	

END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

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
	AND ci.custid <= @max_custid
	AND ci.Site<>'CN88'
	AND ci.currency IN (72) --YNG
-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'REPLICATED'
			
			
	waitfor delay '00:00:0.200'
END
GO


-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 3: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

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
	AND ci.custid <= @max_custid
	AND ci.Site<>'CN88'
	AND ci.currency IN (72) --YNG

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'DBCUST'
						
	waitfor delay '00:00:0.200'
END

PRINT N'Step 3: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
