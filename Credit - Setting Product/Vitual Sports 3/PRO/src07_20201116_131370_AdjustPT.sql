/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20201116
	Task: Copy Setting for new created users of Leap Gaming Virtual Sports [RedmineID:#131370]
	DB: DBCust/CustDB
*/
------------------------------------------------------
USE CustDB
GO

PRINT N'Step 7: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
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
		AND ci.currency NOT IN (20,72)

	DECLARE @msgDone NVARCHAR(200) = 'Done for sporttype %d, bettype %d.'

	CREATE TABLE #SMAList_PT (custid INT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY, IsAutoMPositionTaking BIT, AutoMPositionTaking SMALLMONEY, IsAutoPositionTaking BIT, AutoPositionTaking SMALLMONEY, MinPositionTaking SMALLMONEY, MaxPositionTaking SMALLMONEY)
	CREATE TABLE #MemberList_PT (custid INT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY, IsAutoMPositionTaking BIT, AutoMPositionTaking SMALLMONEY, IsAutoPositionTaking BIT, AutoPositionTaking SMALLMONEY)	
	CREATE TABLE #AgentGroupPT ( AgentID INT, IsLive BIT, SuperPT TINYINT, MasterPT TINYINT, AgentPT TINYINT, IsAutoMasterPT BIT, AutoMasterPT TINYINT, IsAutoSuperPT BIT, AutoSuperPT TINYINT)

	DECLARE @ProductID TINYINT = 5, @SportType INT = 231, @Bettype INT = 5301
	DECLARE @fSportType SMALLINT, @fBetType SMALLINT, @tSportType SMALLINT, @tBetType SMALLINT, @IsLive BIT
	
	CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT, IsFinished BIT)
	INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
	SELECT	180, 1201, SportType, BetType, 0, SettingType, 0
	FROM ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SportType = @Sporttype AND BetType = @Bettype AND SettingType IN  (1,20) --  PT, Bet limit
	--------------------------------------PT Setting-------------------------------------------------	
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType, @tSportType = tSportType, @tBetType = tBetType
	FROM #DestinationSportBetType		
	WHERE SettingType = 1

	--AGENT LEVEL
	INSERT INTO #SMAList_PT (custid, SPositionTaking, MPositionTaking, APositionTaking, IsAutoMPositionTaking, AutoMPositionTaking, IsAutoPositionTaking, AutoPositionTaking, MinPositionTaking, MaxPositionTaking)
	SELECT C.custid, C.SuperPT, C.MasterPT, C.AgentPT, C.IsAutoMasterPT, C.AutoMasterPT, C.IsAutoSuperPT, C.AutoSuperPT, C.MinPT, C.MaxPT
	FROM CustPTSetting3rd_Agent C WITH(NOLOCK)
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
	FROM CustPTSetting3rd_Member C WITH(NOLOCK)
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
	FROM CustPTGroupSetting3rd_Member C WITH (NOLOCK)
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

	END	
	
	--------------------------------------Bet Setting-------------------------------------------------		

	
	CREATE TABLE #SMAList_BetSetting (custid INT, minBet MONEY, MaxBet MONEY)
	CREATE TABLE #MemberList_BetSetting (custid INT, minBet MONEY, MaxBet MONEY)
	CREATE TABLE #TempBetLimit (ExchangeId INT, MinBet MONEY,MaxBet MONEY)

	INSERT INTO #TempBetLimit(ExchangeId,MinBet,MaxBet)
	SELECT Currency,MinBet,MaxBet 
	FROM ProductBetSetting WITH(NOLOCK)
	WHERE Sporttype = @Sporttype AND Bettype = @Bettype 
	

	--Agent Level
	INSERT INTO #SMAList_BetSetting (custid, minBet, MaxBet)
	SELECT cs.custid, 
			CASE 
			WHEN cs.MinBet = 0  AND cs.MaxBet = 0  THEN cs.MinBet
			WHEN cs.MinBet = 0  AND cs.MaxBet = 0.1  THEN cs.MinBet
			WHEN cs.MinBet < t.MinBet   THEN t.MinBet ELSE cs.MinBet END AS MinBet,
			CASE 
			WHEN cs.MinBet = 0  AND cs.MaxBet = 0  THEN cs.MaxBet
			WHEN cs.MinBet = 0  AND cs.MaxBet = 0.1  THEN cs.MaxBet
			WHEN cs.MaxBet > t.MaxBet   THEN t.MaxBet ELSE cs.MaxBet END AS MaxBet
	FROM dbo.CustBetSetting3rd_Agent cs WITH(NOLOCK)
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cs.custid
		INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = S.custid
		INNER JOIN #TempBetLimit t ON t.ExchangeId = ci.currency
		INNER JOIN dbo.CustBetSetting3rd_Agent csa WITH(NOLOCK) ON csa.custid = cs.custid
	WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType AND csa.SportType = @tSportType AND csa.BetType = @tBetType
			AND ci.roleid IN (2,3,4) AND Enabled = 1
			AND (
				cs.minBet <> CASE 
								WHEN cs.MinBet = 0  AND cs.MaxBet = 0  THEN cs.MinBet
								WHEN cs.MinBet = 0  AND cs.MaxBet = 0.1  THEN cs.MinBet
								WHEN cs.MinBet < t.MinBet   THEN t.MinBet ELSE cs.MinBet END
				OR cs.MaxBet <> CASE 
									WHEN cs.MinBet = 0  AND cs.MaxBet = 0  THEN cs.MaxBet
									WHEN cs.MinBet = 0  AND cs.MaxBet = 0.1  THEN cs.MaxBet
									WHEN cs.MaxBet > t.MaxBet   THEN t.MaxBet ELSE cs.MaxBet END						
				)

	RAISERROR('Done: Get the affected SMA list for bet setting', 0, 1)  WITH NOWAIT

	--Member Level
	INSERT INTO #MemberList_BetSetting (custid, minBet, MaxBet)
	SELECT ci.custid, 
			CASE 
			WHEN cs.MinBet = 0  AND cs.MaxBet = 0  THEN cs.MinBet
			WHEN cs.MinBet = 0  AND cs.MaxBet = 0.1  THEN cs.MinBet
			WHEN cs.MinBet < t.MinBet   THEN t.MinBet ELSE cs.MinBet END AS MinBet,
			CASE 
			WHEN cs.MinBet = 0  AND cs.MaxBet = 0  THEN cs.MaxBet
			WHEN cs.MinBet = 0  AND cs.MaxBet = 0.1  THEN cs.MaxBet
			WHEN cs.MaxBet > t.MaxBet   THEN t.MaxBet ELSE cs.MaxBet END AS MaxBet
	FROM dbo.CustBetSetting3rd_Member cs WITH(NOLOCK)
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cs.custid
		INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = S.custid
		INNER JOIN #TempBetLimit t ON t.ExchangeId = ci.currency	
		INNER JOIN dbo.CustBetSetting3rd_Member csm WITH(NOLOCK) ON csm.custid = cs.custid
	WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType AND csm.SportType = @tSportType AND csm.BetType = @tBetType
			AND ci.roleid = 1 AND Enabled = 1
			AND (
				cs.minBet <> CASE 
								WHEN cs.MinBet = 0  AND cs.MaxBet = 0  THEN cs.MinBet
								WHEN cs.MinBet = 0  AND cs.MaxBet = 0.1  THEN cs.MinBet
								WHEN cs.MinBet < t.MinBet   THEN t.MinBet ELSE cs.MinBet END
				OR cs.MaxBet <> CASE 
									WHEN cs.MinBet = 0  AND cs.MaxBet = 0  THEN cs.MaxBet
									WHEN cs.MinBet = 0  AND cs.MaxBet = 0.1  THEN cs.MaxBet
									WHEN cs.MaxBet > t.MaxBet   THEN t.MaxBet ELSE cs.MaxBet END						
						
				)

	RAISERROR('Done: Get the affected member list for bet setting', 0, 1)  WITH NOWAIT


	--------------------------------------Bet Setting-------------------------------------------------		
	--Adjust data
	WHILE (1 = 1)
	BEGIN				
		UPDATE TOP (1) #DestinationSportBetType
		SET IsFinished = 1		
			,@tBetType = tBetType
			,@tSportType = tSportType
			,@IsLive = IsLive
		WHERE IsFinished = 0
			AND SettingType = 20

		IF @@ROWCOUNT = 0 BREAK	

		UPDATE csa
		SET	csa.minBet = cs.minbet,       
			csa.MaxBet = cs.MaxBet  
		FROM dbo.CustBetSetting3rd_Agent csa WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #SMAList_BetSetting cs WITH(NOLOCK) ON csa.custid = cs.custid
		WHERE csa.SportType = @tSportType AND csa.BetType = @tBetType
	
		UPDATE csm
		SET	csm.minBet = cs.minbet,       
			csm.MaxBet = cs.MaxBet
		FROM dbo.CustBetSetting3rd_Member csm WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #MemberList_BetSetting cs WITH(NOLOCK) ON csm.CustID = cs.custid
		WHERE csm.bettype = @tBetType AND csm.sporttype = @tSportType

	END	
		
		
	DROP TABLE #SMAList_BetSetting
	DROP TABLE #MemberList_BetSetting
	DROP TABLE #DestinationSportBetType
	DROP TABLE #SMAList_PT
	DROP TABLE #MemberList_PT
	DROP TABLE #AgentGroupPT
	DROP TABLE #supers
	
PRINT N'Step 7: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
