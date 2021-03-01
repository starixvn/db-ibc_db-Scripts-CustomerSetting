/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Winfred
	Date: 20210223
	Task: Adjust setting of Sports Lottery [Redmine: 147361]
	DB: DBCUST/CustDB
	
	P/s : Step 7 Adjust setting
*/ 
 
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
	USE CustDB
	GO

	PRINT N'Step 7: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

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

	CREATE TABLE #SMAList_PT (custid INT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY, IsAutoMPositionTaking BIT, AutoMPositionTaking SMALLMONEY, IsAutoPositionTaking BIT, AutoPositionTaking SMALLMONEY, MinPositionTaking SMALLMONEY, MaxPositionTaking SMALLMONEY)
	CREATE TABLE #MemberList_PT (custid INT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY, IsAutoMPositionTaking BIT, AutoMPositionTaking SMALLMONEY, IsAutoPositionTaking BIT, AutoPositionTaking SMALLMONEY)	
	CREATE TABLE #AgentGroupPT ( AgentID INT, IsLive BIT, SuperPT TINYINT, MasterPT TINYINT, AgentPT TINYINT, IsAutoMasterPT BIT, AutoMasterPT TINYINT, IsAutoSuperPT BIT, AutoSuperPT TINYINT)
	CREATE TABLE #Super_WrongPT (custid INT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY)	

	CREATE TABLE #SMAList_BetSetting (custid INT, MinBet MONEY, MaxBet MONEY, MaxPerMatch MONEY)
	CREATE TABLE #MemberList_BetSetting(custid INT, MinBet MONEY, MaxBet MONEY, MaxPerMatch MONEY)

	CREATE TABLE #SMAList_WL (custid INT, MaxWinLimit MONEY, MaxLossLimit MONEY, IsAutoReset BIT)
	CREATE TABLE #MemberList_WL(custid INT, MaxWinLimit MONEY,MaxLossLimit MONEY, IsAutoReset BIT)

	DECLARE @ProductID TINYINT = 44, @Sporttype INT = 169 ,@Bettype INT  = 3611
	DECLARE @fSportType SMALLINT, @fBetType SMALLINT, @tSportType SMALLINT, @tBetType SMALLINT, @IsLive BIT

	CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT, IsFinished BIT)
	INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
	SELECT	220, 1024, SportType, BetType, 0, SettingType, 0
	FROM ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SportType = @Sporttype AND SettingType IN (2,18) --  PT,BetLimit
	
	INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
	SELECT	220, 1021, SportType, BetType, 0, SettingType, 0
	FROM ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SportType = @Sporttype AND SettingType IN (6) --  

	--------------------------------------PT Setting-------------------------------------------------		
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType, @tSportType = tSportType, @tBetType = tBetType 
	FROM #DestinationSportBetType		
	WHERE SettingType = 18

	--AGENT LEVEL
	INSERT INTO #SMAList_PT (custid, SPositionTaking, MPositionTaking, APositionTaking, IsAutoMPositionTaking, AutoMPositionTaking, IsAutoPositionTaking, AutoPositionTaking, MinPositionTaking, MaxPositionTaking)
	SELECT C.custid, C.SuperPT, C.MasterPT, C.AgentPT, C.IsAutoMasterPT, C.AutoMasterPT, C.IsAutoSuperPT, C.AutoSuperPT, C.MinPT, C.MaxPT
	FROM dbo.CustPTSetting3rd_Agent C WITH(NOLOCK)
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = C.custid
		INNER JOIN #supers s WITH (NOLOCK) ON CI.srecommend = S.custid
		INNER JOIN dbo.CustPTSetting3rd_Agent csa WITH (NOLOCK) ON C.custid = csa.custid
		WHERE C.bettype = @fBetType	AND C.SportType = @fSportType AND csa.SportType = @tSportType AND csa.BetType = @tBetType
										AND ci.roleid IN (2,3,4) AND Enabled = 1
										AND (
										C.SuperPT <> csa.SuperPT
										OR C.MasterPT  <> csa.MasterPT
										OR C.AgentPT <> csa.AgentPT
										OR C.IsAutoMasterPT <> csa.IsAutoMasterPT
										OR C.AutoMasterPT  <> csa.AutoMasterPT
										OR C.IsAutoSuperPT <> csa.IsAutoSuperPT
										OR C.AutoSuperPT  <> csa.AutoSuperPT
										OR C.MinPT  <> csa.MinPT
										OR C.MaxPT <> csa.MaxPT
										)


	--MEMBER LEVEL
	INSERT INTO #MemberList_PT (custid, SPositionTaking, MPositionTaking, APositionTaking, IsAutoMPositionTaking, AutoMPositionTaking, IsAutoPositionTaking, AutoPositionTaking)
	SELECT C.custid, C.SuperPT, C.MasterPT, C.AgentPT, C.IsAutoMasterPT, C.AutoMasterPT, C.IsAutoSuperPT, C.AutoSuperPT
	FROM dbo.CustPTSetting3rd_Member C WITH(NOLOCK)
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = C.custid
		INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
		INNER JOIN dbo.CustPTSetting3rd_Member csm WITH(NOLOCK) ON csm.custid = c.custid 
	WHERE C.bettype = @fBetType AND C.sporttype = @tSportType AND csm.SportType = @tSportType AND csm.BetType = @tBetType
			AND ci.roleid = 1 AND Enabled = 1
			AND (
				C.SuperPT <> csm.SuperPT
				OR C.MasterPT <> csm.MasterPT
				OR C.AgentPT<> csm.AgentPT
				OR C.IsAutoMasterPT <> csm.IsAutoMasterPT
				OR C.AutoMasterPT  <> csm.AutoMasterPT
				OR C.IsAutoSuperPT <> csm.IsAutoSuperPT
				OR C.AutoSuperPT <> csm.AutoSuperPT
				)
	
	--Group PT
	INSERT INTO #AgentGroupPT (AgentID, IsLive, SuperPT, MasterPT, AgentPT, IsAutoMasterPT, AutoMasterPT, IsAutoSuperPT, AutoSuperPT)
	SELECT C.AgentID, C.IsLive, C.SuperPT, C.MasterPT, C.AgentPT, C.IsAutoMasterPT, C.AutoMasterPT, C.IsAutoSuperPT, C.AutoSuperPT
	FROM dbo.CustPTGroupSetting3rd_Member C WITH (NOLOCK)
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = C.AgentID
		INNER JOIN #supers s WITH (NOLOCK) ON CI.srecommend = S.custid
		INNER JOIN dbo.CustPTGroupSetting3rd_Member csa WITH (NOLOCK) ON C.AgentID = csa.AgentID
	WHERE C.SportType = @fSportType AND C.BetType = @fBetType 
			AND csa.SportType = @tSportType AND csa.BetType = @tBetType
			AND ci.roleid IN (2) 
			AND Enabled = 1
			AND(   C.SuperPT		<> csa.SuperPT				
				OR C.MasterPT		<> csa.MasterPT	
				OR C.AgentPT		<> csa.AgentPT
				OR C.IsAutoMasterPT	<> csa.IsAutoMasterPT
				OR C.AutoMasterPT	<> csa.AutoMasterPT
				OR C.IsAutoSuperPT	<> csa.IsAutoSuperPT
				OR C.AutoSuperPT	<> csa.AutoSuperPT)

	--Wrong PT
	INSERT INTO #Super_WrongPT (custid, SPositionTaking, MPositionTaking, APositionTaking)
	SELECT csa.custid, csa.SuperPT, csa.MasterPT, csa.AgentPT
	FROM dbo.CustPTSetting3rd_Agent csa WITH(NOLOCK)
		INNER JOIN #supers s WITH (NOLOCK) ON s.custid = csa.custid
	WHERE csa.SportType = @tSportType AND csa.BetType = @tBetType
			AND (
				csa.MasterPT > csa.SuperPT
				OR csa.AgentPT > csa.MasterPT
				OR csa.AgentPT > csa.SuperPT
				)

	--Adjust data
	WHILE (1 = 1)
	BEGIN				
		UPDATE TOP (1) #DestinationSportBetType
		SET IsFinished = 1		
			,@tBetType = tBetType
			,@tSportType = tSportType
			,@IsLive = IsLive
		WHERE IsFinished = 0
			AND SettingType = 18

		IF @@ROWCOUNT = 0 BREAK	

		UPDATE csa
		SET	csa.SuperPT = C.spositiontaking 
			,csa.MasterPT =  C.mpositiontaking 
			,csa.AgentPT = C.apositiontaking
			,csa.IsAutoMasterPT = C.isautompositiontaking
			,csa.AutoMasterPT = C.autompositiontaking
			,csa.IsAutoSuperPT = C.isautopositiontaking 
			,csa.AutoSuperPT = C.autopositiontaking
			,csa.MinPT = C.minpositiontaking
			,csa.MaxPT = C.MaxPositionTaking
		FROM dbo.CustPTSetting3rd_Agent csa WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #SMAList_PT C WITH(NOLOCK) ON csa.custid = C.custid
		WHERE csa.SportType = @tSportType AND csa.BetType = @tBetType
	
		UPDATE csm
		SET	csm.SuperPT = C.spositiontaking 
			,csm.MasterPT =  C.mpositiontaking 
			,csm.AgentPT = C.apositiontaking
			,csm.IsAutoMasterPT = C.isautompositiontaking
			,csm.AutoMasterPT = C.autompositiontaking
			,csm.IsAutoSuperPT = C.isautopositiontaking 
			,csm.AutoSuperPT = C.autopositiontaking
		FROM dbo.CustPTSetting3rd_Member csm WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #MemberList_PT C WITH (NOLOCK) ON C.custid = csm.custid
		WHERE csm.sporttype = @tSportType AND csm.bettype = @tBetType

		UPDATE CSA
		SET CSA.SuperPT		= C.SuperPT		
			,CSA.MasterPT		= C.MasterPT	
			,CSA.AgentPT			= C.AgentPT
			,CSA.IsAutoMasterPT	= C.IsAutoMasterPT
			,CSA.AutoMasterPT	= C.AutoMasterPT
			,CSA.IsAutoSuperPT	= C.IsAutoSuperPT
		 ,	CSA.AutoSuperPT		= C.AutoSuperPT
		FROM CustPTGroupSetting3rd_Member CSA WITH (UPDLOCK,ROWLOCK)
			INNER JOIN #AgentGroupPT C WITH (NOLOCK) ON CSA.AgentID = C.AgentID
		WHERE CSA.SportType = @tSportType AND CSA.BetType = @tBetType

		--Adjust m4 = s4 if m4 > s4; a4 = m4 if a4 > m4; a4 = s4 if a4 > s4
		UPDATE csa
		SET	csa.MasterPT = CASE WHEN csa.MasterPT > csa.SuperPT THEN csa.SuperPT ELSE csa.MasterPT END,
			csa.AgentPT = CASE	WHEN csa.AgentPT > csa.SuperPT THEN csa.SuperPT 
								WHEN csa.AgentPT > csa.MasterPT THEN csa.MasterPT
								ELSE csa.AgentPT END
		FROM dbo.CustPTSetting3rd_Agent csa WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #Super_WrongPT cs WITH(NOLOCK) ON csa.custid = cs.custid
		WHERE csa.SportType = @tSportType AND csa.BetType = @tBetType

	END	

