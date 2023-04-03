/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230314@Eden
	Task: Initialize Setting and Product Status of NG for Credit customers - UUS New accs [Redmine: #179711]
	DB: DBCUST/CustDB 
*/ 
	CREATE TABLE #supers (custid int)
	CREATE TABLE #CustPTSetting3rd_Agent(CustID INT, SportType SMALLINT, BetType SMALLINT)
	CREATE TABLE #CustPTSetting3rd_Member (CustID INT, SportType SMALLINT, BetType SMALLINT)
	CREATE TABLE #CustPTGroupSetting3rd_Member (CustID INT, SportType SMALLINT, BetType SMALLINT)
	CREATE TABLE #CustBetSetting3rd_Agent(CustID INT, SportType SMALLINT, BetType SMALLINT)
	CREATE TABLE #CustBetSetting3rd_Member (CustID INT, SportType SMALLINT, BetType SMALLINT)
	CREATE TABLE #CustTempBatch (CustID INT, SportType SMALLINT, BetType SMALLINT)
	CREATE TABLE #SportBetType(SportType SMALLINT, BetType SMALLINT)

	INSERT INTO #SportBetType(SportType,BetType)
	SELECT 161, 81 UNION ALL
	SELECT 202, 1501 

	DECLARE @maxcustid INT

	SELECT @maxcustid = xxx

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM customer ci WITH (NOLOCK) 
		INNER JOIN custinfo C WITH(NOLOCK) ON c.CustID = ci.custid 
		INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
		LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.roleid = 4  
			AND ci.username NOT LIKE '3rdSuper%'
			AND cs.isinternal = 0
			AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
			AND s.islicensee = 0
			AND ci.Site<>'CN88'
			AND c.Enabled = 1
			AND ci.currency IN (20,72) --UUS

	--------------------DELETE redudant Setting---------------------------------
	--PT
	INSERT INTO #CustPTSetting3rd_Agent(CustID,SportType,BetType)
	SELECT c.CustID,c.SportType,c.BetType
	FROM CustPTSetting3rd_Agent c WITH(NOLOCK)
		INNER JOIN custinfo ci WITH(NOLOCK) ON c.CustID = ci.custid
		INNER JOIN #SportBetType t 
			ON c.SportType = t.SportType AND c.BetType = t.BetType
	WHERE ci.srecommend IN( SELECT custid FROM #supers)
		AND ci.custid > @maxcustid

	INSERT INTO #CustPTSetting3rd_Member(CustID,SportType,BetType)
	SELECT c.CustID,c.SportType,c.BetType
	FROM CustPTSetting3rd_Member c WITH(NOLOCK)
		INNER JOIN custinfo ci WITH(NOLOCK) ON c.CustID = ci.custid
		INNER JOIN #SportBetType t 
			ON c.SportType = t.SportType AND c.BetType = t.BetType
	WHERE ci.srecommend IN( SELECT custid FROM #supers)
		AND ci.custid > @maxcustid

	INSERT INTO #CustPTGroupSetting3rd_Member(CustID,SportType,BetType)
	SELECT c.AgentID,c.SportType,c.BetType
	FROM CustPTGroupSetting3rd_Member c WITH(NOLOCK)
		INNER JOIN custinfo ci WITH(NOLOCK) ON c.AgentID = ci.custid
		INNER JOIN #SportBetType t 
			ON c.SportType = t.SportType AND c.BetType = t.BetType
	WHERE ci.srecommend IN( SELECT custid FROM #supers)
		AND ci.custid > @maxcustid

	--BS
	INSERT INTO #CustBetSetting3rd_Agent(CustID,SportType,BetType)
	SELECT c.CustID,c.SportType,c.BetType
	FROM CustBetSetting3rd_Agent c WITH(NOLOCK)
		INNER JOIN custinfo ci WITH(NOLOCK) ON c.CustID = ci.custid
		INNER JOIN #SportBetType t 
			ON c.SportType = t.SportType AND c.BetType = t.BetType
	WHERE ci.srecommend IN( SELECT custid FROM #supers)
		AND ci.custid > @maxcustid

	INSERT INTO #CustBetSetting3rd_Member(CustID,SportType,BetType)
	SELECT c.CustID,c.SportType,c.BetType
	FROM CustBetSetting3rd_Member c WITH(NOLOCK)
		INNER JOIN custinfo ci WITH(NOLOCK) ON c.CustID = ci.custid
		INNER JOIN #SportBetType t 
			ON c.SportType = t.SportType AND c.BetType = t.BetType
	WHERE ci.srecommend IN( SELECT custid FROM #supers)
		AND ci.custid > @maxcustid

	--SELECT * FROM #CustPTSetting3rd_Agent
	--SELECT * FROM #CustPTSetting3rd_Member
	--SELECT * FROM #CustPTGroupSetting3rd_Member
	--SELECT * FROM #CustBetSetting3rd_Agent
	--SELECT * FROm #CustBetSetting3rd_Member

	DECLARE @BatchNum INT = 5000

	-----------------Delete Setting-------------------
	--PT
	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #CustTempBatch

		DELETE TOP(@batchNum) t
		OUTPUT deleted.CustID, deleted.SportType, deleted.BetType INTO #CustTempBatch(CustID,SportType,BetType)
		FROM #CustPTSetting3rd_Agent t

		IF @@ROWCOUNT = 0
			BREAK;

		DELETE c
		FROM CustPTSetting3rd_Agent c WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempBatch t ON c.CustID = t.CustID AND c.SportType = t.SportType AND c.BetType = t.BetType

	END

	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #CustTempBatch

		DELETE TOP(@batchNum) t
		OUTPUT deleted.CustID, deleted.SportType, deleted.BetType INTO #CustTempBatch(CustID,SportType,BetType)
		FROM #CustPTSetting3rd_Member t

		IF @@ROWCOUNT = 0
			BREAK;

		DELETE c
		FROM CustPTSetting3rd_Member c WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempBatch t ON c.CustID = t.CustID AND c.SportType = t.SportType AND c.BetType = t.BetType

	END

	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #CustTempBatch

		DELETE TOP(@batchNum) t
		OUTPUT deleted.CustID, deleted.SportType, deleted.BetType INTO #CustTempBatch(CustID,SportType,BetType)
		FROM #CustPTGroupSetting3rd_Member t

		IF @@ROWCOUNT = 0
			BREAK;

		DELETE c
		FROM CustPTGroupSetting3rd_Member c WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempBatch t ON c.AgentID = t.CustID AND c.SportType = t.SportType AND c.BetType = t.BetType

	END

	--BS
	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #CustTempBatch

		DELETE TOP(@batchNum) t
		OUTPUT deleted.CustID, deleted.SportType, deleted.BetType INTO #CustTempBatch(CustID,SportType,BetType)
		FROM #CustBetSetting3rd_Agent t

		IF @@ROWCOUNT = 0
			BREAK;

		DELETE c
		FROM CustBetSetting3rd_Agent c WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempBatch t ON c.CustID = t.CustID AND c.SportType = t.SportType AND c.BetType = t.BetType

	END

	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #CustTempBatch

		DELETE TOP(@batchNum) t
		OUTPUT deleted.CustID, deleted.SportType, deleted.BetType INTO #CustTempBatch(CustID,SportType,BetType)
		FROM #CustBetSetting3rd_Member t

		IF @@ROWCOUNT = 0
			BREAK;

		DELETE c
		FROM CustBetSetting3rd_Member c WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempBatch t ON c.CustID = t.CustID AND c.SportType = t.SportType AND c.BetType = t.BetType

	END

	---------------------------INIT SETTING----------------------------------------
	DECLARE @BitmapOrder_NG TINYINT = 41
	DECLARE @BitmapOrder_KN TINYINT = 40

	CREATE TABLE #InitSportBettype(fSportType SMALLINT, fBetType SMALLINT, tSportType SMALLINT, tBetType SMALLINT, SettingType TINYINT,GameTypeID INT)
	INSERT INTO #InitSportBettype(fSportType,fBetType,tSportType,tBetType,SettingType,GameTypeID)
	--PT
	SELECT 161, 85, 161, 81, 1, NULL UNION ALL
	SELECT 202, 1501, 202, 1501, 1, NULL UNION ALL
	--Bet Setting
	SELECT 202, 1501, 202, 1501, 2, 1

	CREATE TABLE #MemberTemp(CustID INT PRIMARY KEY CLUSTERED, DisableNumber BIT, HideKeno BIT, Isfinished BIT DEFAULT 0)
	CREATE TABLE #SMATemp(CustID INT PRIMARY KEY CLUSTERED, roleid TINYINT, DisableNumber BIT, HideKeno BIT, Isfinished BIT DEFAULT 0)

	INSERT INTO #MemberTemp (CustID, DisableNumber, HideKeno)
	SELECT custid, DisableNumber, HideKeno
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN( SELECT custid from #supers) 
		AND roleid = 1  AND Enabled = 1 AND custid > @maxcustid
	
	INSERT INTO #SMATemp (CustID, roleid,DisableNumber, HideKeno)
	SELECT custid, roleid, DisableNumber, HideKeno
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN( SELECT custid from #supers)
		AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @maxcustid

	--------Migrate PT--------------
	--Agent Level NG
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
		C.custid
		,s.tSportType
		,s.tBetType
		,0 AS IsLive
		,C.slivepositiontaking * 100
		,C.mlivepositiontaking * 100
		,C.alivepositiontaking * 100
		,C.isautolivempositiontaking
		,C.autolivempositiontaking * 100
		,C.isautolivepositiontaking
		,C.autolivepositiontaking * 100
		,o.minlivepositiontaking * 100
		,100 AS MAXPT
	FROM dbo.CustSetting3rd C WITH(NOLOCK) 
		INNER JOIN #SMATemp ci ON ci.custid = C.custid
		INNER JOIN #InitSportBettype s ON c.SportType = s.fSportType AND c.bettype = s.fBetType AND s.SettingType = 1
		INNER JOIN custOverride3rd o WITH(NOLOCK) ON c.custid = o.custid AND c.sporttype = o.sporttype AND c.bettype = o.bettype

	--Member Level NG
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
		C.custid
		,s.tSportType
		,s.tBetType
		,0 AS IsLive
		,C.slivepositiontaking * 100
		,C.mlivepositiontaking * 100
		,C.alivepositiontaking * 100
		,C.isautolivempositiontaking
		,C.autolivempositiontaking * 100
		,C.isautolivepositiontaking
		,C.autolivepositiontaking * 100
	FROM CustSetting3rd C WITH(NOLOCK) 
		INNER JOIN #MemberTemp ci ON ci.custid = C.custid
		INNER JOIN #InitSportBettype s ON c.SportType = s.fSportType AND c.bettype = s.fBetType AND s.SettingType = 1

	--Agent Level Keno
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
		C.custid
		,s.tSportType
		,s.tBetType
		,0 AS IsLive
		,C.spositiontaking * 100
		,C.mpositiontaking * 100
		,C.apositiontaking * 100
		,C.isautompositiontaking
		,C.autompositiontaking * 100
		,C.isautopositiontaking
		,C.autopositiontaking * 100
		,o.minpositiontaking * 100
		,100 AS MAXPT
	FROM dbo.CustSettingGame C WITH(NOLOCK) 
		INNER JOIN #SMATemp ci ON ci.custid = C.custid
		INNER JOIN #InitSportBettype s ON c.SportType = s.fSportType AND c.bettype = s.fBetType AND s.SettingType = 1
		INNER JOIN CustOverrideGame o WITH(NOLOCK) ON c.custid = o.custid AND c.sporttype = o.sporttype AND c.bettype = o.bettype

	--Member Level NG
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
		C.custid
		,s.tSportType
		,s.tBetType
		,0 AS IsLive
		,C.spositiontaking * 100
		,C.mpositiontaking * 100
		,C.apositiontaking * 100
		,C.isautompositiontaking
		,C.autompositiontaking * 100
		,C.isautopositiontaking
		,C.autopositiontaking * 100
	FROM CustSettingGame C WITH(NOLOCK) 
		INNER JOIN #MemberTemp ci ON ci.custid = C.custid
		INNER JOIN #InitSportBettype s ON c.SportType = s.fSportType AND c.bettype = s.fBetType AND s.SettingType = 1

	------------Bet Setting------------------
	--Agent Keno
	INSERT INTO CustBetSetting3rd_Agent (CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch)
	SELECT c.custid
		,s.tSportType
		,s.tBetType
		,c.MinBet
		,c.MaxBet
		,c.MaxPerGameType
	FROM dbo.CustGameType C WITH(NOLOCK) 
		INNER JOIN #SMATemp ci ON ci.custid = C.custid
		INNER JOIN #InitSportBettype s ON c.GameTypeID = s.GameTypeID AND s.SettingType = 2

	--Member Keno
	INSERT INTO CustBetSetting3rd_Member (CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch)
	SELECT c.custid
		,s.tSportType
		,s.tBetType
		,c.MinBet
		,c.MaxBet
		,c.MaxPerGameType
	FROM dbo.CustGameType C WITH(NOLOCK) 
		INNER JOIN #MemberTemp ci ON ci.custid = C.custid
		INNER JOIN #InitSportBettype s ON c.GameTypeID = s.GameTypeID AND s.SettingType = 2

	-----------------Status------------------------
	CREATE TABLE #CustTempStatus(CustID INT, DisableNumber BIT, HideKeno BIT)
	
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustTempStatus

		UPDATE TOP (@BatchNum)  t 
		SET t.IsFinished = 1 
		OUTPUT DELETED.CustID, DELETED.DisableNumber,deleted.HideKeno INTO #CustTempStatus(CustID,DisableNumber,HideKeno) 
		FROM #SMATemp t 
		WHERE t.IsFinished = 0

		IF @@ROWCOUNT=0
			BREAK

		UPDATE cs
		SET bitmapIsDisabled = dis.NewBitmap
			, bitmapIsHidden = hid.NewBitmap
			, bitmapHasSynced = sync.NewBitmap
		FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempStatus ci WITH(NOLOCK) ON cs.CustID = ci.CustID
			CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapHasSynced,@BitmapOrder_NG,1) as sync
			CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder_NG,ci.DisableNumber) as Dis
			CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder_NG,0) as Hid

		--Enable Keno by default, will disable on step adjust if yes
		UPDATE cs
		SET bitmapIsDisabled = dis.NewBitmap
			,bitmapIsHidden = hid.NewBitmap
			,bitmapHasSynced = sync.NewBitmap
		FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempStatus ci WITH(NOLOCK) ON cs.CustID = ci.CustID
			CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapHasSynced,@BitmapOrder_KN,1) as sync
			CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder_KN,ci.HideKeno) as Dis
			CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder_KN,ci.HideKeno) as Hid
	END

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustTempStatus

		UPDATE TOP (@BatchNum)  t 
		SET t.IsFinished = 1 
		OUTPUT DELETED.CustID, DELETED.DisableNumber,deleted.HideKeno INTO #CustTempStatus(CustID,DisableNumber,HideKeno) 
		FROM #MemberTemp t 
		WHERE t.IsFinished = 0

		IF @@ROWCOUNT=0
			BREAK

		UPDATE cs
		SET bitmapIsDisabled = dis.NewBitmap
			, bitmapIsHidden = hid.NewBitmap
			, bitmapHasSynced = sync.NewBitmap
		FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempStatus ci WITH(NOLOCK) ON cs.CustID = ci.CustID
			CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapHasSynced,@BitmapOrder_NG,1) as sync
			CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder_NG,ci.DisableNumber) as Dis
			CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder_NG,0) as Hid

		--Enable Keno by default, will disable on step adjust if yes
		UPDATE cs
		SET bitmapIsDisabled = dis.NewBitmap
			,bitmapIsHidden = hid.NewBitmap
			,bitmapHasSynced = sync.NewBitmap
		FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempStatus ci WITH(NOLOCK) ON cs.CustID = ci.CustID
			CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapHasSynced,@BitmapOrder_KN,1) as sync
			CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder_KN,ci.HideKeno) as Dis
			CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder_KN,ci.HideKeno) as Hid

	END

DROP TABLE #CustBetSetting3rd_Agent
DROP TABLE #CustBetSetting3rd_Member
DROP TABLE #CustPTGroupSetting3rd_Member
DROP TABLE #CustPTSetting3rd_Agent
DROP TABLE #CustPTSetting3rd_Member
DROP TABLE #CustTempBatch
DROP TABLE #CustTempStatus
DROP TABLE #InitSportBettype
DROP TABLE #MemberTemp
DROP TABLE #SMATemp
DROP TABLE #SportBetType
DROP TABLE #supers
