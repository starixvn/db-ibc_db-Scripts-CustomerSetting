/*
	Created: Elodie
	Task: Adjust Setting for Lottery
	DB: DBCUST/CustDB
	Date: 20170801
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
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN	

	DECLARE @msgDone NVARCHAR(200) = 'Done for sporttype %d, bettype %d.'
	CREATE TABLE #supers (custid int)
	CREATE TABLE #OfferedSite (site VARCHAR(10))
	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		roleid TINYINT
	)
	CREATE TABLE #DirectMaster (CustID INT PRIMARY KEY,roleid TINYINT)
	CREATE TABLE #DirectAgent (CustID INT PRIMARY KEY,mrecommend INT,roleid TINYINT)
	CREATE TABLE #DirectMember (CustID INT PRIMARY KEY,recommend INT,mrecommend INT,roleid TINYINT)	
	CREATE TABLE #SMAList_PT (custid INT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY, IsAutoMPositionTaking BIT, AutoMPositionTaking SMALLMONEY, IsAutoPositionTaking BIT, AutoPositionTaking SMALLMONEY, MinPositionTaking SMALLMONEY)
	CREATE TABLE #MemberList_PT (custid INT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY, IsAutoMPositionTaking BIT, AutoMPositionTaking SMALLMONEY, IsAutoPositionTaking BIT, AutoPositionTaking SMALLMONEY)	
	CREATE TABLE #Super_WrongPT (custid INT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY)

	CREATE TABLE #SMAList_BetSetting (custid INT, minBet MONEY, MaxBet MONEY, MaxPerMatch MONEY)
	CREATE TABLE #MemberList_BetSetting (custid INT, minBet MONEY, MaxBet MONEY, MaxPerMatch MONEY)

	DECLARE @ProductID TINYINT = 28
	DECLARE @fSportType SMALLINT, @fBetType SMALLINT, @tSportType SMALLINT, @tBetType SMALLINT, @IsLive BIT
	
	CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT, IsFinished BIT)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM dbo.Customer ci WITH(NOLOCK)
	WHERE ci.custid IN (1,2,3,4,5,6,9,12,13,15,16,17,22,30,32,33,34,35,36,41,42,21278849,21278858) -- dummy account		
	
	INSERT INTO #OfferedSite (site)
	VALUES  ('033333'), ('611111'), ('722222'), ('766666'), ('789y'), ('7aa666'), ('BEST-ODDS'), ('JPNIBC'), ('XYZBET')	    
	
	INSERT INTO #DestinationSportBetType(fSportType, fBetType,tSportType, tBetType, IsLive,  SettingType, IsFinished)
	SELECT	202, 1501, SportType, BetType, 0, SettingType, 0
	FROM dbo.ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SettingType IN (1,6)

	INSERT INTO #DestinationSportBetType(fSportType, fBetType,tSportType, tBetType, IsLive,  SettingType, IsFinished)
	SELECT	202, 15, SportType, BetType, 0, SettingType, 0
	FROM dbo.ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SettingType IN (2)

	--- get direct master
	INSERT INTO #DirectMaster (CustID,roleid)
	SELECT ci.custid, ci.roleid
	FROM Customer ci with(nolock)
		INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid
	WHERE  EXISTS (SELECT 1 FROM #OfferedSite WHERE site = ci.site)
		AND  EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		AND ci.roleid=3
		AND c.Enabled=1
		
	--- get direct agent
	INSERT INTO #DirectAgent (CustID,mrecommend,roleid)
	SELECT ci.custid, ci.mrecommend,ci.roleid
	FROM Customer ci WITH(NOLOCK)
		INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid
	WHERE  EXISTS (SELECT 1 FROM #OfferedSite WHERE site = ci.site)
		AND  EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		and ci.roleid = 2
		AND c.Enabled=1

	INSERT INTO #DirectMember(CustID,recommend,mrecommend,roleid)
	SELECT c.custid, c.recommend,c.mrecommend,c.roleid
	FROM Customer c WITH(NOLOCK)
		INNER JOIN Customer ca (nolock) on c.recommend=ca.custid 
		INNER JOIN custInfo ci WITH(NOLOCK) ON ci.custid=c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid
	WHERE EXISTS (SELECT 1 FROM #OfferedSite WHERE site = ca.site)
		AND EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		AND c.roleid=1
		AND ci.Enabled=1

	----------- For SMA  -----------
	INSERT INTO #SMATemp (CustID,RoleID)
	SELECT custid, 4 -- Super
	FROM #supers
	UNION ALL
	-----------------------Master--------------------------------------
	SELECT d.CustID, 3 -- Direct Master 
	FROM #DirectMaster d	
	UNION 
	SELECT DISTINCT d.mrecommend, 3 -- Master of direct agent
	FROM #DirectAgent d
	UNION 
	SELECT DISTINCT d.mrecommend, 3 -- Master of direct member
	FROM #DirectMember D 	
	UNION 
	-----------------------Agent--------------------------------------
	SELECT ci.CustID,2 -- Agent of direct master
	FROM custInfo ci WITH (NOLOCK)
		INNER JOIN #DirectMaster D ON ci.mrecommend = d.CustID 
	WHERE ci.roleid = 2 AND ci.Enabled=1
	UNION
	SELECT DISTINCT d.recommend, 2 -- agent of direct member
	FROM #DirectMember D 	
	UNION 
	SELECT d.CustID, 2 -- Direct Agent
	FROM #DirectAgent D
	UNION ALL
	--dummy account don't have member enabled
	SELECT ci.custid, ci.roleid
	FROM Custinfo ci WITH (NOLOCK)
	WHERE username IN ('WSNT','midrup','MLOTTO','MSSD')

	---------- For members ---------
	INSERT INTO #MemberTemp (CustID)
	SELECT  ci.custid -- member of direct master
	FROM Custinfo ci WITH (NOLOCK)
		INNER JOIN #DirectMaster m ON ci.mrecommend = m.CustID
	WHERE ci.roleid = 1	AND ci.Enabled = 1 			
	UNION ALL -- member of direct agent
	SELECT  ci.custid
	FROM Custinfo ci WITH (NOLOCK)
		INNER JOIN #DirectAgent a ON ci.recommend = a.CustID
	WHERE ci.roleid = 1 AND ci.Enabled = 1 			
	-- Direct member		
	UNION 
	SELECT ci.custid
	FROM #DirectMember ci

	--------------------------------------PT Setting-------------------------------------------------	
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType, @tSportType = tSportType, @tBetType = tBetType
	FROM #DestinationSportBetType		
	WHERE SettingType = 1

	--AGENT LEVEL
	INSERT INTO #SMAList_PT (custid, SPositionTaking, MPositionTaking, APositionTaking, IsAutoMPositionTaking, AutoMPositionTaking, IsAutoPositionTaking, AutoPositionTaking, MinPositionTaking)
	SELECT ci.custid, SPositionTaking, MPositionTaking, APositionTaking, IsAutoMPositionTaking, AutoMPositionTaking, IsAutoPositionTaking, AutoPositionTaking, MinPositionTaking
	FROM dbo.custSettingGame cs WITH(NOLOCK) 
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cs.custid
		INNER JOIN #SMATemp s WITH (NOLOCK) ON ci.custid = s.custid
		INNER JOIN dbo.CustOverrideGame co WITH(NOLOCK) ON cs.custid = co.custid and cs.sporttype = co.sporttype and cs.bettype = co.bettype	
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
				OR co.MinPositionTaking  * 100 <> csa.MinPT 
				)

	--MEMBER LEVEL
	INSERT INTO #MemberList_PT (custid, SPositionTaking, MPositionTaking, APositionTaking, IsAutoMPositionTaking, AutoMPositionTaking, IsAutoPositionTaking, AutoPositionTaking)
	SELECT ci.custid, SPositionTaking, MPositionTaking, APositionTaking, IsAutoMPositionTaking, AutoMPositionTaking, IsAutoPositionTaking, AutoPositionTaking
	FROM dbo.custSettingGame cs WITH(NOLOCK)
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cs.custid
		INNER JOIN #MemberTemp s WITH (NOLOCK) ON ci.custid = s.custid
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
		INNER JOIN #supers s WITH (NOLOCK) ON csa.custid = s.custid
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
	--------------------------------------Bet Setting-------------------------------------------------		
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType, @tSportType = tSportType, @tBetType = tBetType
	FROM #DestinationSportBetType		
	WHERE SettingType = 2

	--Agent Level
	INSERT INTO #SMAList_BetSetting (custid, minBet, MaxBet, MaxPerMatch)
	SELECT cs.custid, cs.MinBet, cs.MaxBet, cs.MaxPerGameType
	FROM dbo.CustGameType cs WITH(NOLOCK)
		INNER JOIN custInfo c WITH(NOLOCK) ON cs.CustID = c.custid
		INNER JOIN #SMATemp s WITH (NOLOCK) ON c.custid = s.custid
		INNER JOIN dbo.CustBetSetting3rd_Agent csa WITH(NOLOCK) ON csa.custid = cs.custid
	WHERE cs.GameTypeID = @fBetType AND csa.SportType = @tSportType AND csa.BetType = @tBetType
			AND c.roleid IN (2,3,4) AND Enabled = 1
			AND (
				cs.minBet <> csa.minBet
				OR cs.MaxBet <> csa.MaxBet
				OR cs.MaxPerGameType <> csa.maxperMatch			
				)

	--Member Level
	INSERT INTO #MemberList_BetSetting (custid, minBet, MaxBet, MaxPerMatch)
	SELECT cs.custid, cs.MinBet, cs.MaxBet, cs.MaxPerGameType
	FROM dbo.CustGameType cs WITH(NOLOCK)
		INNER JOIN custInfo c WITH(NOLOCK) ON cs.CustID = c.custid
		INNER JOIN #MemberTemp s WITH (NOLOCK) ON c.custid = s.custid
		INNER JOIN dbo.CustBetSetting3rd_Member csm WITH(NOLOCK) ON csm.custid = cs.custid
	WHERE cs.GameTypeID = @fBetType AND csm.SportType = @tSportType AND csm.BetType = @tBetType
			AND c.roleid = 1 AND Enabled = 1
			AND (
				cs.minBet <> csm.minBet
				OR cs.MaxBet <> csm.MaxBet
				OR cs.MaxPerGameType <> csm.maxperMatch			
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
			AND SettingType = 2

		IF @@ROWCOUNT = 0 BREAK

		UPDATE csa
		SET csa.minBet = cs.MinBet,       
			csa.MaxBet = cs.MaxBet,   
			csa.maxperMatch = cs.MaxPerMatch
		FROM dbo.CustBetSetting3rd_Agent csa WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #SMAList_BetSetting cs WITH(NOLOCK) ON cs.custid = csa.CustID
		WHERE csa.SportType = @tSportType AND csa.BetType = @tBetType

		UPDATE csm
		SET csm.minBet = cs.minbet,       
			csm.MaxBet = cs.MaxBet,   
			csm.maxperMatch = cs.MaxPerMatch
		FROM dbo.CustBetSetting3rd_Member csm WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #MemberList_BetSetting cs WITH(NOLOCK) ON cs.custid = csm.CustID
		WHERE csm.SportType = @tSportType AND csm.BetType = @tBetType
	END

	DROP TABLE #DestinationSportBetType			
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
PRINT N'Step 11: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

EXEC dbo.Acc_DynamicCustSetting3rd_09 

PRINT N'Step 11: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'