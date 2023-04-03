/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230314@Eden
	Task: Adjust Setting [Redmine: #179711]
	DB: DBCUST/CustDB
*/ 
DECLARE @BatchSize INT = 5000

CREATE TABLE #supers (custid int PRIMARY KEY)
INSERT INTO #supers(custid)
SELECT DISTINCT ci.custid
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
		AND ci.currency NOT IN (20,72) 

CREATE TABLE #SMAList_PT (custid INT, Sporttype SMALLINT, Bettype SMALLINT, IsLive BIT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY, IsAutoMPositionTaking BIT, AutoMPositionTaking SMALLMONEY, IsAutoPositionTaking BIT, AutoPositionTaking SMALLMONEY, MinPositionTaking SMALLMONEY, MaxPositionTaking SMALLMONEY)
CREATE TABLE #MemberList_PT (custid INT, Sporttype SMALLINT, Bettype SMALLINT, IsLive BIT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY, IsAutoMPositionTaking BIT, AutoMPositionTaking SMALLMONEY, IsAutoPositionTaking BIT, AutoPositionTaking SMALLMONEY)	
CREATE TABLE #Super_WrongPT (custid INT, Sporttype SMALLINT, Bettype SMALLINT, IsLive BIT)
CREATE TABLE #Tempbatch_PT (custid INT, Sporttype SMALLINT, Bettype SMALLINT, IsLive BIT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY, IsAutoMPositionTaking BIT, AutoMPositionTaking SMALLMONEY, IsAutoPositionTaking BIT, AutoPositionTaking SMALLMONEY, MinPositionTaking SMALLMONEY, MaxPositionTaking SMALLMONEY)
CREATE TABLE #Custlist_Status (custid INT, DisableNumber BIT, HideKeno BIT)
CREATE TABLE #CustList_Status_Batch(custid INT, DisableNumber BIT, HideKeno BIT)


------
CREATE TABLE #SMA_BetLimit(CustID int,SportType smallint,BetType smallint,MinBet money,MaxBet money,MaxPerMatch money)
CREATE TABLE #Member_BetLimit(CustID int,SportType smallint,BetType smallint,MinBet money,MaxBet money,MaxPerMatch money)
CREATE TABLE #Tmpbatch_BetLimit(CustID int,SportType smallint,BetType smallint,MinBet money,MaxBet money,MaxPerMatch money)

CREATE TABLE #SportBetType(fSportType SMALLINT, fBetType SMALLINT, tSportType SMALLINT, tBetType SMALLINT, SettingType TINYINT,GameTypeID INT)
INSERT INTO #SportBetType(fSportType,fBetType,tSportType,tBetType,SettingType,GameTypeID)
--PT
SELECT 161, 85, 161, 81, 1, NULL UNION ALL
SELECT 202, 1501, 202, 1501, 1, NULL UNION ALL
--Bet Setting
SELECT 202, 1501, 202, 1501, 2, 1

----------------------------------------ADJUST PT--------------------------------------------------------------
BEGIN
	--AGENT LEVEL
	--NG
	INSERT INTO #SMAList_PT (custid, Sporttype, Bettype, SPositionTaking, MPositionTaking, APositionTaking, IsAutoMPositionTaking, AutoMPositionTaking
							, IsAutoPositionTaking, AutoPositionTaking, MinPositionTaking, MaxPositionTaking)
	SELECT C.custid, sb.tSportType, sb.tBetType
		,C.slivepositiontaking * 100
		,C.mlivepositiontaking * 100
		,C.alivepositiontaking * 100
		,C.isautolivempositiontaking
		,C.autolivempositiontaking * 100
		,C.isautolivepositiontaking
		,C.autolivepositiontaking * 100
		,o.minlivepositiontaking * 100
		,100 AS MAXPT
	FROM dbo.CustSetting3rd c WITH(NOLOCK) -- OldStructure
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = c.custid
		INNER JOIN #supers s WITH (NOLOCK) ON CI.srecommend = s.custid
		INNER JOIN #SportBetType sb ON c.SportType = sb.fSportType AND c.bettype = sb.fBetType AND sb.SettingType = 1
		INNER JOIN custOverride3rd o WITH(NOLOCK) ON c.custid = o.custid AND c.sporttype = o.sporttype AND c.bettype = o.bettype
		INNER JOIN dbo.CustPTSetting3rd_Agent csa WITH (NOLOCK) -- DCS
			ON C.custid = csa.custid 
			AND csa.SportType = sb.tSportType 
			AND csa.BetType = sb.tBetType
	WHERE ci.roleid IN (2,3,4) AND Enabled = 1
		AND (  C.slivepositiontaking * 100 <> csa.SuperPT
			OR C.mlivepositiontaking * 100  <> csa.MasterPT
			OR C.alivepositiontaking * 100 <> csa.AgentPT
			OR C.isautolivempositiontaking <> csa.IsAutoMasterPT
			OR C.autolivempositiontaking * 100  <> csa.AutoMasterPT
			OR C.isautolivepositiontaking <> csa.IsAutoSuperPT
			OR C.autolivepositiontaking * 100  <> csa.AutoSuperPT
			OR o.minlivepositiontaking * 100  <> csa.MinPT
			OR 100 <> csa.MaxPT
			)
	--Keno
	INSERT INTO #SMAList_PT (custid, Sporttype, Bettype, SPositionTaking, MPositionTaking, APositionTaking, IsAutoMPositionTaking, AutoMPositionTaking
							, IsAutoPositionTaking, AutoPositionTaking, MinPositionTaking, MaxPositionTaking)
	SELECT C.custid, sb.tSportType, sb.tBetType
		,C.spositiontaking * 100
		,C.mpositiontaking * 100
		,C.apositiontaking * 100
		,C.isautompositiontaking
		,C.autompositiontaking * 100
		,C.isautopositiontaking
		,C.autopositiontaking * 100
		,o.minpositiontaking * 100
		,100 AS MAXPT
	FROM dbo.CustSettingGame c WITH(NOLOCK) -- OldStructure
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = c.custid
		INNER JOIN #supers s WITH (NOLOCK) ON CI.srecommend = s.custid
		INNER JOIN #SportBetType sb ON c.SportType = sb.fSportType AND c.bettype = sb.fBetType AND sb.SettingType = 1
		INNER JOIN CustOverrideGame o WITH(NOLOCK) ON c.custid = o.custid AND c.sporttype = o.sporttype AND c.bettype = o.bettype
		INNER JOIN dbo.CustPTSetting3rd_Agent csa WITH (NOLOCK) -- DCS
			ON C.custid = csa.custid 
			AND csa.SportType = sb.tSportType 
			AND csa.BetType = sb.tBetType
	WHERE ci.roleid IN (2,3,4) AND Enabled = 1
		AND (  C.spositiontaking * 100 <> csa.SuperPT
			OR C.mpositiontaking * 100  <> csa.MasterPT
			OR C.apositiontaking * 100 <> csa.AgentPT
			OR C.isautompositiontaking <> csa.IsAutoMasterPT
			OR C.autompositiontaking * 100  <> csa.AutoMasterPT
			OR C.isautopositiontaking <> csa.IsAutoSuperPT
			OR C.autopositiontaking * 100  <> csa.AutoSuperPT
			OR o.minpositiontaking * 100  <> csa.MinPT
			OR 100 <> csa.MaxPT
			)

	--MEMBER LEVEL
	--NG
	INSERT INTO #MemberList_PT (custid, Sporttype, Bettype, SPositionTaking, MPositionTaking, APositionTaking
								, IsAutoMPositionTaking, AutoMPositionTaking, IsAutoPositionTaking, AutoPositionTaking)
	SELECT C.custid, sb.tSportType, sb.tBetType
		,C.slivepositiontaking * 100
		,C.mlivepositiontaking * 100
		,C.alivepositiontaking * 100
		,C.isautolivempositiontaking
		,C.autolivempositiontaking * 100
		,C.isautolivepositiontaking
		,C.autolivepositiontaking * 100
	FROM dbo.CustSetting3rd c WITH(NOLOCK) -- OldStructure
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = c.custid
		INNER JOIN #supers s WITH (NOLOCK) ON CI.srecommend = s.custid
		INNER JOIN #SportBetType sb ON c.SportType = sb.fSportType AND c.bettype = sb.fBetType AND sb.SettingType = 1
		INNER JOIN dbo.CustPTSetting3rd_Member csm WITH (NOLOCK) -- DCS
			ON C.custid = csm.custid 
			AND csm.SportType = sb.tSportType 
			AND csm.BetType = sb.tBetType
	WHERE ci.roleid IN (1) AND Enabled = 1
		AND (  C.slivepositiontaking * 100 <> csm.SuperPT
			OR C.mlivepositiontaking * 100  <> csm.MasterPT
			OR C.alivepositiontaking * 100 <> csm.AgentPT
			OR C.isautolivempositiontaking <> csm.IsAutoMasterPT
			OR C.autolivempositiontaking * 100  <> csm.AutoMasterPT
			OR C.isautolivepositiontaking <> csm.IsAutoSuperPT
			OR C.autolivepositiontaking * 100  <> csm.AutoSuperPT
			)

	--Keno
	INSERT INTO #MemberList_PT (custid, Sporttype, Bettype, SPositionTaking, MPositionTaking, APositionTaking
								, IsAutoMPositionTaking, AutoMPositionTaking, IsAutoPositionTaking, AutoPositionTaking)
	SELECT C.custid, sb.tSportType, sb.tBetType
		,C.spositiontaking * 100
		,C.mpositiontaking * 100
		,C.apositiontaking * 100
		,C.isautompositiontaking
		,C.autompositiontaking * 100
		,C.isautopositiontaking
		,C.autopositiontaking * 100
	FROM dbo.CustSettingGame c WITH(NOLOCK) -- OldStructure
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = c.custid
		INNER JOIN #supers s WITH (NOLOCK) ON CI.srecommend = s.custid
		INNER JOIN #SportBetType sb ON c.SportType = sb.fSportType AND c.bettype = sb.fBetType AND sb.SettingType = 1
		INNER JOIN dbo.CustPTSetting3rd_Member csm WITH (NOLOCK) -- DCS
			ON C.custid = csm.custid 
			AND csm.SportType = sb.tSportType 
			AND csm.BetType = sb.tBetType
	WHERE ci.roleid IN (1) AND Enabled = 1
		AND (  C.spositiontaking * 100 <> csm.SuperPT
			OR C.mpositiontaking * 100  <> csm.MasterPT
			OR C.apositiontaking * 100 <> csm.AgentPT
			OR C.isautompositiontaking <> csm.IsAutoMasterPT
			OR C.autompositiontaking * 100  <> csm.AutoMasterPT
			OR C.isautopositiontaking <> csm.IsAutoSuperPT
			OR C.autopositiontaking * 100  <> csm.AutoSuperPT
			)

	--Wrong PT
	INSERT INTO #Super_WrongPT (custid, Sporttype, Bettype)
	SELECT csa.custid, csa.SportType, csa.BetType
	FROM dbo.CustPTSetting3rd_Agent csa WITH(NOLOCK)
		INNER JOIN #supers s WITH (NOLOCK) ON s.custid = csa.custid
		INNER JOIN #SportBetType sb ON csa.SportType = sb.tSportType AND csa.bettype = sb.tBetType AND sb.SettingType = 1
	WHERE ( csa.MasterPT > csa.SuperPT
			OR csa.AgentPT > csa.MasterPT
			OR csa.AgentPT > csa.SuperPT
			)

	--Adjust PT
	--Agent
	WHILE 1 = 1
	BEGIN
		DELETE TOP(@BatchSize) t
		OUTPUT deleted.custid,deleted.SportType,deleted.BetType,deleted.SPositionTaking,deleted.MPositionTaking,deleted.APositionTaking,
						deleted.isautompositiontaking,deleted.autompositiontaking,deleted.isautopositiontaking,deleted.autopositiontaking,
						deleted.MinPositionTaking,deleted.MaxPositionTaking
		INTO #Tempbatch_PT(custid,SportType,BetType,SPositionTaking,MPositionTaking,APositionTaking,isautompositiontaking,autompositiontaking,
							isautopositiontaking,autopositiontaking,MinPositionTaking,MaxPositionTaking)
		FROM #SMAList_PT t

		IF @@ROWCOUNT = 0
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
			INNER JOIN #Tempbatch_PT C WITH(NOLOCK) 
				ON csa.custid = C.custid 
				AND csa.SportType = c.Sporttype 
				AND csa.BetType = c.Bettype

		TRUNCATE TABLE #Tempbatch_PT
	END

	--Member
	WHILE 1 = 1
	BEGIN
		DELETE TOP(@BatchSize) t
		OUTPUT deleted.custid,deleted.SportType,deleted.BetType,deleted.SPositionTaking,deleted.MPositionTaking,deleted.APositionTaking,
						deleted.isautompositiontaking,deleted.autompositiontaking,deleted.isautopositiontaking,deleted.autopositiontaking
		INTO #Tempbatch_PT(custid,SportType,BetType,SPositionTaking,MPositionTaking,APositionTaking,isautompositiontaking,autompositiontaking,
							isautopositiontaking,autopositiontaking)
		FROM #MemberList_PT t

		IF @@ROWCOUNT = 0
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
			INNER JOIN #Tempbatch_PT C WITH (NOLOCK) 
				ON C.custid = csm.custid 
				AND csm.SportType = c.Sporttype 
				AND csm.BetType = c.Bettype

		TRUNCATE TABLE #Tempbatch_PT
	END

	DECLARE @MasterPT SMALLMONEY
	--Adjust m4 = s4 if m4 > s4; a4 = new_m4 if a4 > new_m4
	UPDATE csa
	SET	@MasterPT = CASE WHEN csa.MasterPT > csa.SuperPT THEN csa.SuperPT ELSE csa.MasterPT END,
		csa.MasterPT = @MasterPT,
		csa.AgentPT = CASE	WHEN csa.AgentPT > @MasterPT THEN @MasterPT ELSE csa.AgentPT END
	FROM dbo.CustPTSetting3rd_Agent csa WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #Super_WrongPT cs WITH(NOLOCK) ON csa.custid = cs.custid AND csa.SportType = cs.Sporttype AND csa.BetType = cs.Bettype
