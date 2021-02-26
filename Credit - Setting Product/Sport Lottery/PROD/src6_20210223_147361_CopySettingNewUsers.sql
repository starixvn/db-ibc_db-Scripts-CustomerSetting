/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Winfred
	Date: 20210223
	Task: Copy setting for newly created customer of Sports Lottery [Redmine: 147361]
	DB: DBCUST/CustDB
	
	P/s : Step 6 Copy setting for newly created customer
*/ 
 
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
	USE CustDB
	GO

	PRINT N'Step 6: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  


	DECLARE @MaxCustID INT
	SELECT @MaxCustID = xxx
	
	IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;
	
	CREATE TABLE #supers (custid INT)
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
		AND ci.currency NOT IN (20,72) -- UUS, YNG

	DECLARE @ProductID TINYINT = 44, @Sporttype INT = 169 ,@Bettype INT  = 3611
	DECLARE @fSportType SMALLINT, @fBetType SMALLINT

	CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT, IsFinished BIT)
	INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
	SELECT	220, 1024, SportType, BetType, 0, SettingType, 0
	FROM ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SportType = @Sporttype AND SettingType IN (2,18) --  PT,WinLossLimit
	
	INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
	SELECT	220, 1021, SportType, BetType, 0, SettingType, 0
	FROM ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SportType = @Sporttype AND SettingType IN (6) --  BetLimit
	
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

	INSERT INTO #MemberTemp (CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 1  AND Enabled = 1 AND custid > @MaxCustID
	
	INSERT INTO #SMATemp (CustID, roleid)
	SELECT custid, roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @MaxCustID 
	
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType 
	FROM #DestinationSportBetType		
	WHERE SettingType = 18

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

--------------------------------------Bet Setting-------------------------------------------------
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType 
	FROM #DestinationSportBetType		
	WHERE SettingType = 2

	--Super level
	INSERT INTO dbo.CustBetSetting3rd_Agent(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
	SELECT cs.CustID, dest.tSportType, dest.tBetType, MinBet, MaxBet, MaxPerMatch	
	FROM dbo.CustBetSetting3rd_Agent cs WITH(NOLOCK)
		INNER JOIN #SMATemp ci  ON Cs.CustID = ci.custid
		CROSS APPLY #DestinationSportBetType dest
	WHERE Cs.bettype = @fBetType AND Cs.SportType = @fSportType
		AND dest.SettingType = 2
	
	--Member Level
	INSERT INTO dbo.CustBetSetting3rd_Member(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
	SELECT cs.CustID, dest.tSportType, dest.tBetType, MinBet, MaxBet, MaxPerMatch
	FROM dbo.CustBetSetting3rd_Member cs WITH(NOLOCK) 
		INNER JOIN #MemberTemp ci WITH(NOLOCK) ON Cs.CustID = ci.custid
		CROSS APPLY #DestinationSportBetType dest
	WHERE Cs.bettype = @fBetType AND Cs.SportType = @fSportType
		AND dest.SettingType = 2

--------------------------------------Win Loss Limit-------------------------------------------------
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType 
	FROM #DestinationSportBetType		
	WHERE SettingType = 6
	
	--Agent Level
	INSERT INTO dbo.CustWinLossLimit_Agent (CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
	SELECT ci.custid, dest.tsporttype, dest.tbettype, MaxWinLimit, MaxLossLimit, IsAutoReset
	FROM CustWinLossLimit_Agent C WITH (NOLOCK) 
		INNER JOIN #SMATemp ci WITH (NOLOCK) ON C.CustId = CI.CustID
		CROSS APPLY #DestinationSportBetType dest WITH(NOLOCK) 
	WHERE dest.SettingType = 6 AND C.bettype = @fBetType AND C.SportType = @fSportType

	--Member Level
	INSERT INTO dbo.CustWinLossLimit_Member (CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
	SELECT ci.custid, dest.tsporttype, dest.tbettype, MaxWinLimit, MaxLossLimit, IsAutoReset
	FROM dbo.CustWinLossLimit_Member C WITH (NOLOCK) 
		INNER JOIN #MemberTemp ci WITH(NOLOCK) ON C.CustId = CI.CustID
		CROSS APPLY #DestinationSportBetType dest WITH(NOLOCK) 
	WHERE dest.SettingType = 6 AND C.bettype = @fBetType AND C.SportType = @fSportType
/*******************************CUST PRODUCTSTATUS TABLE*******************************/
	DECLARE @BitmapOrder TINYINT = 32
	SELECT custid
	INTO #CustList
	FROM dbo.custInfo ci WITH (NOLOCK)
	WHERE ci.srecommend IN (SELECT custid FROM #supers) 
		AND ci.Enabled = 1
		AND ci.custid > @MaxCustID

	UPDATE cs
	SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
		bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,isDisabled.value)) 	
	FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #CustList ci WITH(NOLOCK) ON cs.CustID = ci.CustID
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, 11) as isDisabled


	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
	DROP TABLE #DestinationSportBetType	
	
	PRINT N'Step 6: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
