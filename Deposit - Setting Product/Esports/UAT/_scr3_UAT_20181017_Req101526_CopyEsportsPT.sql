/*
	Created: Winnie
	Task: Copy PT & Bet setting for Esports Deposit RedmineID: #101526
	DB: DBCUST/CustDB
	Date: 20181011
*/ 

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@srecommend INT	
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustSettingMode') = 0 RETURN		
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN

	DECLARE @fSportType INT = 99, @fBetType INT=1
	DECLARE @Sporttype	INT = 43, @PT SMALLMONEY,@PTGroup SMALLMONEY
	DECLARE @Site VARCHAR(10),@Currency INT	
	
	SELECT @Site=Site FROM Customer WITH(NOLOCK) WHERE custid=@srecommend	
	IF @Site='Haifa'
	BEGIN
		SELECT @PT=90.5
		SELECT @PTGroup=90.5
	END
	ELSE IF @Site='Asiabet88' AND @currency IN(3,6) 
	BEGIN
		SELECT @PTGroup=0
		SELECT @PT=85
	END
	ELSE 
	BEGIN
		SELECT @PT=85
		SELECT @PTGroup=85
	END

	--------------------------------------PT Setting-------------------------------------------------	

	CREATE TABLE #Dummy (CustID INT PRIMARY KEY)	
	CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY,MaxPerMatch MONEY)
	CREATE TABLE #tmpCustInsert		(CustID INT PRIMARY KEY,MaxPerMatch MONEY)	

	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend=@srecommend AND roleid=3 AND (username LIKE '%Acc%' OR username LIKE '%Cas%' OR username LIKE '%LocalBank%')
		AND custid<=@maxcustid 

	INSERT INTO #tmpCust(CustID,MaxPerMatch)
	SELECT CustID,maxpermatch99
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend = @srecommend AND ci.custid<=@maxcustid 
		AND roleid = 1 
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	--AGENT LEVEL	
	INSERT INTO dbo.Dep_CustPTSetting_Agent
		(	[CustID]
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		 )
	SELECT 
			[CustID]
		   ,@Sporttype
		   ,@fBetType
		   ,0
		   ,@PT
		   ,@PT
		   ,@PT
	FROM Customer WITH(NOLOCK)
	WHERE custid=@srecommend
	
	INSERT INTO dbo.Dep_CustPTSetting_Agent
		(	[CustID]
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		 )
	SELECT 
			[CustID]
		   ,@Sporttype
		   ,@fBetType
		   ,0
		   ,0
		   ,@PT
		   ,0	
	FROM Customer WITH(NOLOCK)
	WHERE srecommend=@srecommend AND roleid=3 AND custid<=@maxcustid 
		AND custid NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO dbo.Dep_CustPTSetting_Agent
		(	[CustID]
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		 )
	SELECT 
			[CustID]
		   ,@Sporttype
		   ,@fBetType
		   ,0
		   ,0
		   ,0
		   ,@PT
	FROM Customer WITH(NOLOCK)
	WHERE srecommend=@srecommend AND roleid=2 AND custid<=@maxcustid 
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO dbo.Dep_CustPTGroupSetting_Member
		(	AgentID
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		 )
	SELECT 
			[CustID]
		   ,@Sporttype
		   ,@fBetType
		   ,0
		   ,0
		   ,0
		   ,@PTGroup
	FROM Customer WITH(NOLOCK)
	WHERE srecommend=@srecommend AND roleid=2 AND custid<=@maxcustid 
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
		SELECT t.CustID,1
	FROM Customer t WITH(NOLOCK)
	WHERE srecommend=@srecommend 
		AND custid<=@maxcustid 
		AND roleid=1 AND NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode WITH(NOLOCK) WHERE CustID=t.CustID)
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	
	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT @srecommend,24

	--------------------------------------Bet Setting-------------------------------------------------		

	--Agent Level
	INSERT INTO dbo.Dep_CustBetSetting_Agent(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)	
	SELECT 
		ci.CustID			,		
		@Sporttype			,
		@fBetType			,		
		MinBet				,
		MaxBet				,
		maxpermatch99			
	FROM custInfo ci WITH(NOLOCK)
		 INNER JOIN dbo.Dep_custSetting cs WITH(NOLOCK) ON ci.custid=cs.custid
	WHERE ci.srecommend = @srecommend AND ci.custid<=@maxcustid AND cs.sporttype=@fSportType AND cs.bettype=@fBetType	
		AND roleid IN(2,3,4)
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)	

	--Member Level
	WHILE EXISTS(SELECT 1 FROM #tmpCust)
	BEGIN
		DELETE TOP (3000) #tmpCust OUTPUT DELETED.* INTO #tmpCustInsert
	--Member Level
		INSERT INTO dbo.Dep_CustBetSetting_Member(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)			
		SELECT 
			ci.CustID			,	
			@Sporttype			,
			@fBetType			,		
			MinBet				,
			MaxBet				,
			maxpermatch			
		FROM #tmpCustInsert ci WITH(NOLOCK)
			 INNER JOIN dbo.Dep_custSetting cs WITH(NOLOCK) ON ci.custid=cs.custid
		WHERE cs.sporttype=@fSportType AND cs.bettype=@fBetType	
		
		TRUNCATE TABLE #tmpCustInsert
	END
		
	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT @srecommend,25

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
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND cs.site IN ('spondemo','Athena000')

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
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND cs.site IN  ('spondemo','Athena000')

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