END
----------------------------------------ADJUST Bet Setting--------------------------------------------------------------
BEGIN
	INSERT INTO #SMA_BetLimit(CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch)
	SELECT c.custid
		,sb.tSportType
		,sb.tBetType
		,c.MinBet
		,c.MaxBet
		,c.MaxPerGameType
	FROM dbo.CustGameType C WITH(NOLOCK) 
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = c.custid
		INNER JOIN #supers s WITH (NOLOCK) ON CI.srecommend = s.custid
		INNER JOIN #SportBetType sb ON c.GameTypeID = sb.GameTypeID AND sb.SettingType = 2
		INNER JOIN dbo.CustBetSetting3rd_Agent csa WITH (NOLOCK) -- DCS
			ON C.custid = csa.custid 
			AND csa.SportType = sb.tSportType 
			AND csa.BetType = sb.tBetType
	WHERE ci.roleid IN (2,3,4) AND Enabled = 1
		AND (  C.MinBet <> csa.MinBet
			OR C.MaxBet <> csa.MaxBet
			OR C.MaxPerGameType <> csa.MaxPerMatch
			)

	INSERT INTO #Member_BetLimit(CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch)
	SELECT c.custid
		,sb.tSportType
		,sb.tBetType
		,c.MinBet
		,c.MaxBet
		,c.MaxPerGameType
	FROM dbo.CustGameType C WITH(NOLOCK) 
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = c.custid
		INNER JOIN #supers s WITH (NOLOCK) ON CI.srecommend = s.custid
		INNER JOIN #SportBetType sb ON c.GameTypeID = sb.GameTypeID AND sb.SettingType = 2
		INNER JOIN dbo.CustBetSetting3rd_Member csa WITH (NOLOCK) -- DCS
			ON C.custid = csa.custid 
			AND csa.SportType = sb.tSportType 
			AND csa.BetType = sb.tBetType
	WHERE ci.roleid IN (1) AND Enabled = 1
		AND (  C.MinBet <> csa.MinBet
			OR C.MaxBet <> csa.MaxBet
			OR C.MaxPerGameType <> csa.MaxPerMatch
			)

	--Adjust Bet Setting 
	--Agent
	WHILE 1 = 1
	BEGIN
		DELETE TOP(@BatchSize) t
		OUTPUT deleted.custid,deleted.SportType,deleted.BetType,deleted.MinBet,deleted.MaxBet,deleted.MaxPerMatch
		INTO #Tmpbatch_BetLimit(custid,SportType,BetType,MinBet,MaxBet,MaxPerMatch)
		FROM #SMA_BetLimit t

		IF @@ROWCOUNT = 0
			BREAK

		UPDATE cs
		SET cs.MinBet = ci.MinBet,
			cs.MaxBet = ci.MaxBet,
			cs.MaxPerMatch = ci.MaxPerMatch
		FROM [dbo].CustBetSetting3rd_Agent cs WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #Tmpbatch_BetLimit ci 
				ON cs.CustID = ci.CustID 
				AND cs.SportType = ci.SportType 
				AND cs.BetType = ci.BetType

		TRUNCATE TABLE #Tmpbatch_BetLimit
	END

	--Member
	WHILE 1 = 1
	BEGIN
		DELETE TOP(@BatchSize) t
		OUTPUT deleted.custid,deleted.SportType,deleted.BetType,deleted.MinBet,deleted.MaxBet,deleted.MaxPerMatch
		INTO #Tmpbatch_BetLimit(custid,SportType,BetType,MinBet,MaxBet,MaxPerMatch)
		FROM #Member_BetLimit t

		IF @@ROWCOUNT = 0
			BREAK

		UPDATE cs
		SET cs.MinBet = ci.MinBet,
			cs.MaxBet = ci.MaxBet,
			cs.MaxPerMatch = ci.MaxPerMatch
		FROM [dbo].CustBetSetting3rd_Member cs WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #Tmpbatch_BetLimit ci 
				ON cs.CustID = ci.CustID 
				AND cs.SportType = ci.SportType 
				AND cs.BetType = ci.BetType

		TRUNCATE TABLE #Tmpbatch_BetLimit
	END

