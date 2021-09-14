/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Winfred
	Date: 20210806
	Task: Adjust Setting for Bitcoin [Redmine: 159039]
	DB: DBCUST/CustDB
	
	P/s : Step 9  Adjust Setting PT , Com , winlossLimit for customer
*/
PRINT N'Step 9: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
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
		AND ci.Site NOT IN ('CN88')
		AND ci.currency IN ( 2,3,5,6,7,9,12,13,15,16,22,33,34,35,41,42,43,45,47,50,51,52,53,54,57,58,64,67,69,71,81,95)
		--RM,US$,HK$,EURO,DON,AUD,GBP,RMB,IN,Yen,IND,IDD,IDR,$US,CHF,PE,THB,Won,DDD,CAN,INH,DKK,SEK,NOK,CZK,RON,UT,HKK,MMK,KHR,CY,USD

	CREATE TABLE #SMAList_PT (custid INT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY, IsAutoMPositionTaking BIT, AutoMPositionTaking SMALLMONEY, 
				IsAutoPositionTaking BIT, AutoPositionTaking SMALLMONEY, MinPositionTaking SMALLMONEY, MaxPositionTaking SMALLMONEY,AdjPT BIT DEFAULT 0)
	CREATE TABLE #MemberList_PT (custid INT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY, IsAutoMPositionTaking BIT, AutoMPositionTaking SMALLMONEY, 
				IsAutoPositionTaking BIT, AutoPositionTaking SMALLMONEY,AdjPT BIT DEFAULT 0)	

	CREATE TABLE #SMAList_PTTemp (custid INT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY, IsAutoMPositionTaking BIT, AutoMPositionTaking SMALLMONEY, IsAutoPositionTaking BIT, AutoPositionTaking SMALLMONEY, MinPositionTaking SMALLMONEY, MaxPositionTaking SMALLMONEY)
	CREATE TABLE #MemberList_PTTemp (custid INT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY, IsAutoMPositionTaking BIT, AutoMPositionTaking SMALLMONEY, IsAutoPositionTaking BIT, AutoPositionTaking SMALLMONEY)	

	CREATE TABLE #SMAList_CommSetting (custid INT, Discount DECIMAL(9,8),AdjCom BIT DEFAULT 0)
	CREATE TABLE #MemberList_CommSetting (custid INT, SuperDiscount DECIMAL(9,8), MasterDiscount DECIMAL(9,8), AgentDiscount DECIMAL(9,8), PlayerDiscount DECIMAL(9,8),AdjCom BIT DEFAULT 0)
	
	CREATE TABLE #SMAList_CommSettingTemp (custid INT, Discount DECIMAL(9,8))
	CREATE TABLE #MemberList_CommSettingTemp (custid INT, SuperDiscount DECIMAL(9,8), MasterDiscount DECIMAL(9,8), AgentDiscount DECIMAL(9,8), PlayerDiscount DECIMAL(9,8))

	CREATE TABLE #PTTemp
	(
		CustID				INT ,
		roleid				TINYINT,
		[SportType]			SMALLINT,
		[BetType]			SMALLINT,
		[IsLive]			BIT,
		[SuperPT]			SMALLMONEY,
		[MasterPT]			SMALLMONEY,
		[AgentPT]			SMALLMONEY,
		[IsAutoMasterPT]	BIT,
		[AutoMasterPT]		SMALLMONEY,
		[IsAutoSuperPT]		BIT,
		[AutoSuperPT]		SMALLMONEY,
		[MinPT]				SMALLMONEY,
		[MaxPT]				SMALLMONEY,
		PRIMARY KEY (CustID,SportType,BetType,IsLive)
	)
	
	DECLARE @ProductID TINYINT = 69, @Sporttype INT = 175  ,@Bettype INT  = 7901 
	DECLARE @fSportType SMALLINT, @fBetType SMALLINT, @Currency INT, @tSportType SMALLINT, @tBetType SMALLINT, @IsLive BIT

	CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT,MaxPT SMALLMONEY, IsLive BIT,  SettingType INT, IsFinished BIT)
	INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType,MaxPT, IsLive, SettingType, IsFinished)
	SELECT	1, 3, SportType, BetType,MaxPT, 0, SettingType, 0
	FROM ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SportType = @Sporttype AND bettype = @Bettype AND SettingType IN (1) --  PT
	
	INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
	SELECT	1, 1, SportType, BetType, 0, SettingType, 0
	FROM ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SportType = @Sporttype AND bettype = @Bettype AND SettingType IN (3) --  Commission
	
	INSERT INTO #PTTemp(
		CustID				,
		roleid				,
		[SportType]			,
		[BetType]			,
		[IsLive]			,
		[SuperPT]			,
		[MasterPT]			,
		[AgentPT]			,
		[IsAutoMasterPT]	,
		[AutoMasterPT]		,
		[IsAutoSuperPT]		,
		[AutoSuperPT]		,
		[MinPT]				,
		[MaxPT]				
		)

	SELECT 
		cs.custid,ci.roleid, dest.tsporttype, dest.tbettype, dest.IsLive
		,cs.spositiontaking  *100
		,cs.mpositiontaking  *100
		,cs.apositiontaking  *100
		,cs.isautompositiontaking
		,cs.autompositiontaking *100
		,cs.isautopositiontaking 
		,cs.autopositiontaking  *100
		,co.minpositiontaking  *100
		,100 AS MaxPT
	FROM custInfo ci WITH(NOLOCK)
		INNER JOIN dbo.custSetting cs WITH(NOLOCK) ON ci.custid=cs.custid
		LEFT JOIN dbo.CustOverride co WITH(NOLOCK) ON cs.custid = co.custid and cs.sporttype = co.sporttype and cs.bettype = co.bettype
		INNER JOIN  #DestinationSportBetType dest ON dest.fSportType=cs.sporttype AND dest.fBetType=cs.bettype AND dest.SettingType = 1
	WHERE ci.srecommend  IN (SELECT custid FROM #supers) AND ci.Enabled=1 
	
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType, @tSportType = tSportType, @tBetType = tBetType
	FROM #DestinationSportBetType		
	WHERE SettingType = 1
	
	--AGENT LEVEL
	INSERT INTO #SMAList_PT (custid, SPositionTaking, MPositionTaking, APositionTaking, IsAutoMPositionTaking, AutoMPositionTaking, IsAutoPositionTaking, AutoPositionTaking, MinPositionTaking, MaxPositionTaking)
	SELECT C.custid, C.SuperPT, C.MasterPT, C.AgentPT, C.IsAutoMasterPT, C.AutoMasterPT, C.IsAutoSuperPT, C.AutoSuperPT, C.MinPT, C.MaxPT
	FROM #PTTemp C
		INNER JOIN dbo.CustPTSetting3rd_Agent csa WITH (NOLOCK) ON C.custid = csa.custid AND c.SportType= csa.SportType  AND c.BetType = csa.BetType
	WHERE csa.bettype = @tBetType	AND csa.SportType = @tSportType
										AND C.roleid IN (2,3,4) 
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
	FROM #PTTemp C
		INNER JOIN dbo.CustPTSetting3rd_Member csm WITH(NOLOCK) ON csm.custid = c.custid  AND c.SportType= csm.SportType  AND c.BetType = csm.BetType
	WHERE  csm.bettype = @tBetType	AND csm.SportType = @tSportType
			AND c.roleid = 1
			AND (
				C.SuperPT <> csm.SuperPT
				OR C.MasterPT <> csm.MasterPT
				OR C.AgentPT<> csm.AgentPT
				OR C.IsAutoMasterPT <> csm.IsAutoMasterPT
				OR C.AutoMasterPT  <> csm.AutoMasterPT
				OR C.IsAutoSuperPT <> csm.IsAutoSuperPT
				OR C.AutoSuperPT <> csm.AutoSuperPT
				)
	
	-- Adjust Agent
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #SMAList_PTTemp
		
		UPDATE TOP (3000)  t SET t.AdjPT = 1 
		OUTPUT DELETED.CustID,DELETED.SPositionTaking,DELETED.MPositionTaking,DELETED.APositionTaking ,DELETED.IsAutoMPositionTaking,DELETED.AutoMPositionTaking,DELETED.IsAutoPositionTaking,DELETED.AutoPositionTaking,DELETED.MinPositionTaking,DELETED.MaxPositionTaking
		INTO #SMAList_PTTemp(custid, SPositionTaking, MPositionTaking, APositionTaking, IsAutoMPositionTaking, AutoMPositionTaking, IsAutoPositionTaking, AutoPositionTaking, MinPositionTaking, MaxPositionTaking) 
		FROM #SMAList_PT t WHERE t.AdjPT = 0
		IF @@ROWCOUNT=0
			BREAK
		
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
			INNER JOIN #SMAList_PTTemp C WITH(NOLOCK) ON csa.custid = C.custid
		WHERE csa.SportType = @tSportType AND csa.BetType = @tBetType
	END
	
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #MemberList_PTTemp
		
		UPDATE TOP (3000)  t SET t.AdjPT = 1 
		OUTPUT DELETED.CustID,DELETED.SPositionTaking,DELETED.MPositionTaking,DELETED.APositionTaking ,DELETED.IsAutoMPositionTaking,DELETED.AutoMPositionTaking,DELETED.IsAutoPositionTaking,DELETED.AutoPositionTaking
		INTO #MemberList_PTTemp(custid, SPositionTaking, MPositionTaking, APositionTaking, IsAutoMPositionTaking, AutoMPositionTaking, IsAutoPositionTaking, AutoPositionTaking) 
		FROM #MemberList_PT t WHERE t.AdjPT = 0
		IF @@ROWCOUNT=0
			BREAK
		
		UPDATE csm
		SET	csm.SuperPT = C.spositiontaking 
			,csm.MasterPT =  C.mpositiontaking 
			,csm.AgentPT = C.apositiontaking
			,csm.IsAutoMasterPT = C.isautompositiontaking
			,csm.AutoMasterPT = C.autompositiontaking
			,csm.IsAutoSuperPT = C.isautopositiontaking 
			,csm.AutoSuperPT = C.autopositiontaking
		FROM dbo.CustPTSetting3rd_Member csm WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #MemberList_PTTemp C WITH (NOLOCK) ON C.custid = csm.custid
		WHERE csm.bettype = @tBetType AND csm.sporttype = @tSportType
	END
	
	--------------------------------------Commission Setting-------------------------------------------------		
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType, @tSportType = tSportType, @tBetType = tBetType 
	FROM #DestinationSportBetType		
	WHERE SettingType = 3
	
	--Agent Level
	INSERT INTO #SMAList_CommSetting (custid, Discount)
	SELECT C.custid, (SELECT MAX(Discount) FROM (VALUES  (groupa), (groupb), (groupc),(groupd)) AS t(Discount))  AS Discount
	FROM dbo.custSetting C WITH(NOLOCK)
		INNER JOIN custInfo ci WITH(NOLOCK) ON C.CustID = ci.custid
		INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
		INNER JOIN dbo.CustDiscount3rd_Agent csa WITH(NOLOCK) ON csa.custid = C.custid
	WHERE C.sporttype = @fSportType AND c.bettype = @fBetType AND csa.SportType = @tSportType AND csa.BetType = @tBetType
			AND ci.roleid IN (2,3,4) AND Enabled = 1
			AND (SELECT MAX(Discount) FROM (VALUES  (groupa), (groupb), (groupc),(groupd)) AS t(Discount)) <> csa.Discount
	
	-- Adjust Agent
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #SMAList_CommSettingTemp
		
		UPDATE TOP (3000)  t SET t.AdjCom = 1 
		OUTPUT DELETED.CustID,DELETED.Discount	INTO #SMAList_CommSettingTemp(custid, Discount) FROM #SMAList_CommSetting t WHERE t.AdjCom = 0
		IF @@ROWCOUNT=0
			BREAK
		
		UPDATE csa
		SET csa.Discount = cs.Discount       
		FROM dbo.CustDiscount3rd_Agent csa WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #SMAList_CommSettingTemp cs WITH(NOLOCK) ON cs.custid = csa.CustID
		WHERE csa.SportType = @tSportType AND csa.BetType = @tBetType
	END
		
	--Member Level
	INSERT INTO #MemberList_CommSetting (custid, SuperDiscount, MasterDiscount, AgentDiscount, PlayerDiscount)
	SELECT C.custid, sc.Discount, mc.Discount, ac.Discount, C.playerdiscount
	FROM dbo.custSetting C WITH(NOLOCK) 
		INNER JOIN custInfo ci WITH(NOLOCK) ON C.CustID = ci.custid
		INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
		INNER JOIN dbo.CustDiscount3rd_Member csm WITH(NOLOCK) ON csm.custid = C.custid
		INNER JOIN dbo.CustDiscount3rd_Agent sc WITH (NOLOCK) ON ci.srecommend = sc.custid AND csm.SportType = sc.SportType AND csm.BetType = sc.BetType
		INNER JOIN dbo.CustDiscount3rd_Agent mc WITH (NOLOCK) ON ci.mrecommend = mc.custid AND csm.SportType = mc.SportType AND csm.BetType = mc.BetType
		INNER JOIN dbo.CustDiscount3rd_Agent ac WITH (NOLOCK) ON ci.recommend = ac.custid AND csm.SportType = ac.SportType AND csm.BetType = ac.BetType
	WHERE C.sporttype = @fSportType AND C.bettype = @fBetType AND csm.SportType = @tSportType AND csm.BetType = @tBetType
			AND ci.roleid = 1 AND Enabled = 1
			AND (
				sc.Discount<> csm.SuperDiscount
				OR mc.Discount <> csm.MasterDiscount
				OR ac.Discount	 <> csm.AgentDiscount			
				OR C.PlayerDiscount <> csm.PlayerDiscount
				)
	-- Adjust Agent
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #MemberList_CommSettingTemp
		
		UPDATE TOP (3000)  t SET t.AdjCom = 1 
		OUTPUT DELETED.CustID,DELETED.SuperDiscount,DELETED.MasterDiscount,DELETED.AgentDiscount,DELETED.PlayerDiscount	
		INTO #MemberList_CommSettingTemp(custid, SuperDiscount, MasterDiscount, AgentDiscount, PlayerDiscount) 
		FROM #MemberList_CommSetting t WHERE t.AdjCom = 0
		IF @@ROWCOUNT=0
			BREAK
		
		UPDATE csm
		SET csm.SuperDiscount = cs.SuperDiscount,       
			csm.MasterDiscount = cs.MasterDiscount,   
			csm.AgentDiscount = cs.AgentDiscount,
			csm.PlayerDiscount = cs.PlayerDiscount
		FROM dbo.CustDiscount3rd_Member csm WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #MemberList_CommSettingTemp cs WITH(NOLOCK) ON cs.custid = csm.CustID
		WHERE csm.SportType = @tSportType AND csm.BetType = @tBetType
	END

	DROP TABLE #DestinationSportBetType
	DROP TABLE #SMAList_PT
	DROP TABLE #MemberList_PT
	DROP TABLE #SMAList_CommSetting
	DROP TABLE #MemberList_CommSetting
	DROP TABLE #supers
	
PRINT N'Step 9: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 