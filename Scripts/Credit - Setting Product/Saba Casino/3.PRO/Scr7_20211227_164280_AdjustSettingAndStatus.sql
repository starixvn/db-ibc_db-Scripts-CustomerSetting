/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211227@Eden
	Task: Adjust Setting - Saba Casino [#164280]
	DB: DBCUST/CustDB
*/
USE CustDB
GO
DECLARE @Sporttype      INT          = 208, 
		@Bettype        INT          = 2101, 
		@fSportType     SMALLINT = 212, 
		@fBetType       SMALLINT = 4001, 
		@BatchNum		INT = 5000,
		@BitmapOrder	TINYINT = 37

CREATE TABLE #SMAList_PT (custid INT, Sporttype SMALLINT, Bettype SMALLINT, IsLive BIT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY, IsAutoMPositionTaking BIT, AutoMPositionTaking SMALLMONEY, IsAutoPositionTaking BIT, AutoPositionTaking SMALLMONEY, MinPositionTaking SMALLMONEY, MaxPositionTaking SMALLMONEY)
CREATE TABLE #MemberList_PT (custid INT, Sporttype SMALLINT, Bettype SMALLINT, IsLive BIT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY, IsAutoMPositionTaking BIT, AutoMPositionTaking SMALLMONEY, IsAutoPositionTaking BIT, AutoPositionTaking SMALLMONEY)	
CREATE TABLE #Super_WrongPT (custid INT, Sporttype SMALLINT, Bettype SMALLINT, IsLive BIT)
CREATE TABLE #AgentGroupPT (AgentID INT, Sporttype SMALLINT, Bettype SMALLINT, IsLive BIT, SuperPT TINYINT, MasterPT TINYINT, AgentPT TINYINT, IsAutoMasterPT BIT, AutoMasterPT TINYINT, IsAutoSuperPT BIT, AutoSuperPT TINYINT)
CREATE TABLE #SMAList_WL (custid INT, Sporttype SMALLINT, Bettype SMALLINT, MaxWinLimit MONEY, MaxLossLimit MONEY, IsAutoReset BIT)
CREATE TABLE #MemberList_WL(custid INT, Sporttype SMALLINT, Bettype SMALLINT, MaxWinLimit MONEY,MaxLossLimit MONEY, IsAutoReset BIT)
CREATE TABLE #Custlist_Status (custid INT, IsDisabled BIT)
CREATE TABLE #CustList_Status_Batch(custid INT, IsDisabled BIT)
CREATE TABLE #supers (custid int,isfinished bit default(0))

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
	AND ci.currency IN (
				 2	-- 	RM
				,3	-- 	US$
				,13	-- 	RMB
				,15	-- 	IN
				,16	-- 	Yen
				,22	-- 	IND
				,33	-- 	IDD
				,34	-- 	IDR
				,35	-- 	$US
				,43	-- 	THB
				,47	-- 	DDD
				,10	-- 	INR1
				,64	-- 	UT
				,69	-- 	MMK
				)
----------------------------------------ADJUST PT--------------------------------------------------------------
BEGIN
	--AGENT LEVEL
	INSERT INTO #SMAList_PT (custid, Sporttype, Bettype, SPositionTaking, MPositionTaking, APositionTaking, IsAutoMPositionTaking, AutoMPositionTaking
							, IsAutoPositionTaking, AutoPositionTaking, MinPositionTaking, MaxPositionTaking)
	SELECT C.custid, @SportType, @BetType, C.SuperPT, C.MasterPT, C.AgentPT, C.IsAutoMasterPT, C.AutoMasterPT
			, C.IsAutoSuperPT, C.AutoSuperPT, C.MinPT, C.MaxPT
	FROM dbo.CustPTSetting3rd_Agent c WITH(NOLOCK) -- Macau Games
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = c.custid
		INNER JOIN #supers s WITH (NOLOCK) ON CI.srecommend = s.custid
		INNER JOIN dbo.CustPTSetting3rd_Agent csa WITH (NOLOCK) -- Saba Casino
			ON C.custid = csa.custid 
			AND csa.SportType = @SportType 
			AND csa.BetType = @BetType
		WHERE ci.roleid IN (2,3,4) AND Enabled = 1
			AND (  C.SuperPT <> csa.SuperPT
				OR C.MasterPT  <> csa.MasterPT
				OR C.AgentPT <> csa.AgentPT
				OR C.IsAutoMasterPT <> csa.IsAutoMasterPT
				OR C.AutoMasterPT  <> csa.AutoMasterPT
				OR C.IsAutoSuperPT <> csa.IsAutoSuperPT
				OR C.AutoSuperPT  <> csa.AutoSuperPT
				OR C.MinPT  <> csa.MinPT
				OR C.MaxPT <> csa.MaxPT
				)
			AND c.SportType = @fSportType 
			AND c.BetType = @fBetType

	--MEMBER LEVEL
	INSERT INTO #MemberList_PT (custid, Sporttype, Bettype, SPositionTaking, MPositionTaking, APositionTaking
								, IsAutoMPositionTaking, AutoMPositionTaking, IsAutoPositionTaking, AutoPositionTaking)
	SELECT C.custid, @Sporttype, @Bettype, C.SuperPT, C.MasterPT, C.AgentPT
		, C.IsAutoMasterPT, C.AutoMasterPT, C.IsAutoSuperPT, C.AutoSuperPT
	FROM dbo.CustPTSetting3rd_Member C WITH(NOLOCK)
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = C.custid
		INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
		INNER JOIN dbo.CustPTSetting3rd_Member csm WITH(NOLOCK) -- Saba Casino
			ON C.custid = csm.custid 
			AND csm.SportType = @SportType 
			AND csm.BetType = @BetType
	WHERE ci.roleid = 1 AND Enabled = 1
		AND (  C.SuperPT <> csm.SuperPT
			OR C.MasterPT <> csm.MasterPT
			OR C.AgentPT<> csm.AgentPT
			OR C.IsAutoMasterPT <> csm.IsAutoMasterPT
			OR C.AutoMasterPT  <> csm.AutoMasterPT
			OR C.IsAutoSuperPT <> csm.IsAutoSuperPT
			OR C.AutoSuperPT <> csm.AutoSuperPT
			)
		AND c.SportType = @fSportType 
		AND c.BetType = @fBetType
	
	--Group PT
	INSERT INTO #AgentGroupPT (AgentID, Sporttype, Bettype, IsLive, SuperPT, MasterPT, AgentPT
								, IsAutoMasterPT, AutoMasterPT, IsAutoSuperPT, AutoSuperPT)
	SELECT C.AgentID, @SportType, @BetType, C.IsLive, C.SuperPT, C.MasterPT, C.AgentPT
		, C.IsAutoMasterPT, C.AutoMasterPT, C.IsAutoSuperPT, C.AutoSuperPT
	FROM dbo.CustPTGroupSetting3rd_Member C WITH (NOLOCK)
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = C.AgentID
		INNER JOIN #supers s WITH (NOLOCK) ON CI.srecommend = S.custid
		INNER JOIN dbo.CustPTGroupSetting3rd_Member csa WITH (NOLOCK) -- Saba Casino
			ON C.AgentID = csa.AgentID 
			AND csa.SportType = @SportType 
			AND csa.BetType = @BetType
	WHERE ci.roleid IN (2) AND Enabled = 1
		AND(   C.SuperPT		<> csa.SuperPT				
			OR C.MasterPT		<> csa.MasterPT	
			OR C.AgentPT		<> csa.AgentPT
			OR C.IsAutoMasterPT	<> csa.IsAutoMasterPT
			OR C.AutoMasterPT	<> csa.AutoMasterPT
			OR C.IsAutoSuperPT	<> csa.IsAutoSuperPT
			OR C.AutoSuperPT	<> csa.AutoSuperPT
			)
		AND c.SportType = @fSportType 
		AND c.BetType = @fBetType

	--Wrong PT
	INSERT INTO #Super_WrongPT (custid, Sporttype, Bettype)
	SELECT csa.custid, @SportType, @BetType
	FROM dbo.CustPTSetting3rd_Agent csa WITH(NOLOCK)
		INNER JOIN #supers s WITH (NOLOCK) ON s.custid = csa.custid
	WHERE ( csa.MasterPT > csa.SuperPT
			OR csa.AgentPT > csa.MasterPT
			OR csa.AgentPT > csa.SuperPT
			)
		AND csa.SportType = @SportType 
		AND csa.BetType = @BetType

	--Adjust data
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
		INNER JOIN #SMAList_PT C WITH(NOLOCK) ON csa.custid = C.custid AND csa.SportType = c.Sporttype AND csa.BetType = c.Bettype
	
	UPDATE csm
	SET	csm.SuperPT = C.spositiontaking 
		,csm.MasterPT =  C.mpositiontaking 
		,csm.AgentPT = C.apositiontaking
		,csm.IsAutoMasterPT = C.isautompositiontaking
		,csm.AutoMasterPT = C.autompositiontaking
		,csm.IsAutoSuperPT = C.isautopositiontaking 
		,csm.AutoSuperPT = C.autopositiontaking
	FROM dbo.CustPTSetting3rd_Member csm WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #MemberList_PT C WITH (NOLOCK) ON C.custid = csm.custid AND csm.SportType = c.Sporttype AND csm.BetType = c.Bettype

	UPDATE CSA
	SET CSA.SuperPT		= C.SuperPT		
		,CSA.MasterPT		= C.MasterPT	
		,CSA.AgentPT			= C.AgentPT
		,CSA.IsAutoMasterPT	= C.IsAutoMasterPT
		,CSA.AutoMasterPT	= C.AutoMasterPT
		,CSA.IsAutoSuperPT	= C.IsAutoSuperPT
		,CSA.AutoSuperPT		= C.AutoSuperPT
	FROM CustPTGroupSetting3rd_Member CSA WITH (UPDLOCK,ROWLOCK)
		INNER JOIN #AgentGroupPT C WITH (NOLOCK) ON CSA.AgentID = C.AgentID AND csa.SportType = c.Sporttype AND csa.BetType = c.Bettype
		
	DECLARE @MasterPT SMALLMONEY
	--Adjust m4 = s4 if m4 > s4; a4 = new_m4 if a4 > new_m4
	UPDATE csa
	SET	@MasterPT = CASE WHEN csa.MasterPT > csa.SuperPT THEN csa.SuperPT ELSE csa.MasterPT END,
		csa.MasterPT = @MasterPT,
		csa.AgentPT = CASE	WHEN csa.AgentPT > @MasterPT THEN @MasterPT ELSE csa.AgentPT END
	FROM dbo.CustPTSetting3rd_Agent csa WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #Super_WrongPT cs WITH(NOLOCK) ON csa.custid = cs.custid AND csa.SportType = cs.Sporttype AND csa.BetType = cs.Bettype
