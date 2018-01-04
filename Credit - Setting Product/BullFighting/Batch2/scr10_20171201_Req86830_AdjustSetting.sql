/*
	Created: Elodie
	Task: Adjust Setting for BullFighting
	DB: DBCUST/CustDB
	Date: 20171201
*/ 
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09] 
AS

BEGIN
	
	SET NOCOUNT ON

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
		AND ci.site IN ('733333', '222223', '222225', '222227', '033333', 'JPNIBC', '611111', '722222', '766666', '7aa666', 'BEST-ODDS', 'XYZbet', '755555', '789y')
		AND ci.currency <> 20	
		AND ci.custid NOT IN (1,2,3,4,5,6,9,12,13,15,16,17,22,30,32,33,34,35,36,41,42,21278849,21278858) -- dummy account	

	DECLARE @msgDone NVARCHAR(200) = 'Done for sporttype %d, bettype %d.'

	CREATE TABLE #SMAList_PT (custid INT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY, IsAutoMPositionTaking BIT, AutoMPositionTaking SMALLMONEY, IsAutoPositionTaking BIT, AutoPositionTaking SMALLMONEY, MinPositionTaking SMALLMONEY)
	CREATE TABLE #MemberList_PT (custid INT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY, IsAutoMPositionTaking BIT, AutoMPositionTaking SMALLMONEY, IsAutoPositionTaking BIT, AutoPositionTaking SMALLMONEY)	
	CREATE TABLE #Super_WrongPT (custid INT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY)

	CREATE TABLE #SMAList_CommSetting (custid INT, Discount DECIMAL(9,8))
	CREATE TABLE #MemberList_CommSetting (custid INT, SuperDiscount DECIMAL(9,8), MasterDiscount DECIMAL(9,8), AgentDiscount DECIMAL(9,8), PlayerDiscount DECIMAL(9,8))

	DECLARE @ProductID TINYINT = 30
	DECLARE @fSportType SMALLINT, @fBetType SMALLINT, @tSportType SMALLINT, @tBetType SMALLINT, @IsLive BIT
	
	CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT, IsFinished BIT)
	INSERT INTO #DestinationSportBetType(fSportType, fBetType,tSportType, tBetType, IsLive,  SettingType, IsFinished)
	SELECT	1, 5, SportType, BetType, 0, SettingType, 0
	FROM dbo.ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SettingType IN (1,3,6,16)

	--------------------------------------PT Setting-------------------------------------------------	
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType, @tSportType = tSportType, @tBetType = tBetType
	FROM #DestinationSportBetType		
	WHERE SettingType = 1

	--AGENT LEVEL
	INSERT INTO #SMAList_PT (custid, SPositionTaking, MPositionTaking, APositionTaking, IsAutoMPositionTaking, AutoMPositionTaking, IsAutoPositionTaking, AutoPositionTaking, MinPositionTaking)
	SELECT ci.custid, SPositionTaking, MPositionTaking, APositionTaking, IsAutoMPositionTaking, AutoMPositionTaking, IsAutoPositionTaking, AutoPositionTaking, MinPositionTaking
	FROM dbo.custSetting cs WITH(NOLOCK) 
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cs.custid
		INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
		INNER JOIN dbo.CustOverride co WITH(NOLOCK) ON cs.custid = co.custid and cs.sporttype = co.sporttype and cs.bettype = co.bettype	
		INNER JOIN dbo.CustPTSetting3rd_Agent csa WITH(NOLOCK) ON csa.custid = cs.custid 
	WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType AND csa.SportType = @tSportType AND csa.BetType = @tBetType
			AND ci.roleid IN (2,3,4) AND Enabled = 1
			AND (
				cs.SPositionTaking * 100 <> csa.SuperPT
				OR cs.MPositionTaking * 100 <> csa.MasterPT
				OR cs.APositionTaking * 100 <> csa.AgentPT
				OR cs.IsAutoMPositionTaking <> csa.IsAutoMasterPT
				OR cs.AutoMPositionTaking * 100 <> csa.AutoMasterPT
				OR cs.IsAutoPositionTaking <> csa.IsAutoSuperPT
				OR cs.AutoPositionTaking * 100 <> csa.AutoSuperPT
				OR (ci.roleid <> 4 AND co.MinPositionTaking  * 100 <> csa.MinPT)
				)

	--MEMBER LEVEL
	INSERT INTO #MemberList_PT (custid, SPositionTaking, MPositionTaking, APositionTaking, IsAutoMPositionTaking, AutoMPositionTaking, IsAutoPositionTaking, AutoPositionTaking)
	SELECT ci.custid, SPositionTaking, MPositionTaking, APositionTaking, IsAutoMPositionTaking, AutoMPositionTaking, IsAutoPositionTaking, AutoPositionTaking
	FROM dbo.custSetting cs WITH(NOLOCK)
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cs.custid
		INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
		INNER JOIN dbo.CustPTSetting3rd_Member csm WITH(NOLOCK) ON csm.custid = cs.custid 
	WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType AND csm.SportType = @tSportType AND csm.BetType = @tBetType
			AND ci.roleid = 1 AND Enabled = 1
			AND (
				cs.SPositionTaking  * 100 <> csm.SuperPT
				OR cs.MPositionTaking  * 100 <> csm.MasterPT
				OR cs.APositionTaking  * 100 <> csm.AgentPT
				OR cs.IsAutoMPositionTaking <> csm.IsAutoMasterPT
				OR cs.AutoMPositionTaking * 100 <> csm.AutoMasterPT
				OR cs.IsAutoPositionTaking <> csm.IsAutoSuperPT
				OR cs.AutoPositionTaking  * 100 <> csm.AutoSuperPT
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
		SET	csa.SuperPT = cs.spositiontaking  *100
			,csa.MasterPT =  cs.mpositiontaking  *100
			,csa.AgentPT = cs.apositiontaking  *100
			,csa.IsAutoMasterPT = cs.isautompositiontaking
			,csa.AutoMasterPT = cs.autompositiontaking *100
			,csa.IsAutoSuperPT = cs.isautopositiontaking 
			,csa.AutoSuperPT = cs.autopositiontaking  *100
			,csa.MinPT = cs.minpositiontaking *100
		FROM dbo.CustPTSetting3rd_Agent csa WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #SMAList_PT cs WITH(NOLOCK) ON csa.custid = cs.custid
		WHERE csa.SportType = @tSportType AND csa.BetType = @tBetType
	
		UPDATE csm
		SET	csm.SuperPT = cs.spositiontaking  *100
			,csm.MasterPT =  cs.mpositiontaking  *100
			,csm.AgentPT = cs.apositiontaking  *100
			,csm.IsAutoMasterPT = cs.isautompositiontaking
			,csm.AutoMasterPT = cs.autompositiontaking *100
			,csm.IsAutoSuperPT = cs.isautopositiontaking 
			,csm.AutoSuperPT = cs.autopositiontaking  *100
		FROM dbo.CustPTSetting3rd_Member csm WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #MemberList_PT cs WITH (NOLOCK) ON cs.custid = csm.custid
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
	SELECT cs.custid, 
			CASE	WHEN roleid = 4 THEN cs.sdiscount
					WHEN roleid = 3 THEN cs.adiscount
					WHEN roleid = 2 THEN cs.discount END
	FROM dbo.custSetting cs WITH(NOLOCK)
		INNER JOIN custInfo c WITH(NOLOCK) ON cs.CustID = c.custid
		INNER JOIN #supers s WITH (NOLOCK) ON c.srecommend = s.custid
		INNER JOIN dbo.CustDiscount3rd_Agent csa WITH(NOLOCK) ON csa.custid = cs.custid
	WHERE cs.sporttype = @fSportType AND cs.bettype = @fBetType AND csa.SportType = @tSportType AND csa.BetType = @tBetType
			AND c.roleid IN (2,3,4) AND Enabled = 1
			AND (CASE	WHEN roleid = 4 THEN cs.sdiscount
						WHEN roleid = 3 THEN cs.adiscount
						WHEN roleid = 2 THEN cs.discount END <> csa.Discount)

	--Member Level
	INSERT INTO #MemberList_CommSetting (custid, SuperDiscount, MasterDiscount, AgentDiscount, PlayerDiscount)
	SELECT cs.custid, cs.sdiscount, cs.adiscount, cs.discount, cs.playerdiscount
	FROM dbo.custSetting cs WITH(NOLOCK)
		INNER JOIN custInfo c WITH(NOLOCK) ON cs.CustID = c.custid
		INNER JOIN #supers s WITH (NOLOCK) ON c.srecommend = s.custid
		INNER JOIN dbo.CustDiscount3rd_Member csm WITH(NOLOCK) ON csm.custid = cs.custid
	WHERE cs.sporttype = @fSportType AND cs.bettype = @fBetType AND csm.SportType = @tSportType AND csm.BetType = @tBetType
			AND c.roleid = 1 AND Enabled = 1
			AND (
				cs.sdiscount <> csm.SuperDiscount
				OR cs.adiscount <> csm.MasterDiscount
				OR cs.discount <> csm.AgentDiscount			
				OR cs.playerdiscount <> csm.PlayerDiscount
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