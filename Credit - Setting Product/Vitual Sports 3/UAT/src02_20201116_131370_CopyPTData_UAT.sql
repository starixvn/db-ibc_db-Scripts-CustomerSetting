/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20201116
	Task: Copy PT for Leap Gaming Virtual Sports - UAT [RedmineID:#131370]
	DB: DBCust/CustDB
*/
------------------------------------------------------

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
	IF dbo.f_CheckRepTable('ProductSettingDetail') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN	

	DECLARE @ProductID TINYINT = 5, @Sporttype INT = 231 ,@Bettype INT  = 5301
	DECLARE @fSportType SMALLINT, @fBetType SMALLINT 
	DECLARE @Currency INT 
	SELECT @currency = ci.currency FROM dbo.custInfo ci WITH (NOLOCK) WHERE ci.custid = @srecommend

	CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT, IsFinished BIT, MinBet MONEY,MaxBet MONEY)
	INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
	SELECT	180, 1201, SportType, BetType, 0, SettingType, 0
	FROM ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SportType = @Sporttype AND SettingType IN (1,20) --  PT, Bet limit

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

	CREATE TABLE #TempBetLimit (ExchangeId INT,currency NVARCHAR(50), MinBet MONEY,MaxBet MONEY)

	INSERT INTO #MemberTemp (CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1  AND Enabled = 1 AND custid <= @maxcustid
	
	INSERT INTO #SMATemp (CustID, roleid)
	SELECT custid, roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND Enabled = 1 AND custid <= @maxcustid 

	INSERT INTO #TempBetLimit(ExchangeId,currency,MinBet,MaxBet)
	VALUES (6,'EURO',2,2500),
			(35,'$US',2,2500),
			(50,'CAN',2,2500),
			(47,'DDD',18,18000),
			(12,'GBP',1,2000),
			(5,'HK$',10,20000),
			(67,'HKK',5,10000),
			(33,'IDD',18,18000),
			(34,'IDR',18,18000),
			(15,'IN',18,18000),
			(22,'IND',18,18000),
			(69,'MMK',2,3000),
			(2,'RM',5,10000),
			(13,'RMB',10,20000),
			(43,'THB',50,50000),
			(3,'US$',2,2500),
			(95,'USD',2,2500),
			(64,'UT',2,2500),
			(45,'Won',2000,3000000),
			(16,'Yen',2,2500),
			(20,'UUS',2,2500)
	
	
	UPDATE a 
	SET a.MinBet = b.MinBet,a.MaxBet = b.MaxBet
	FROM #DestinationSportBetType a
	INNER JOIN #TempBetLimit b ON b.ExchangeId = @Currency
	WHERE a.SettingType = 20
	--------------------------------------PT Setting-------------------------------------------------	
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType 
	FROM #DestinationSportBetType		
	WHERE SettingType = 1

	BEGIN
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
			AND dest.SettingType = 1

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
			AND dest.SettingType = 1

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
			AND dest.SettingType = 1

	END

	--------------------------------------Bet Limit -------------------------------------------------
	--Agent Level
	INSERT INTO dbo.CustBetSetting3rd_Agent (CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)	      
	SELECT cs.CustID, dest.tSportType, dest.tBetType, 
		CASE 
			WHEN cs.MinBet = 0  AND cs.MaxBet = 0  THEN cs.MinBet
			WHEN cs.MinBet = 0  AND cs.MaxBet = 0.1  THEN cs.MinBet
			WHEN cs.MinBet < dest.MinBet   THEN dest.MinBet ELSE cs.MinBet END AS MinBet, 
		CASE 
			WHEN cs.MinBet = 0  AND cs.MaxBet = 0  THEN cs.MaxBet
			WHEN cs.MinBet = 0  AND cs.MaxBet = 0.1  THEN cs.MaxBet
			WHEN cs.MaxBet > dest.MaxBet   THEN dest.MaxBet ELSE cs.MaxBet END AS MaxBet,  
		0 as MaxPerMatch	
	FROM dbo.CustBetSetting3rd_Agent cs WITH(NOLOCK)
		INNER JOIN #SMATemp ci WITH(NOLOCK) ON ci.CustID = cs.CustID 
		CROSS APPLY #DestinationSportBetType dest 
	WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType
		AND dest.SettingType = 20

	--Member Level
	INSERT INTO dbo.CustBetSetting3rd_Member(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)	      
	SELECT cs.CustID, dest.tSportType, dest.tBetType, 
		CASE 
			WHEN cs.MinBet = 0  AND cs.MaxBet = 0  THEN cs.MinBet
			WHEN cs.MinBet = 0  AND cs.MaxBet = 0.1  THEN cs.MinBet
			WHEN cs.MinBet < dest.MinBet   THEN dest.MinBet ELSE cs.MinBet END AS MinBet, 
		CASE 
			WHEN cs.MinBet = 0  AND cs.MaxBet = 0  THEN cs.MaxBet
			WHEN cs.MinBet = 0  AND cs.MaxBet = 0.1  THEN cs.MaxBet
			WHEN cs.MaxBet > dest.MaxBet   THEN dest.MaxBet ELSE cs.MaxBet END AS MaxBet, 
		0 as MaxPerMatch	
	FROM dbo.CustBetSetting3rd_Member cs WITH(NOLOCK)
		INNER JOIN #MemberTemp ci WITH(NOLOCK) ON ci.CustID = cs.CustID 
		CROSS APPLY #DestinationSportBetType dest 
	WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType
		AND dest.SettingType = 20
	------------------------------------------------------------------------------------------------	
		
	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
	DROP TABLE #DestinationSportBetType	

END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
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
	AND ci.currency IN (20,72)

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

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
GO


-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

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
	AND ci.currency IN (20,72)

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

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
