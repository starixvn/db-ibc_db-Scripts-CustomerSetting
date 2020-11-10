/*
	Created: Winfred
	Date: 20200828
	Task: Copy PT & Comm & WinLossLimit for WM [Redmine: 131589]
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

	DECLARE @ProductID TINYINT = 41, @Sporttype INT = 233 ,@Bettype INT  = 3401
	DECLARE @fSportType SMALLINT, @fBetType SMALLINT ,@StakeLevelList_min varchar(50)
	DECLARE @Currency INT
	SELECT @currency = ci.currency FROM dbo.custInfo ci WITH (NOLOCK) WHERE ci.custid = @srecommend

	CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT, IsFinished BIT)
	INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
	SELECT	243, 3101, SportType, BetType, 0, SettingType, 0
	FROM ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SportType = @Sporttype AND SettingType IN (18,19,6) --  PT,Comm,WinLossLimit

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

	CREATE TABLE #tmpSTListSMA (BettypeID INT PRIMARY KEY, StakeLevelList VARCHAR(500))

	INSERT INTO #MemberTemp (CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1  AND Enabled = 1 AND custid <= @maxcustid
	
	INSERT INTO #SMATemp (CustID, roleid)
	SELECT custid, roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND Enabled = 1 AND custid <= @maxcustid 

	INSERT INTO #tmpSTListSMA(BettypeID, StakelevelList)
	SELECT DISTINCT ST.GameTypeID, CAST (STUFF (STL, 1,1, '')AS VARCHAR(500)) as StakeLevelList
	FROM #SMATemp SMA CROSS JOIN StakeLevel ST
	CROSS APPLY (SELECT ',' + CAST(StakeLevelID AS VARCHAR(10))
			FROM StakeLevel S WITH (NOLOCK)
			WHERE S.GameTypeID =ST.GameTypeID AND S.ExchangeId=@Currency
			FOR XML PATH ('') ) AS A(STL)
	WHERE ST.GameTypeID = @Bettype
	ORDER BY ST.GameTypeID
	--------------------------------------PT Setting-------------------------------------------------	
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType 
	FROM #DestinationSportBetType		
	WHERE SettingType = 18

	BEGIN
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
			AND dest.SettingType = 18

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
			AND dest.SettingType = 18

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
			AND dest.SettingType = 18

	END
--------------------------------------Commission Setting-------------------------------------------------
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType 
	FROM #DestinationSportBetType		
	WHERE SettingType = 19

	--Super level
	INSERT INTO dbo.CustDiscount3rd_Agent(CustID, SportType, BetType, Discount)
	SELECT ci.custid, dest.tsporttype, dest.tbettype, Discount
	FROM dbo.CustDiscount3rd_Agent C WITH(NOLOCK)
		INNER JOIN #SMATemp ci  ON C.CustID = ci.custid
		CROSS APPLY #DestinationSportBetType dest
	WHERE C.bettype = @fBetType AND C.SportType = @fSportType
		AND dest.SettingType = 19
	
	--Member Level
	INSERT INTO dbo.CustDiscount3rd_Member(CustID, SportType, BetType, PlayerDiscount, AgentDiscount, MasterDiscount, SuperDiscount)
	SELECT DISTINCT ci.custid, dest.tsporttype, dest.tbettype, PlayerDiscount, AgentDiscount, MasterDiscount, SuperDiscount
	FROM dbo.CustDiscount3rd_Member C WITH(NOLOCK) 
		INNER JOIN #MemberTemp ci WITH(NOLOCK) ON C.CustID = ci.custid
		CROSS APPLY #DestinationSportBetType dest
	WHERE C.bettype = @fBetType AND C.SportType = @fSportType
		AND dest.SettingType = 19

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
	SET  @StakeLevelList_min  = (SELECT TOP 1 StakeLevelID 
									FROM StakeLevel WITH(NOLOCK)
									WHERE ExchangeId=@currency AND GameTypeID = @Bettype 
									ORDER BY MaxStake ASC)
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
		SELECT DISTINCT t.custid,@Sporttype,TB.BettypeID, @StakeLevelList_min,GETDATE()
		FROM #tmpSTListSMA TB
		CROSS JOIN  #MemberTempBatch t
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
	AND ci.Site NOT IN ('CN88')
	AND CI.currency IN (15 --IN
						,45 --Won
						,2 --RM
						,5 --HK$
						,13 --RMB
						,66 --YUN
						,43 --THB
						,3 --US$
						,16 --Yen
						,35 --$US
						,64 --UT
						,95 -- USD
						,51 -- INH
						,67 --HKK
						,4 --TB
						,22 --IND
						,33 --IDD
						,34 --IDR
						,47 --DDD
					)

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
	AND ci.Site NOT IN ('CN88')
	AND CI.currency IN (15 --IN
						,45 --Won
						,2 --RM
						,5 --HK$
						,13 --RMB
						,66 --YUN
						,43 --THB
						,3 --US$
						,16 --Yen
						,35 --$US
						,64 --UT
						,95 -- USD
						,51 -- INH
						,67 --HKK
						,4 --TB
						,22 --IND
						,33 --IDD
						,34 --IDR
						,47 --DDD
					)

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