--------------------------------------Bet Setting-------------------------------------------------
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType, @tSportType = tSportType, @tBetType = tBetType
	FROM #DestinationSportBetType		
	WHERE SettingType = 2

	INSERT INTO #SMAList_BetSetting(CustID, MinBet, MaxBet, MaxPerMatch)
	SELECT f.CustID, f.MinBet, f.MaxBet, f.MaxPerMatch
	FROM dbo.CustBetSetting3rd_Agent f WITH (NOLOCK)
		INNER JOIN custInfo ci WITH(NOLOCK) ON f.CustID = ci.custid
		INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
		INNER JOIN dbo.CustBetSetting3rd_Agent t  WITH (NOLOCK)
			ON f.CustID = t.CustID 
			AND t.SportType = @tSportType 
			AND t.BetType = @tBetType
	WHERE f.SportType = @fSportType AND f.BetType = @fBetType
	AND(   f.MinBet		<> t.MinBet				
		OR f.MaxBet		<> t.MaxBet		
		OR f.MaxPerMatch<> t.MaxPerMatch)

	INSERT INTO #MemberList_BetSetting(CustID, MinBet, MaxBet, MaxPerMatch)
	SELECT f.CustID, f.MinBet, f.MaxBet, f.MaxPerMatch
	FROM CustBetSetting3rd_Member f WITH (NOLOCK)
		INNER JOIN custInfo ci WITH(NOLOCK) ON f.CustID = ci.custid
		INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
		INNER JOIN dbo.CustBetSetting3rd_Member t  WITH (NOLOCK)
			ON f.CustID = t.CustID 
			AND t.SportType = @tSportType 
			AND t.BetType = @tBetType
	WHERE f.SportType = @fSportType AND f.BetType = @fBetType
	AND(   f.MinBet		<> t.MinBet				
		OR f.MaxBet		<> t.MaxBet		
		OR f.MaxPerMatch<> t.MaxPerMatch)

	UPDATE a
	SET	a.MinBet		= t.MinBet		
		 ,a.MaxBet		= t.MaxBet	
		 ,a.MaxPerMatch	= t.MaxPerMatch
	FROM CustBetSetting3rd_Agent a WITH(ROWLOCK)
		INNER JOIN #SMAList_BetSetting t ON a.CustId = t.CustId
	WHERE a.SportType = @tSportType AND a.BetType = @tBetType

	UPDATE a
	SET	a.MinBet		= t.MinBet		
		 ,a.MaxBet		= t.MaxBet	
		 ,a.MaxPerMatch	= t.MaxPerMatch
	FROM CustBetSetting3rd_Member a WITH(ROWLOCK)
		INNER JOIN #MemberList_BetSetting t ON a.CustId = t.CustId
	WHERE a.SportType = @tSportType AND a.BetType = @tBetType

