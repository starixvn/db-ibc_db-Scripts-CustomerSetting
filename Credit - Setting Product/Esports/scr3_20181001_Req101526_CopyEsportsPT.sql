/*
	Created: Winnie
	Task: Copy PT & Bet setting for Esports  RedmineID: #101526
	DB: DBCUST/CustDB
	Date: 20181001
*/ 

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@srecommend INT	
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN		
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN

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
	WHERE ci.srecommend = @srecommend AND ci.custid<=@maxcustid AND ci.Enabled=1 

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
		maxpermatch99			
	FROM custInfo ci WITH(NOLOCK)
		 INNER JOIN dbo.custSetting cs WITH(NOLOCK) ON ci.custid=cs.custid
	WHERE ci.srecommend = @srecommend AND ci.custid<=@maxcustid AND ci.Enabled=1 AND cs.sporttype=@fSportType AND cs.bettype=@fBetType

	
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
		WHERE t.roleid IN(2,3,4) AND MinPT IS NOT NULL
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
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
			AND ci.username NOT LIKE '3rdSuper%'
			AND cs.isinternal = 0
			AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
			AND s.islicensee = 0

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'REPLICATED'
			
			
	waitfor delay '00:00:0.280'
END
GO

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 4: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
			AND ci.username NOT LIKE '3rdSuper%'
			AND cs.isinternal = 0
			AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
			AND s.islicensee = 0


-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'DBCUST'
						
	waitfor delay '00:00:0.280'
END

PRINT N'Step 4: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 