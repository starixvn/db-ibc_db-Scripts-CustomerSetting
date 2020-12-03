/*
	Created: 20201111@Tina
	Task: Adjust Setting for Big Gaming (BG) [Redmine: #142458]
	DB: DBCUST/CustDB
*/ 


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
		AND ci.currency IN (13, -- CNY(RMB)
							15,-- IDR(IN)
							22,-- IDR(IND)
							33,-- IDR(IDD)
							34,-- IDR(IDR)
							47,-- IDR(DDD)
							51,-- VND(INH)
							2,-- MYR(RM)
							67,--HKD(HKK)
							43,-- THB(THB)
							69,-- MMK(MMK)
							3,-- USD(US$)
							16,-- USD(Yen)
							35,-- USD($US)
							64,-- USD(UT)
							95,-- USD(USD)
							6,-- EUR(EURO)
							12-- GBP(GBP)
						) --supported currencies

	DECLARE @msgDone NVARCHAR(200) = 'Done for sporttype %d, bettype %d.'

	CREATE TABLE #SMAList_PT (custid INT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY, IsAutoMPositionTaking BIT, AutoMPositionTaking SMALLMONEY, IsAutoPositionTaking BIT, AutoPositionTaking SMALLMONEY, MinPositionTaking SMALLMONEY, MaxPositionTaking SMALLMONEY)
	CREATE TABLE #MemberList_PT (custid INT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY, IsAutoMPositionTaking BIT, AutoMPositionTaking SMALLMONEY, IsAutoPositionTaking BIT, AutoPositionTaking SMALLMONEY)	
	CREATE TABLE #Super_WrongPT (custid INT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY)
	CREATE TABLE #AgentGroupPT ( AgentID INT, IsLive BIT, SuperPT TINYINT, MasterPT TINYINT, AgentPT TINYINT, IsAutoMasterPT BIT, AutoMasterPT TINYINT, IsAutoSuperPT BIT, AutoSuperPT TINYINT)

	CREATE TABLE #SMAList_CommSetting (custid INT, Discount DECIMAL(9,8))
	CREATE TABLE #MemberList_CommSetting (custid INT, SuperDiscount DECIMAL(9,8), MasterDiscount DECIMAL(9,8), AgentDiscount DECIMAL(9,8), PlayerDiscount DECIMAL(9,8))

	CREATE TABLE #SMAList_WL (custid INT, MaxWinLimit MONEY, MaxLossLimit MONEY, IsAutoReset BIT)
	CREATE TABLE #MemberList_WL(custid INT, MaxWinLimit MONEY,MaxLossLimit MONEY, IsAutoReset BIT)

	DECLARE @ProductID TINYINT = 41, @SportType INT = 239
	DECLARE @SettingType_PT INT = 18 , @SettingType_Comm INT = 19, @SettingType_WinLoss INT = 6
	DECLARE @fSportType SMALLINT, @fBetType SMALLINT, @tSportType SMALLINT, @tBetType SMALLINT, @IsLive BIT
	
	CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT, IsFinished BIT)
	INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
	SELECT	243, 3101, SportType, BetType, 0, SettingType, 0 --copy from AE Casino
	FROM ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SportType = @Sporttype AND SettingType IN (@SettingType_PT,@SettingType_Comm,@SettingType_WinLoss) --  PT, Comm, WinLoss 

	--------------------------------------PT Setting-------------------------------------------------	
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType, @tSportType = tSportType, @tBetType = tBetType
	FROM #DestinationSportBetType		
	WHERE SettingType = @SettingType_PT

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
	WHERE C.bettype = @fBetType AND C.sporttype = @fSportType AND csm.SportType = @tSportType AND csm.BetType = @tBetType
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
			AND SettingType = @SettingType_PT

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
		WHERE csm.bettype = @tBetType AND csm.sporttype = @tSportType

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
	--------------------------------------Commission Setting-------------------------------------------------		
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType, @tSportType = tSportType, @tBetType = tBetType
	FROM #DestinationSportBetType		
	WHERE SettingType = @SettingType_Comm

	--Agent Level
	INSERT INTO #SMAList_CommSetting (custid, Discount)
	SELECT C.custid, C.Discount
	FROM dbo.CustDiscount3rd_Agent C WITH(NOLOCK)
		INNER JOIN custInfo ci WITH(NOLOCK) ON C.CustID = ci.custid
		INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
		INNER JOIN dbo.CustDiscount3rd_Agent csa WITH(NOLOCK) ON csa.custid = C.custid
	WHERE C.sporttype = @fSportType AND c.bettype = @fBetType AND csa.SportType = @tSportType AND csa.BetType = @tBetType
			AND ci.roleid IN (2,3,4) AND Enabled = 1
			AND C.Discount <> csa.Discount

	--Member Level
	INSERT INTO #MemberList_CommSetting (custid, SuperDiscount, MasterDiscount, AgentDiscount, PlayerDiscount)
	SELECT C.custid, C.SuperDiscount, C.MasterDiscount, C.AgentDiscount, C.PlayerDiscount
	FROM dbo.CustDiscount3rd_Member C WITH(NOLOCK) 
		INNER JOIN custInfo ci WITH(NOLOCK) ON C.CustID = ci.custid
		INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
		INNER JOIN dbo.CustDiscount3rd_Member csm WITH(NOLOCK) ON csm.custid = C.custid
	WHERE C.sporttype = @fSportType AND C.bettype = @fBetType AND csm.SportType = @tSportType AND csm.BetType = @tBetType
			AND ci.roleid = 1 AND Enabled = 1
			AND (
				C.SuperDiscount<> csm.SuperDiscount
				OR C.MasterDiscount <> csm.MasterDiscount
				OR C.AgentDiscount	 <> csm.AgentDiscount			
				OR C.PlayerDiscount <> csm.PlayerDiscount
				)

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
			AND SettingType = @SettingType_Comm

		IF @@ROWCOUNT = 0 BREAK

		UPDATE csa
		SET csa.Discount = cs.Discount       
		FROM dbo.CustDiscount3rd_Agent csa WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #SMAList_CommSetting cs WITH(NOLOCK) ON cs.custid = csa.CustID
		WHERE csa.SportType = @tSportType AND csa.BetType = @tBetType

		UPDATE csm
		SET csm.SuperDiscount = cs.SuperDiscount,       
			csm.MasterDiscount = cs.MasterDiscount,   
			csm.AgentDiscount = cs.AgentDiscount,
			csm.PlayerDiscount = cs.PlayerDiscount
		FROM dbo.CustDiscount3rd_Member csm WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #MemberList_CommSetting cs WITH(NOLOCK) ON cs.custid = csm.CustID
		WHERE csm.SportType = @tSportType AND csm.BetType = @tBetType
	END

		--------------------------------------Winloss Setting-------------------------------------------------		
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType, @tSportType = tSportType, @tBetType = tBetType
	FROM #DestinationSportBetType		
	WHERE SettingType = @SettingType_WinLoss

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
			AND SettingType = @SettingType_WinLoss
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
	DROP TABLE #SMAList_CommSetting
	DROP TABLE #MemberList_CommSetting
	DROP TABLE #SMAList_WL
	DROP TABLE #MemberList_WL
	DROP TABLE #Super_WrongPT
	DROP TABLE #supers
	