END

----------------------------------------ADJUST Winloss limit--------------------------------------------------------------
BEGIN
	--Agent Level
	INSERT INTO #SMAList_WL (CustId, Sporttype, Bettype, MaxWinLimit, MaxLossLimit, IsAutoReset)
	SELECT ci.custid, @SportType, @BetType, c.MaxWinLimit, c.MaxLossLimit, C.IsAutoReset
	FROM dbo.CustWinLimit C WITH(NOLOCK) 
		INNER JOIN custInfo ci WITH(NOLOCK) ON C.CustID = ci.custid
		INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
		INNER JOIN dbo.CustWinLossLimit_Agent csa WITH(NOLOCK)-- Saba Casino
			ON C.custid = csa.custid 
			AND csa.SportType = c.SportType 
			AND csa.BetType = c.BetType
	WHERE ci.roleid IN (2,3,4) AND Enabled = 1
		AND (C.MaxLossLimit <> csa.MaxLossLimit
			OR (C.MaxWinLimit <> csa.MaxWinLimit)
			OR C.IsAutoReset <> csa.IsAutoReset
			)
		AND c.SportType = @SportType 
		AND c.BetType = @BetType

	--Member Level
	INSERT INTO #MemberList_WL (CustId, Sporttype, Bettype, MaxWinLimit, MaxLossLimit, IsAutoReset)
	SELECT ci.custid, @SportType, @BetType, c.MaxWinLimit, c.MaxLossLimit, C.IsAutoReset
	FROM dbo.CustWinLimit C WITH(NOLOCK) 
		INNER JOIN custInfo ci WITH(NOLOCK) ON C.CustID = ci.custid
		INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
		INNER JOIN dbo.CustWinLossLimit_Member csa WITH(NOLOCK)-- Saba Casino
			ON C.custid = csa.custid 
			AND csa.SportType = c.SportType 
			AND csa.BetType = c.BetType
	WHERE ci.roleid = 1 AND Enabled = 1
		AND (C.MaxLossLimit <> csa.MaxLossLimit
			OR (C.MaxWinLimit <> csa.MaxWinLimit)
			OR C.IsAutoReset <> csa.IsAutoReset
			)
		AND c.SportType = @SportType 
		AND c.BetType = @BetType

	UPDATE csa
	SET csa.MaxWinLimit = cs.MaxWinLimiT,csa.MaxLossLimit = cs.MaxLossLimit, csa.IsAutoReset = cs.IsAutoReset     
	FROM dbo.CustWinLossLimit_Agent csa WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #SMAList_WL cs WITH(NOLOCK) ON cs.custid = csa.CustID AND csa.SportType = cs.Sporttype AND csa.BetType = cs.Bettype

	UPDATE csm
	SET csm.MaxWinLimit = cs.MaxWinLimit,csm.MaxLossLimit = cs.MaxLossLimit, csm.IsAutoReset = cs.IsAutoReset
	FROM dbo.CustWinLossLimit_Member csm WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #MemberList_WL cs WITH(NOLOCK) ON cs.custid = csm.CustID AND csm.SportType = cs.Sporttype AND csm.BetType = cs.Bettype
