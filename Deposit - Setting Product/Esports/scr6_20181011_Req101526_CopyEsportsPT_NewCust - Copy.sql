/*
	Created: Winnie
	Task: Copy PT & Bet setting for Esports new cust  RedmineID: #101526
	DB: DBCUST/CustDB
	Date: 20181015
*/ 

	DECLARE @maxcustid INT
	DECLARE @AgentID	INT,@CustID	INT
	
	SELECT @maxcustid = xxx
	CREATE TABLE #supers (custid int)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM Custinfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'
		AND ci.Enabled=1

	DECLARE @fSportType INT = 99, @fBetType INT=1
	DECLARE @Sporttype INT = 43

	CREATE TABLE #PTTemp
	(
		CustID				INT ,
		roleid				TINYINT,
		[SportType]			SMALLINT,
		[BetType]			SMALLINT,
		[IsLive]			BIT,
		[SuperPT]			TINYINT,
		[MasterPT]			TINYINT,
		[AgentPT]			TINYINT
		PRIMARY KEY (CustID,SportType,BetType,IsLive,RoleID)
	)

	CREATE TABLE #BetSettingTemp
	(
		CustID				INT ,
		roleid				TINYINT,
		[SportType]			SMALLINT,
		[BetType]			SMALLINT,		
		MinBet				MONEY,
		MaxBet				MONEY,
		MaxPerMatch			MONEY
		PRIMARY KEY (CustID,SportType,BetType,RoleID)
	)

	INSERT INTO #PTTemp(
		CustID				,
		roleid				,
		[SportType]			,
		[BetType]			,
		[IsLive]			,
		[SuperPT]			,
		[MasterPT]			,
		[AgentPT]			
		)

	SELECT 
		cs.custid,ci.roleid, @Sporttype, @fBetType, 0
		,cs.spositiontaking  *100
		,cs.mpositiontaking  *100
		,cs.apositiontaking  *100		
	FROM custInfo ci WITH(NOLOCK)
		INNER JOIN dbo.Dep_custSetting cs WITH(NOLOCK) ON ci.custid=cs.custid		
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid AND ci.Enabled=1 
		AND cs.sporttype=@fSportType AND cs.bettype=@fBetType
	
	INSERT INTO #BetSettingTemp(
		CustID				,
		roleid				,
		[SportType]			,
		[BetType]			,		
		MinBet				,
		MaxBet				,
		MaxPerMatch			
		)
	SELECT 
		ci.CustID				,
		roleid				,
		@Sporttype			,
		@fBetType			,		
		MinBet				,
		MaxBet				,
		MaxPerMatch99			
	FROM custInfo ci WITH(NOLOCK)
		 INNER JOIN dbo.Dep_custSetting cs WITH(NOLOCK) ON ci.custid=cs.custid
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid AND ci.Enabled=1 AND cs.sporttype=@fSportType AND cs.bettype=@fBetType

	
	--------------------------------------PT Setting-------------------------------------------------	
	--AGENT LEVEL
	INSERT INTO dbo.Dep_CustPTSetting_Agent
		(	[CustID]
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]	)
	SELECT 
			[CustID]
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]		 
	FROM #PTTemp t
		WHERE t.roleid IN(2,3,4)

	INSERT INTO dbo.Dep_CustPTSetting_Member
	(	CustID
		,	[sporttype]
		,	[bettype]
		,	[islive]
		,	[superPT]
		,	[masterPT]
		,	[agentPT]
	)
	SELECT 
			CustID
			,[SportType]
			,[BetType]
			,[IsLive]
			,[SuperPT]
			,[MasterPT]
			,[AgentPT]	
	FROM #PTTemp t
	WHERE roleid=1

	INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
		SELECT t.CustID,1
	FROM #PTTemp t
	WHERE roleid=1 AND NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode WITH(NOLOCK) WHERE CustID=t.CustID)

	--MEMBER LEVEL
	--WHILE EXISTS(SELECT 1 FROM #PTTemp WHERE roleid=1)
	--BEGIN
	--	SELECT @CustID = Custid FROM #PTTemp WHERE roleid=1
	--	SELECT @AgentID= recommend FROM Customer WITH(NOLOCK) WHERE custid=@CustID

	--	IF NOT EXISTS(SELECT 1 FROM Dep_CustPTGroupSetting_Member WHERE AgentID=@AgentID AND SportType=@Sporttype AND BetType=@fBetType AND IsLive=0)
	--	BEGIN
	--		INSERT INTO dbo.Dep_CustPTGroupSetting_Member
	--		(	AgentID
	--		  ,	[sporttype]
	--		  ,	[bettype]
	--		  ,	[islive]
	--		  ,	[superPT]
	--		  ,	[masterPT]
	--		  ,	[agentPT]
	--		)
	--		SELECT 
	--				@AgentID
	--			   ,[SportType]
	--			   ,[BetType]
	--			   ,[IsLive]
	--			   ,[SuperPT]
	--			   ,[MasterPT]
	--			   ,[AgentPT]	
	--		FROM #PTTemp t
	--		WHERE t.CustID=@CustID
			
	--		INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
	--		SELECT @CustID,1			
			
	--	END
	--	ELSE
	--	BEGIN
	--		IF EXISTS(SELECT 1  FROM Dep_CustPTGroupSetting_Member g WITH(NOLOCK) 
	--							INNER JOIN #PTTemp t ON g.SportType=t.SportType AND g.BetType=t.BetType AND g.IsLive=t.IsLive
	--							WHERE g.AgentID=@AgentID AND t.CustID=@CustID AND (g.SuperPT<>t.SuperPT OR g.MasterPT<>t.MasterPT OR g.AgentPT<>t.AgentPT))
	--		BEGIN
	--			INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
	--			SELECT @CustID,0
				
	--			INSERT INTO dbo.Dep_CustPTSetting_Member
	--			(	CustID
	--			  ,	[sporttype]
	--			  ,	[bettype]
	--			  ,	[islive]
	--			  ,	[superPT]
	--			  ,	[masterPT]
	--			  ,	[agentPT]
	--			)
	--			SELECT 
	--					@CustID
	--				   ,[SportType]
	--				   ,[BetType]
	--				   ,[IsLive]
	--				   ,[SuperPT]
	--				   ,[MasterPT]
	--				   ,[AgentPT]	
	--			FROM #PTTemp t
	--			WHERE t.CustID=@CustID	

	--			INSERT INTO dbo.Dep_CustPTSetting_Member
	--			(	CustID
	--			  ,	[sporttype]
	--			  ,	[bettype]
	--			  ,	[islive]
	--			  ,	[superPT]
	--			  ,	[masterPT]
	--			  ,	[agentPT]
	--			)
	--			SELECT 
	--					@CustID
	--				   ,[SportType]
	--				   ,[BetType]
	--				   ,[IsLive]
	--				   ,[SuperPT]
	--				   ,[MasterPT]
	--				   ,[AgentPT]	
	--			FROM Dep_CustPTGroupSetting_Member t
	--			WHERE t.AgentID=@AgentID AND t.SportType<>@Sporttype
	--		END

	--	END
	--	DELETE FROM #PTTemp WHERE CustID=@CustID
	--END		
		
	--------------------------------------Bet Setting-------------------------------------------------		

	--Agent Level
	INSERT INTO dbo.Dep_CustBetSetting_Agent(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
	SELECT CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch		
	FROM #BetSettingTemp 
	WHERE roleid IN(2,3,4)

	--Member Level
	INSERT INTO dbo.Dep_CustBetSetting_Member(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
	SELECT CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch				
	FROM #BetSettingTemp 
	WHERE roleid = 1 

	DROP TABLE #PTTemp
	DROP TABLE #BetSettingTemp
	DROP TABLE #supers