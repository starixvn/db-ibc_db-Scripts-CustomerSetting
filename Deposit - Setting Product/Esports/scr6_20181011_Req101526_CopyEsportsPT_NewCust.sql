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

		
	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT CustID,24
	FROM #supers ci
	WHERE ci.custid>@maxcustid

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

	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT CustID,25
	FROM #supers ci
	WHERE ci.custid>@maxcustid

	DROP TABLE #PTTemp
	DROP TABLE #BetSettingTemp
	DROP TABLE #supers