END	

----------------------------------------ADJUST Status--------------------------------------------------------------
BEGIN
	INSERT INTO #Custlist_Status(custid,IsDisabled)
	SELECT c.CustID,ci.DisableCasino
	FROM dbo.CustProductStatus C WITH(NOLOCK)
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(C.bitmapIsDisabled, @BitmapOrder) as isDisabled
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(C.bitmapIsHidden, @BitmapOrder) as isHidden
		INNER JOIN custInfo ci WITH(NOLOCK) ON C.CustID = ci.custid
		INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
	WHERE ci.roleid IN (1,2,3,4) AND Enabled = 1
		AND (isDisabled.value <> ci.DisableCasino OR isHidden.value <> 0)

	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #CustList_Status_Batch

		DELETE TOP(@BatchNum) t
		OUTPUT deleted.custid,deleted.IsDisabled INTO #CustList_Status_Batch(custid,IsDisabled)
		FROM #Custlist_Status t

		IF @@ROWCOUNT = 0
			BREAK

		UPDATE cs
		SET cs.bitmapIsHidden = hid.NewBitmap,
			bitmapIsDisabled = dis.NewBitmap
		FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustList_Status_Batch ci ON cs.CustID = ci.CustID
			CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitMapOrder,0) as Hid
			CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitMapOrder,ci.IsDisabled) as Dis
	END
END
/*
DROP TABLE #AgentGroupPT
DROP TABLE #Custlist_Status
DROP TABLE #CustList_Status_Batch
DROP TABLE #MemberList_PT
DROP TABLE #MemberList_WL
DROP TABLE #SMAList_PT
DROP TABLE #SMAList_WL
DROP TABLE #Super_WrongPT
DROP TABLE #supers
*/