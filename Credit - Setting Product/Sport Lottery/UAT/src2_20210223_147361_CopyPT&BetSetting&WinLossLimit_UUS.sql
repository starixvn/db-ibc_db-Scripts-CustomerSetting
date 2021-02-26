/*
	Created: Winfred
	Date: 20210223
	Task: Copy PT & Bet & WinLossLimit for Sports Lottery UUS [Redmine: 147361]
	DB: DBCUST/CustDB
	P/s : Step 2 Copy PT & Bet & WinLossLimit UUS
*/ 

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@srecommend INT	
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('ProductSettingDetail') = 0 RETURN

	DECLARE @ProductID TINYINT = 44, @Sporttype INT = 169 ,@Bettype INT  = 3611
	DECLARE @fSportType SMALLINT, @fBetType SMALLINT

	CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT, IsFinished BIT)
	INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
	SELECT	220, 1024, SportType, BetType, 0, SettingType, 0
	FROM ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SportType = @Sporttype AND SettingType IN (2,18) --  PT,WinLossLimit
	
	INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
	SELECT	220, 1021, SportType, BetType, 0, SettingType, 0
	FROM ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SportType = @Sporttype AND SettingType IN (6) --  BetLimit

	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
	)
	CREATE TABLE #MemberTempBatch
	(
		CustID	INT PRIMARY KEY CLUSTERED	
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		roleid TINYINT
	)

	INSERT INTO #MemberTemp (CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1  AND Enabled = 1 AND custid <= @maxcustid
	
	INSERT INTO #SMATemp (CustID, roleid)
	SELECT custid, roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND Enabled = 1 AND custid <= @maxcustid 
	
	--------------------------------------PT Setting-------------------------------------------------	
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType 
	FROM #DestinationSportBetType		
	WHERE SettingType = 18

	--Agent Level
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
		C.custid, dest.tSportType, dest.tBetType
		,C.IsLive
		,C.SuperPT
		,C.MasterPT
		,C.AgentPT
		,C.IsAutoMasterPT
		,C.AutoMasterPT
		,C.IsAutoSuperPT
		,C.AutoSuperPT
		,C.MinPT
		,C.MaxPT
	FROM dbo.CustPTSetting3rd_Agent C WITH(NOLOCK) 
		INNER JOIN #SMATemp ci ON ci.custid = C.custid
		CROSS APPLY #DestinationSportBetType dest
	WHERE C.bettype = @fBetType AND C.SportType = @fSportType
		AND dest.SettingType = 18

	--Member Level
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
		C.custid, dest.tSportType, dest.tBetType
		,C.IsLive
		,C.SuperPT
		,C.MasterPT
		,C.AgentPT
		,C.IsAutoMasterPT
		,C.AutoMasterPT
		,C.IsAutoSuperPT
		,C.AutoSuperPT
	FROM CustPTSetting3rd_Member C WITH(NOLOCK) 
		INNER JOIN #MemberTemp ci ON C.CustID = ci.custid
		CROSS APPLY #DestinationSportBetType dest
	WHERE C.bettype = @fBetType AND C.sporttype = @fSportType
		AND dest.SettingType = 18

	--Group PT 
	INSERT INTO dbo.CustPTGroupSetting3rd_Member
		(	[AgentID]
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
		)
	SELECT 
		C.AgentID, dest.tSportType, dest.tBetType
		,C.IsLive
		,C.SuperPT
		,C.MasterPT
		,C.AgentPT
		,C.IsAutoMasterPT
		,C.AutoMasterPT
		,C.IsAutoSuperPT
		,C.AutoSuperPT
	FROM dbo.CustPTGroupSetting3rd_Member C WITH(NOLOCK) 
		INNER JOIN #SMATemp ci ON ci.custid = C.AgentID
		CROSS APPLY #DestinationSportBetType dest
	WHERE C.bettype = @fBetType AND C.SportType = @fSportType
		AND dest.SettingType = 18

--------------------------------------Bet Setting-------------------------------------------------
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType 
	FROM #DestinationSportBetType		
	WHERE SettingType = 2

	--Super level
	INSERT INTO dbo.CustBetSetting3rd_Agent(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
	SELECT cs.CustID, dest.tSportType, dest.tBetType, MinBet, MaxBet, MaxPerMatch	
	FROM dbo.CustBetSetting3rd_Agent cs WITH(NOLOCK)
		INNER JOIN #SMATemp ci  ON Cs.CustID = ci.custid
		CROSS APPLY #DestinationSportBetType dest
	WHERE Cs.bettype = @fBetType AND Cs.SportType = @fSportType
		AND dest.SettingType = 2
	
	--Member Level
	INSERT INTO dbo.CustBetSetting3rd_Member(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
	SELECT cs.CustID, dest.tSportType, dest.tBetType, MinBet, MaxBet, MaxPerMatch
	FROM dbo.CustBetSetting3rd_Member cs WITH(NOLOCK) 
		INNER JOIN #MemberTemp ci WITH(NOLOCK) ON Cs.CustID = ci.custid
		CROSS APPLY #DestinationSportBetType dest
	WHERE Cs.bettype = @fBetType AND Cs.SportType = @fSportType
		AND dest.SettingType = 2

--------------------------------------Win Loss Limit-------------------------------------------------
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType 
	FROM #DestinationSportBetType		
	WHERE SettingType = 6
	
	--Agent Level
	INSERT INTO dbo.CustWinLossLimit_Agent (CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
	SELECT ci.custid, dest.tsporttype, dest.tbettype, MaxWinLimit, MaxLossLimit, IsAutoReset
	FROM CustWinLossLimit_Agent C WITH (NOLOCK) INNER JOIN #SMATemp ci WITH (NOLOCK) ON C.CustId = CI.CustID
		CROSS APPLY #DestinationSportBetType dest WITH(NOLOCK) 
	WHERE dest.SettingType = 6 AND C.bettype = @fBetType AND C.SportType = @fSportType

	--Member Level
	INSERT INTO dbo.CustWinLossLimit_Member (CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
	SELECT ci.custid, dest.tsporttype, dest.tbettype, MaxWinLimit, MaxLossLimit, IsAutoReset
	FROM dbo.CustWinLossLimit_Member C WITH (NOLOCK) INNER JOIN #MemberTemp ci WITH(NOLOCK) ON C.CustId = CI.CustID
		CROSS APPLY #DestinationSportBetType dest WITH(NOLOCK) 
	WHERE dest.SettingType = 6 AND C.bettype = @fBetType AND C.SportType = @fSportType



	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
	DROP TABLE #DestinationSportBetType	

END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

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
	AND ci.custid <= @max_custid
	AND ci.Site NOT IN ('CN88')
	AND ci.currency IN (20,72) -- UUS

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'REPLICATED'
			
			
	waitfor delay '00:00:0.200'
END
GO


-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 3: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

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
	AND ci.custid <= @max_custid
	AND ci.Site NOT IN ('CN88')
	AND ci.currency IN (20,72) -- UUS

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
						
	waitfor delay '00:00:0.200'
END

PRINT N'Step 3: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
