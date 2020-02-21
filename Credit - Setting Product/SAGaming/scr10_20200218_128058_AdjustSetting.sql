/*
	Created: 20200218@Tiara
	Date: 20200218
	Task: Adjust Setting for SA Gaming [Redmine: #128128]
	DB: DBCUST/CustDB
*/ 
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09] 
AS

BEGIN
	
	SET NOCOUNT ON

	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN	

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
		AND ci.currency NOT IN (45,13,75,76,77) --Won (KRW), RMB, PTU, PS, PTH

	DECLARE @msgDone NVARCHAR(200) = 'Done for sporttype %d, bettype %d.'

	CREATE TABLE #SMAList_PT (custid INT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY, IsAutoMPositionTaking BIT, AutoMPositionTaking SMALLMONEY, IsAutoPositionTaking BIT, AutoPositionTaking SMALLMONEY, MinPositionTaking SMALLMONEY)
	CREATE TABLE #MemberList_PT (custid INT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY, IsAutoMPositionTaking BIT, AutoMPositionTaking SMALLMONEY, IsAutoPositionTaking BIT, AutoPositionTaking SMALLMONEY)	
	CREATE TABLE #Super_WrongPT (custid INT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY)

	CREATE TABLE #SMAList_CommSetting (custid INT, Discount DECIMAL(9,8))
	CREATE TABLE #MemberList_CommSetting (custid INT, SuperDiscount DECIMAL(9,8), MasterDiscount DECIMAL(9,8), AgentDiscount DECIMAL(9,8), PlayerDiscount DECIMAL(9,8))

	DECLARE @ProductID TINYINT = 41
	DECLARE @fSportType SMALLINT, @fBetType SMALLINT, @tSportType SMALLINT, @tBetType SMALLINT, @IsLive BIT
	
	CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT, IsFinished BIT)
	INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
	SELECT	211, 2401, SportType, BetType, 0, SettingType, 0
	FROM dbo.ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SettingType IN (1,3,6) --PT, Comm, WinLossLimit

	--------------------------------------PT Setting-------------------------------------------------	
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType, @tSportType = tSportType, @tBetType = tBetType
	FROM #DestinationSportBetType		
	WHERE SettingType = 1

	--AGENT LEVEL
	INSERT INTO #SMAList_PT (custid, SPositionTaking, MPositionTaking, APositionTaking, IsAutoMPositionTaking, AutoMPositionTaking, IsAutoPositionTaking, AutoPositionTaking, MinPositionTaking)
	SELECT C.custid, C.SuperPT, C.MasterPT, C.AgentPT, C.IsAutoMasterPT, C.AutoMasterPT, C.IsAutoSuperPT, C.AutoSuperPT, C.MinPT
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
			AND SettingType = 1

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
	WHERE SettingType = 3

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
			AND SettingType = 3

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

	DROP TABLE #DestinationSportBetType			
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
PRINT N'Step 10: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

EXEC dbo.Acc_DynamicCustSetting3rd_09 

PRINT N'Step 10: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'
