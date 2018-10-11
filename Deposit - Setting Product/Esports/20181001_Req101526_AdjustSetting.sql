/*
	Created: Winnie
	Task: Adjust setting for Esports  RedmineID: #101526
	DB: DBCUST/CustDB
	Date: 20181001
*/ 

	DECLARE @maxcustid INT
	
	SELECT @maxcustid = xxx
	CREATE TABLE #supers (custid int)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM dbo.custInfo ci WITH(NOLOCK)
	WHERE ci.custid NOT IN (SELECT CustID FROM Dep_CustSuper)
	 AND ci.roleid=4 
	 AND ci.Enabled=1

	DECLARE @fSportType INT = 99, @fBetType INT=1
	DECLARE @Sporttype INT = 43

	CREATE TABLE #DestinationSportBetType(fSportType INT, fBetType INT,tSportType INT, tBetType INT, IsLive BIT)
	INSERT INTO #DestinationSportBetType(fSportType , fBetType ,tSportType , tBetType , IsLive)
	SELECT	@fSportType, @fBetType, SportType, BetType, 0
	FROM dbo.ProductSettingDetail WITH (NOLOCK)
	WHERE SportType = @Sporttype AND BetType IN(1,9999) AND SettingType = 1

	INSERT INTO #DestinationSportBetType(fSportType , fBetType ,tSportType , tBetType , IsLive)
	SELECT	@fSportType, BetType, SportType, BetType, 0
	FROM dbo.ProductSettingDetail WITH (NOLOCK)
	WHERE SportType = @Sporttype AND BetType NOT IN(1,9999)  AND SettingType = 1

	CREATE TABLE #PTTemp
	(
		CustID				INT ,
		roleid				TINYINT,
		[SportType]			SMALLINT,
		[BetType]			SMALLINT,
		[IsLive]			BIT,
		[SuperPT]			TINYINT,
		[MasterPT]			TINYINT,
		[AgentPT]			TINYINT,
		[IsAutoMasterPT]	BIT,
		[AutoMasterPT]		TINYINT,
		[IsAutoSuperPT]		BIT,
		[AutoSuperPT]		TINYINT,
		[MinPT]				TINYINT,
		[MaxPT]				TINYINT,
		PRIMARY KEY (CustID,SportType,BetType,IsLive)
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
		PRIMARY KEY (CustID,SportType,BetType)
	)

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
		,co.maxpositiontaking*100
	FROM custInfo ci WITH(NOLOCK)
		INNER JOIN dbo.custSetting cs WITH(NOLOCK) ON ci.custid=cs.custid
		LEFT JOIN dbo.CustOverride co WITH(NOLOCK) ON cs.custid = co.custid and cs.sporttype = co.sporttype and cs.bettype = co.bettype
		INNER JOIN  #DestinationSportBetType dest ON dest.fSportType=cs.sporttype AND dest.fBetType=cs.bettype
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid AND ci.Enabled=1 

	
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
		MaxPerMatch			
	FROM custInfo ci WITH(NOLOCK)
		 INNER JOIN dbo.custSetting cs WITH(NOLOCK) ON ci.custid=cs.custid
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid AND ci.Enabled=1 AND cs.sporttype=@fSportType AND cs.bettype=@fBetType

	
	--------------------------------------PT Setting-------------------------------------------------	
	--AGENT LEVEL
	INSERT INTO dbo.CustPTSetting3rd_Agent
		(	[CustID]
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		   ,[IsAutoMasterPT]
		   ,[AutoMasterPT]
		   ,[IsAutoSuperPT]
		   ,[AutoSuperPT]
		   ,[MinPT]
		   ,[MaxPT])
	SELECT 
			[CustID]
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		   ,[IsAutoMasterPT]
		   ,[AutoMasterPT]
		   ,[IsAutoSuperPT]
		   ,[AutoSuperPT]
		   ,[MinPT]
		   ,[MaxPT]
	FROM #PTTemp t
		WHERE t.roleid IN(2,3,4)
	--MEMBER LEVEL
	INSERT INTO dbo.CustPTSetting3rd_Member
		(	[custid]
		  ,	[sporttype]
		  ,	[bettype]
		  ,	[islive]
		  ,	[superPT]
		  ,	[masterPT]
		  ,	[agentPT]
		  ,	[IsAutoMasterPT]
		  ,	[AutoMasterPT]
		  ,	[IsAutoSuperPT]
		  ,	[AutoSuperPT])
	SELECT 
			[CustID]
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		   ,[IsAutoMasterPT]
		   ,[AutoMasterPT]
		   ,[IsAutoSuperPT]
		   ,[AutoSuperPT]		
	FROM #PTTemp t
		WHERE t.roleid =1
		
	--------------------------------------Bet Setting-------------------------------------------------		

	--Agent Level
	INSERT INTO dbo.CustBetSetting3rd_Agent(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
	SELECT CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch		
	FROM #BetSettingTemp 
	WHERE roleid IN(2,3,4)

	--Member Level
	INSERT INTO dbo.CustBetSetting3rd_Member(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
	SELECT CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch				
	FROM #BetSettingTemp 
	WHERE roleid = 1 

	DROP TABLE #PTTemp
	DROP TABLE #BetSettingTemp
	DROP TABLE #DestinationSportBetType			
