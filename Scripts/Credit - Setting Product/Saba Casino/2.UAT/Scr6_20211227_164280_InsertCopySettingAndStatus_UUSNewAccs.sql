/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211227@Eden
	Task: Insert Setting and update status for Saba Casino - UUS New Accs [#164280] -- run after release on PROD
	DB: DBCUST/CustDB
*/
USE CUSTDB
GO
BEGIN
	CREATE TABLE #supers (custid int,isfinished bit default(0))

	DECLARE @maxcustid INT = xxx

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM customer ci WITH (NOLOCK) 
		INNER JOIN custinfo c WITH(NOLOCK) ON ci.custid = c.custid
		INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
		LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.roleid = 4  
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND s.islicensee = 0
		and c.Enabled = 1			
		AND ci.Site <> 'CN88'
		AND ci.currency = 20

	DECLARE @ProductID      TINYINT      = 6, 
			@Sporttype      INT          = 208, 
			@Bettype        INT          = 2101, 
			@fSportType     SMALLINT, 
			@fBetType       SMALLINT, 
			@BatchNum		INT = 5000,
			@BitmapOrder	TINYINT = 37

	CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT, IsFinished BIT)
	INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
	SELECT	212, 4001, SportType, BetType, 0, SettingType, 0
	FROM ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SportType = @Sporttype AND bettype = @Bettype AND SettingType IN (18) --  PT
	
	INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
	SELECT	SportType, BetType, SportType, BetType, 0, SettingType, 0
	FROM ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SportType = @Sporttype AND bettype = @Bettype AND SettingType IN (8,6) -- StakeLevel, Win Loss Limit

	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		Currency INT,
		IsFinished BIT DEFAULT 0
	)

	CREATE TABLE #MemberTempBatch
	(
		CustID INT,
		Currency INT
	)

	CREATE TABLE #SMATemp(
		CustID INT PRIMARY KEY CLUSTERED,
		Currency INT,
		roleid TINYINT
	)

	INSERT INTO #MemberTemp (CustID, Currency)
	SELECT custid, currency
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN ( SELECT custid from #supers)
		AND roleid = 1  AND Enabled = 1 AND custid > @maxcustid
	
	INSERT INTO #SMATemp (CustID, roleid, currency)
	SELECT custid, roleid, currency
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN ( SELECT custid from #supers)
		AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @maxcustid 

	---------------------------------------delete redudant setting------------------------------------------------
	--PT
	DELETE cg
	FROM dbo.CustPTSetting3rd_Agent cg WITH(ROWLOCK)		
		INNER JOIN #SMATemp ci ON ci.custid = cg.CustID	
	WHERE SportType = @Sporttype AND BetType = @betType

	DELETE cg
	FROM dbo.CustPTSetting3rd_Member cg WITH(ROWLOCK)		
		INNER JOIN #MemberTemp ci ON ci.custid = cg.CustID	
	WHERE SportType = @Sporttype AND BetType = @betType

	DELETE cg
	FROM dbo.CustPTGroupSetting3rd_Member cg WITH(ROWLOCK)		
		INNER JOIN #SMATemp ci ON ci.custid = cg.AgentID AND ci.roleid = 2	
	WHERE SportType = @Sporttype AND BetType = @betType

	--Stake level
	DELETE cg
	FROM dbo.CustStakeLevel_Agent cg WITH(ROWLOCK)		
		INNER JOIN #SMATemp ci ON ci.custid = cg.CustID	
	WHERE SportType = @Sporttype AND BetType = @betType

	DELETE cg
	FROM dbo.CustStakeLevel_Member cg WITH(ROWLOCK)		
		INNER JOIN #MemberTemp ci ON ci.custid = cg.CustID	
	WHERE SportType = @Sporttype AND BetType = @betType

	--Winloss Limit
	DELETE cg
	FROM dbo.CustWinLossLimit_Agent cg WITH(ROWLOCK)		
		INNER JOIN #SMATemp ci ON ci.custid = cg.CustID	
	WHERE SportType = @Sporttype AND BetType = @betType

	DELETE cg
	FROM dbo.CustWinLossLimit_Member cg WITH(ROWLOCK)		
		INNER JOIN #MemberTemp ci ON ci.custid = cg.CustID	
	WHERE SportType = @Sporttype AND BetType = @betType

	--------------------------------------PT Setting -Copy from Macau Games-------------------------------------------------
	SELECT @fSportType = fSportType, @fBetType = fBetType FROM #DestinationSportBetType WHERE SettingType = 18

	--SMA Level
	INSERT INTO dbo.CustPTSetting3rd_Agent(	
		[CustID]
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
		,[MaxPT]
	)
	SELECT 
		C.custid
		,@SportType
		,@BetType
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
		INNER JOIN #SMATemp ci 
			ON ci.custid = C.custid
	WHERE c.SportType = @fSportType
		AND c.BetType = @fBetType

	--Member Level
	UPDATE #MemberTemp SET IsFinished = 0

	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #MemberTempBatch

		UPDATE TOP(@BatchNum) #MemberTemp 
		SET IsFinished = 1
		OUTPUT deleted.CustID INTO #MemberTempBatch(CustID)
		WHERE IsFinished = 0

		IF @@ROWCOUNT = 0
			BREAK;

		INSERT INTO dbo.CustPTSetting3rd_Member(		
			[custid]
			,[sporttype]
			,[bettype]
			,[islive]
			,[superPT]
			,[masterPT]
			,[agentPT]
			,[IsAutoMasterPT]
			,[AutoMasterPT]
			,[IsAutoSuperPT]
			,[AutoSuperPT]
		)
		SELECT 
			 C.custid
			,@SportType
			,@BetType
			,C.IsLive
			,C.SuperPT
			,C.MasterPT
			,C.AgentPT
			,C.IsAutoMasterPT
			,C.AutoMasterPT
			,C.IsAutoSuperPT
			,C.AutoSuperPT
		FROM dbo.CustPTSetting3rd_Member C WITH(NOLOCK) 
			INNER JOIN #MemberTempBatch ci 
				ON ci.custid = C.custid
		WHERE c.SportType = @fSporttype
			AND c.BetType= @fBetType
	END

	--Group PT 
	INSERT INTO dbo.CustPTGroupSetting3rd_Member(	
		[AgentID]
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
		 C.AgentID
		,@SportType
		,@BetType
		,C.IsLive
		,C.SuperPT
		,C.MasterPT
		,C.AgentPT
		,C.IsAutoMasterPT
		,C.AutoMasterPT
		,C.IsAutoSuperPT
		,C.AutoSuperPT
	FROM dbo.CustPTGroupSetting3rd_Member C WITH(NOLOCK) 
		INNER JOIN #SMATemp ci 
			ON ci.custid = C.AgentID
			AND ci.roleid = 2
	WHERE c.SportType = @fSporttype
		AND c.BetType= @fBetType
	
	--------------------------------------STAKE LEVEL , all level for Agent and min level for member------------------------------------------------
	SELECT e.currency
		,CAST (STUFF (STL, 1,1, '') AS VARCHAR(500)) AS StakeLevelList
		,CAST (M.StakeLevelID AS VARCHAR(10)) AS Min_StakeLevel
	INTO #StakeLevelList
	FROM #DestinationSportBetType t
		CROSS APPLY (
						SELECT Currency 
						FROM ( VALUES(20)) exchange(Currency)
						) e
		CROSS APPLY (SELECT ',' + CAST(StakeLevelID AS VARCHAR(10))
					FROM StakeLevel S WITH (NOLOCK)
					WHERE S.GameTypeID = t.tBetType AND S.ExchangeId = e.Currency
					FOR XML PATH ('') 
					) AS A(STL)
		CROSS APPLY (SELECT TOP 1 StakeLevelID
					FROM StakeLevel S WITH (NOLOCK)
						LEFT JOIN GameGroup gg WITH(NOLOCK) 
							ON s.GameGroupID = gg.GameGroupID
					WHERE S.GameTypeID = t.tBetType AND S.ExchangeId = e.Currency
					ORDER BY s.MaxStake ASC, s.MinStake ASC, gg.GroupName ASC
					) AS M
	WHERE t.SettingType = 8

	--SMA Level
	INSERT INTO dbo.CustStakeLevel_Agent ([CustID],[SportType],[BetType],[StakeLevelList]) 
	SELECT t.custid, @Sporttype, @Bettype, s.StakeLevelList
	FROM  #SMATemp t
		INNER JOIN #StakeLevelList s ON t.Currency= s.Currency

	UPDATE #MemberTemp SET IsFinished = 0
			
	--Member Level
	WHILE 1 = 1
	BEGIN 
		TRUNCATE TABLE #MemberTempBatch
		
		UPDATE TOP(@BatchNum) #MemberTemp 
		SET IsFinished = 1
		OUTPUT deleted.CustID,deleted.Currency INTO #MemberTempBatch(CustID,Currency)
		WHERE IsFinished = 0

		IF @@ROWCOUNT = 0
			BREAK;

		--Member Level
		INSERT INTO dbo.CustStakeLevel_Member ([CustID],[SportType],[BetType],[StakeLevelList],LastUpdated) 
		SELECT t.custid, @Sporttype, @Bettype, s.Min_StakeLevel ,GETDATE()
		FROM  #MemberTempBatch t
			INNER JOIN #StakeLevelList s ON t.Currency= s.Currency

	END
	--------------------------------------Win Loss Limit - Migrate from Old Structure -------------------------------------------------
	--SMA level
	INSERT INTO dbo.CustWinLossLimit_Agent(CustID, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
	SELECT c.CustID, @SportType, @BetType, c.MaxWinLimit, c.MaxLossLimit, c.IsAutoReset	
	FROM dbo.CustWinLimit c WITH(NOLOCK)
		INNER JOIN #SMATemp ci  
			ON c.CustID = ci.custid
	WHERE c.SportType = @Sporttype
		AND c.BetType= @BetType
	
	--Member Level
	UPDATE #MemberTemp SET IsFinished = 0

	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #MemberTempBatch

		UPDATE TOP(@BatchNum) #MemberTemp 
		SET IsFinished = 1
		OUTPUT deleted.CustID INTO #MemberTempBatch(CustID)
		WHERE IsFinished = 0

		IF @@ROWCOUNT = 0
			BREAK;

		--Member Level
		INSERT INTO dbo.CustWinLossLimit_Member(CustID, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
		SELECT c.CustID, @SportType, @BetType, c.MaxWinLimit, c.MaxLossLimit, c.IsAutoReset	
		FROM dbo.CustWinLimit c WITH(NOLOCK)
			INNER JOIN #MemberTempBatch ci  
				ON c.CustID = ci.custid
		WHERE c.SportType = @Sporttype
			AND c.BetType = @BetType
	END

	--------------------------------------Product Status - migrate from old structure------------------------------------------------
	--SMA level
	UPDATE cs
	SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
		bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,ci.DisableCasino)) 
	FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #SMATemp t WITH(NOLOCK) ON cs.CustID = t.CustID
		INNER JOIN custInfo ci WITH(NOLOCK) ON cs.CustID = ci.CustID

	--Member level
	UPDATE #MemberTemp SET IsFinished = 0

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #MemberTempBatch

		UPDATE TOP (5000)  t 
		SET t.IsFinished = 1 
		OUTPUT DELETED.CustID INTO #MemberTempBatch(CustID) 
		FROM #MemberTemp t 
		WHERE t.IsFinished = 0

		IF @@ROWCOUNT=0
			BREAK

		UPDATE cs
		SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
			bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,ci.DisableCasino))
		FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #MemberTempBatch t WITH(NOLOCK) ON cs.CustID = t.CustID
			INNER JOIN custInfo ci WITH(NOLOCK) ON cs.CustID = ci.CustID
	END
	
	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
	DROP TABLE #DestinationSportBetType	
	DROP TABLE #MemberTempBatch
	DROP TABLE #supers
	DROP TABLE #StakeLevelList
END
GO