----------------------------------------ADJUST Status--------------------------------------------------------------
BEGIN
	DECLARE @BitmapOrder_NG TINYINT = 41
	DECLARE @BitmapOrder_KN TINYINT = 40

	INSERT INTO #Custlist_Status(custid,DisableNumber,HideKeno)
	SELECT c.CustID,ci.DisableNumber,ci.HideKeno
	FROM dbo.CustProductStatus C WITH(NOLOCK)
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(C.bitmapIsDisabled, @BitmapOrder_NG) as isDisabledNG
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(C.bitmapIsHidden, @BitmapOrder_NG) as isHiddenNG
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(C.bitmapHasSynced, @BitmapOrder_NG) as SyncNG
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(C.bitmapIsDisabled, @BitmapOrder_KN) as isDisabledKN
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(C.bitmapIsHidden, @BitmapOrder_KN) as isHiddenKN
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(C.bitmapHasSynced, @BitmapOrder_KN) as SyncKN
		INNER JOIN custInfo ci WITH(NOLOCK) ON C.CustID = ci.custid
		INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
	WHERE ci.roleid IN (1,2,3,4) AND Enabled = 1
		AND (isDisabledNG.value <> ci.DisableNumber 
			OR isHiddenNG.value <> 0
			OR SyncNG.value <> 1
			OR isDisabledKN.value <> 0
			OR isHiddenKN.value <> ci.HideKeno
			OR SyncKN.value <> 1
			)

	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #CustList_Status_Batch

		DELETE TOP(@BatchSize) t
		OUTPUT deleted.custid,deleted.DisableNumber,deleted.HideKeno INTO #CustList_Status_Batch(custid,DisableNumber,HideKeno)
		FROM #Custlist_Status t

		IF @@ROWCOUNT = 0
			BREAK

		UPDATE cs
		SET bitmapIsDisabled = dis.NewBitmap
			, bitmapIsHidden = hid.NewBitmap
			, bitmapHasSynced = sync.NewBitmap
		FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustList_Status_Batch ci WITH(NOLOCK) ON cs.CustID = ci.CustID
			CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapHasSynced,@BitmapOrder_NG,1) as sync
			CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder_NG,ci.DisableNumber) as Dis
			CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder_NG,0) as Hid

		--Enable Keno by default, will disable on step adjust if yes
		UPDATE cs
		SET bitmapIsDisabled = dis.NewBitmap
			,bitmapIsHidden = hid.NewBitmap
			,bitmapHasSynced = sync.NewBitmap
		FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustList_Status_Batch ci WITH(NOLOCK) ON cs.CustID = ci.CustID
			CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapHasSynced,@BitmapOrder_KN,1) as sync
			CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder_KN,ci.HideKeno) as Dis
			CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder_KN,ci.HideKeno) as Hid
	END
END


END
DROP TABLE #MemberList_PT
DROP TABLE #SMAList_PT
DROP TABLE #SportBetType
DROP TABLE #Super_WrongPT
DROP TABLE #supers
DROP TABLE #Member_BetLimit
DROP TABLE #SMA_BetLimit
DROP TABLE #Tmpbatch_BetLimit
DROP TABLE #Tempbatch_PT
DROP TABLE #Custlist_Status
DROP TABLE #CustList_Status_Batch