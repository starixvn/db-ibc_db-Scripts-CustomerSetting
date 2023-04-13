/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230314@Eden
	Task: Initialize Setting for NG and Keno - Real Currency [Redmine: #179711]
	DB: DBCUST/CustDB AND all replicated server of CustDB_CustSetting publication
*/ 
ALTER PROCEDURE [dbo].Acc_DynamicCustSetting3rd_09
	 @srecommend INT
	,@maxcustid INT
	,@target VARCHAR(20)

AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbcust only
	
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 1
	   AND dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 1
	   AND dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 1
	   AND dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 1
	   AND dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 1
	   AND dbo.f_CheckRepTable('CustBetSetting_Agent') = 1
	   AND dbo.f_CheckRepTable('CustBetSetting_Member') = 1
	   AND dbo.f_CheckRepTable('custsetting3rd') = 1
	   AND dbo.f_CheckRepTable('CustGameType') = 1
	   AND dbo.f_CheckRepTable('CustSettingGame') = 1
	   AND dbo.f_CheckRepTable('CustOverrideGame') = 1
	   AND dbo.f_CheckRepTable('custOverride3rd') = 1
	   )
		RETURN

	DECLARE @batchNum INT = 4000
	CREATE TABLE #MemberTemp(CustID INT PRIMARY KEY CLUSTERED)
	CREATE TABLE #MemberTempbatch(CustID INT)
	CREATE TABLE #SMATemp(CustID INT PRIMARY KEY CLUSTERED, roleid TINYINT)

	INSERT INTO #MemberTemp (CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1  AND Enabled = 1 AND custid <= @maxcustid
	
	INSERT INTO #SMATemp (CustID, roleid)
	SELECT custid, roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND Enabled = 1 AND custid <= @maxcustid 

	-----------------------------MIGRATE DATA------------------------------------
	--SMA PT - NumberGame
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
		C.custid
		,161 AS [SportType]
		,81 AS [BetType]
		,0 AS IsLive
		,C.slivepositiontaking * 100
		,C.mlivepositiontaking * 100
		,C.alivepositiontaking * 100
		,C.isautolivempositiontaking
		,C.autolivempositiontaking * 100
		,C.isautolivepositiontaking
		,C.autolivepositiontaking * 100
		,o.minlivepositiontaking * 100
		,100 AS MAXPT
	FROM dbo.CustSetting3rd C WITH(NOLOCK) 
		INNER JOIN #SMATemp ci ON ci.custid = C.custid
		INNER JOIN custOverride3rd o WITH(NOLOCK) ON c.custid = o.custid AND c.sporttype = o.sporttype AND c.bettype = o.bettype
	WHERE c.sporttype = 161 AND c.bettype = 85

	--SMA Bet Setting - Keno
	INSERT INTO CustBetSetting3rd_Agent (CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch)
	SELECT c.custid
		,202 AS [SportType]
		,1501 AS [BetType]
		,c.MinBet
		,c.MaxBet
		,c.MaxPerGameType
	FROM dbo.CustGameType C WITH(NOLOCK) 
		INNER JOIN #SMATemp ci ON ci.custid = C.custid
	WHERE c.GameTypeID = 1

	--SMA PT - Keno
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
		C.custid
		,202 AS [SportType]
		,1501 AS [BetType]
		,0 AS IsLive
		,C.spositiontaking * 100
		,C.mpositiontaking * 100
		,C.apositiontaking * 100
		,C.isautompositiontaking
		,C.autompositiontaking * 100
		,C.isautopositiontaking
		,C.autopositiontaking * 100
		,o.minpositiontaking * 100
		,100 AS MAXPT
	FROM dbo.CustSettingGame C WITH(NOLOCK) 
		INNER JOIN #SMATemp ci ON ci.custid = C.custid
		INNER JOIN CustOverrideGame o WITH(NOLOCK) ON c.custid = o.custid AND c.sporttype = o.sporttype AND c.bettype = o.bettype
	WHERE c.sporttype = 202 AND c.bettype = 1501

	
	---------------------MEMBER LEVEL-----------------------------
	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #MemberTempBatch

		DELETE TOP(@batchNum) t
		OUTPUT deleted.CustID INTO #MemberTempBatch(CustID)
		FROM #MemberTemp t

		IF @@ROWCOUNT = 0
			BREAK;

		--Member PT - NumberGame
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
			C.custid
			,161 AS [SportType]
			,81 AS [BetType]
			,0 AS IsLive
			,C.slivepositiontaking * 100
			,C.mlivepositiontaking * 100
			,C.alivepositiontaking * 100
			,C.isautolivempositiontaking
			,C.autolivempositiontaking * 100
			,C.isautolivepositiontaking
			,C.autolivepositiontaking * 100
		FROM CustSetting3rd C WITH(NOLOCK,FORCESEEK) 
			INNER JOIN #MemberTempBatch ci ON ci.custid = C.custid
		WHERE c.sporttype = 161 AND c.bettype = 85

		--Member Bet Setting - Keno
		INSERT INTO CustBetSetting3rd_Member (CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch)
		SELECT c.custid
			,202 AS [SportType]
			,1501 AS [BetType]
			,c.MinBet
			,c.MaxBet
			,c.MaxPerGameType
		FROM dbo.CustGameType C WITH(NOLOCK,FORCESEEK) 
			INNER JOIN #MemberTempBatch ci ON ci.custid = C.custid
		WHERE c.GameTypeID = 1

		--Member PT - Keno
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
			C.custid
			,202 AS [SportType]
			,1501 AS [BetType]
			,0 AS IsLive
			,C.spositiontaking * 100
			,C.mpositiontaking * 100
			,C.apositiontaking * 100
			,C.isautompositiontaking
			,C.autompositiontaking * 100
			,C.isautopositiontaking
			,C.autopositiontaking * 100
		FROM CustSettingGame C WITH(NOLOCK,FORCESEEK) 
			INNER JOIN #MemberTempBatch ci ON ci.custid = C.custid
		WHERE c.sporttype = 202 AND c.bettype = 1501

	END

	DROP TABLE #MemberTemp
	DROP TABLE #MemberTempbatch
	DROP TABLE #SMATemp
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS and DBCUST -----
--------------------------------------------------------------------------------------
SET NOCOUNT ON
PRINT N'Step : Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN custinfo C WITH(NOLOCK) ON c.CustID = ci.custid 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND s.islicensee = 0
		AND ci.custid <= @max_custid
		AND ci.Site<>'CN88'
		AND c.Enabled = 1
		AND ci.currency NOT IN (20,72) 

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

	EXEC dbo.Acc_DynamicCustSetting3rd_09 
				@srecommend = @srecommend, 
				@maxcustid = @max_custid,
				@target = @target
			
	WAITFOR DELAY '00:00:0.280'
END
GO
GO
PRINT N'Step : End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
SET NOCOUNT OFF