--------------------------------------Win Loss Limit-------------------------------------------------
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType, @tSportType = tSportType, @tBetType = tBetType
	FROM #DestinationSportBetType		
	WHERE SettingType = 6
	--Agent Level
	INSERT INTO #SMAList_WL (CustId, MaxWinLimit, MaxLossLimit, IsAutoReset)
	SELECT ci.custid, C.MaxWinLimit, C.MaxLossLimit, C.IsAutoReset
	FROM dbo.CustWinLossLimit_Agent C WITH(NOLOCK) 
		INNER JOIN custInfo ci WITH(NOLOCK) ON C.CustID = ci.custid
		INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
		INNER JOIN dbo.CustWinLossLimit_Agent CSM WITH(NOLOCK) ON CSM.custid = C.custid
	WHERE C.sporttype = @fSportType AND C.bettype = @fBetType AND CSM.SportType = @tSportType AND CSM.BetType = @tBetType
		AND ci.roleid IN (2,3,4) AND Enabled = 1
		AND (C.MaxLossLimit <> CSM.MaxLossLimit
			OR C.MaxWinLimit <> CSM.MaxWinLimit
			OR C.IsAutoReset <> CSM.IsAutoReset)
	--Member Level
	INSERT INTO #MemberList_WL (CustId, MaxWinLimit, MaxLossLimit, IsAutoReset)
	SELECT ci.custid, C.MaxWinLimit, C.MaxLossLimit, C.IsAutoReset
	FROM dbo.CustWinLossLimit_Member C WITH(NOLOCK) 
		INNER JOIN custInfo ci WITH(NOLOCK) ON C.CustID = ci.custid
		INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
		INNER JOIN dbo.CustWinLossLimit_Member CSM WITH(NOLOCK) ON csm.custid = C.custid
	WHERE C.sporttype = @fSportType AND C.bettype = @fBetType AND csm.SportType = @tSportType AND csm.BetType = @tBetType
			AND ci.roleid = 1 AND Enabled = 1
			AND (C.MaxLossLimit <> CSM.MaxLossLimit
			OR C.MaxWinLimit <> CSM.MaxWinLimit
			OR C.IsAutoReset <> CSM.IsAutoReset)
		
	WHILE (1 = 1)
	BEGIN	
		UPDATE TOP (1) #DestinationSportBetType
		SET IsFinished = 1
			,@fBetType = fBetType	
			,@fSportType = fSportType
			,@tBetType = tBetType
			,@tSportType = tSportType
			,@IsLive = IsLive
		WHERE IsFinished = 0
			AND SettingType = 6
		IF @@ROWCOUNT = 0 BREAK

		UPDATE csa
		SET csa.MaxWinLimit = cs.MaxWinLimiT,csa.MaxLossLimit = cs.MaxLossLimit, csa.IsAutoReset = cs.IsAutoReset     
		FROM dbo.CustWinLossLimit_Agent csa WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #SMAList_WL cs WITH(NOLOCK) ON cs.custid = csa.CustID
		WHERE csa.SportType = @tSportType AND csa.BetType = @tBetType

		UPDATE csm
		SET csm.MaxWinLimit = cs.MaxWinLimit,csm.MaxLossLimit = cs.MaxLossLimit, csm.IsAutoReset = cs.IsAutoReset
		FROM dbo.CustWinLossLimit_Member csm WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #MemberList_WL cs WITH(NOLOCK) ON cs.custid = csm.CustID
		WHERE csm.SportType = @tSportType AND csm.BetType = @tBetType
	END


	DROP TABLE #DestinationSportBetType
	DROP TABLE #SMAList_PT
	DROP TABLE #MemberList_PT
	DROP TABLE #AgentGroupPT
	DROP TABLE #Super_WrongPT
	DROP TABLE #SMAList_BetSetting
	DROP TABLE #MemberList_BetSetting
	DROP TABLE #SMAList_WL
	DROP TABLE #MemberList_WL
	DROP TABLE #supers
	
	PRINT N'Step 7: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
