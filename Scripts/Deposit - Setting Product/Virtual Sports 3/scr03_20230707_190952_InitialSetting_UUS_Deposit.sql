/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20230707
	Task: Insert setting for Virtual Sports 3 DEPOSIT - UUS [Redmine: #190952]
	DB: DBCust/CustDB
*/

-- BEGIN STEP 1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
-----------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	 @srecommend INT		
	,@target VARCHAR(20)
	,@max_custid INT
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbcust only

	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustSettingMode') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductStatusProfile') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 RETURN

	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED
		,currency INT
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED
		,roleid	TINYINT
		,currency INT
	)
	
	CREATE TABLE #Dummy(CustID INT PRIMARY KEY)

	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend = @srecommend AND roleid = 3 
		AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
		AND custid <= @max_custid 

	INSERT INTO #MemberTemp(CustID, currency)
	SELECT custid, currency
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1  AND Enabled = 1 AND custid <= @max_custid
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	
	INSERT INTO #SMATemp(CustID, roleid, currency)
	SELECT custid, roleid, currency
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND Enabled = 1 AND custid <= @max_custid
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	
	DECLARE 	@SportType	SMALLINT = 178, 
				@BetType	SMALLINT = 5302,
				@fSportType	SMALLINT = 190,
				@fBettype	SMALLINT = 2701,
				@BitMapOrder TINYINT
	
	SELECT @BitMapOrder = bitmapOrder
	FROM Dep_ProductStatusProfile WITH (NOLOCK)
	WHERE Sporttype = @SportType AND Bettype = @BetType

	--------------------------------------------Product Status------------------------------------------------
	CREATE TABLE #AllUsers(CustID int PRIMARY KEY)
	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY, bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY, bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	
	INSERT INTO #AllUsers (CustID)
	SELECT DISTINCT SMA.CustID FROM #SMATemp SMA WITH (NOLOCK)
	UNION 
	SELECT DISTINCT M.CustID FROM #MemberTemp M WITH (NOLOCK)

	INSERT INTO #Dep_CustProductStatus(CustID, bitmapIsHidden, bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsHidden = dbo.f_GenerateProductStatus(c.bitmapIsHidden, @BitMapOrder, 0)
		,bitmapIsDisabled = dbo.f_GenerateProductStatus(c.bitmapIsDisabled, @BitMapOrder, 0)
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN  #SMATemp temp ON temp.CustID = c.custid
	UNION ALL
	SELECT c.CustID
		,bitmapIsHidden = dbo.f_GenerateProductStatus(c.bitmapIsHidden, @BitMapOrder, 0)
		,bitmapIsDisabled = dbo.f_GenerateProductStatus(c.bitmapIsDisabled, @BitMapOrder, 0)
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN  #MemberTemp temp ON temp.CustID = c.custid

	DECLARE @batch INT = 3000
	WHILE 1 = 1 
	BEGIN
		TRUNCATE TABLE #TempProductStatus

		DELETE TOP (@batch) a
		OUTPUT deleted.CustID, deleted.bitmapIsHidden, deleted.bitmapIsDisabled INTO #TempProductStatus(CustID, bitmapIsHidden, bitmapIsDisabled)
		FROM #Dep_CustProductStatus a 

		IF @@ROWCOUNT = 0 
			BREAK;

		UPDATE c 
		SET  c.bitmapIsHidden = tmp.bitmapIsHidden
			,c.bitmapIsDisabled = tmp.bitmapIsDisabled
		FROM Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
			INNER JOIN #TempProductStatus tmp ON c.CustID = tmp.CustID

		WAITFOR DELAY '00:00:00.100'
	END

	INSERT INTO Dep_CustProductStatus(CustID, bitmapIsDisabled, bitmapIsHidden)
	SELECT	A.custid
			, dbo.f_GenerateProductStatus(0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitMapOrder, 0) AS bitmapIsDisabled
			, dbo.f_GenerateProductStatus(0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitMapOrder, 0)  AS bitmapIsHidden
	FROM #AllUsers A WITH (NOLOCK)
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = A.CustID)

	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid = @srecommend AND ProductSettingID = 168)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID, ProductSettingID)
		SELECT @srecommend, 168
	END

	------------------------------------PT Setting-------------------------------------------------	
	--SMA LEVEL
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
			 d.[CustID]
			,@SportType
			,@BetType	
			,cs.IsLive
			,cs.SuperPT
			,cs.MasterPT
			,cs.AgentPT
	FROM #SMATemp d WITH (NOLOCK)
		INNER JOIN Dep_CustPTSetting_Agent cs WITH (NOLOCK) ON cs.CustID = d.CustID
	WHERE cs.SportType = @fSportType AND cs.BetType = @fBettype

	----MEMBER LEVEL
	INSERT INTO dbo.Dep_CustPTSetting_Member
		(	    [custid]
			,	[sporttype]
			,	[bettype]
			,	[islive]
			,	[superPT]
			,	[masterPT]
			,	[agentPT]
		)
	SELECT 
			 d.[CustID]
			,@SportType
			,@BetType
			,cs.IsLive
			,cs.SuperPT
			,cs.MasterPT
			,cs.AgentPT
	FROM #MemberTemp d WITH (NOLOCK)
		INNER JOIN Dep_CustPTSetting_Member cs WITH (NOLOCK) ON cs.CustID = d.CustID
		INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON d.CustID = m.CustID
	WHERE m.IsGroupedPT = 0
		AND cs.SportType = @fSportType AND cs.BetType = @fBettype

	INSERT INTO Dep_CustPTGroupSetting_Member (
		 AgentID
		,SportType
		,BetType
		,IsLive
		,SuperPT
		,MasterPT
		,AgentPT
	)
	SELECT d.[CustID]
		,@SportType
		,@BetType
		,cs.IsLive
		,cs.SuperPT
		,cs.MasterPT
		,cs.AgentPT
	FROM #SMATemp d
		INNER JOIN Dep_CustPTGroupSetting_Member cs WITH (NOLOCK) ON cs.AgentID = d.CustID
	WHERE d.roleid = 2
		AND cs.SportType = @fSportType AND cs.BetType = @fBettype

	INSERT INTO Dep_CustSettingMode(CustID, IsGroupedPT)
	SELECT t.CustID, 1
	FROM #MemberTemp t WITH(NOLOCK) 
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode D WITH (NOLOCK) WHERE D.CustID = t.CustID)
		AND NOT EXISTS (SELECT 1 FROM Dep_CustBAActive BA WITH (NOLOCK) WHERE BA.CustId = t.CustID)
	
	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID = 169)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID, ProductSettingID)
		SELECT @srecommend, 169
	END

	-------------------------------------------------BetSetting----------------------------------------------------------------
	INSERT INTO Dep_CustBetSetting_Agent(
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
	)
	SELECT t.CustID, @SportType, @BetType, 1, 10, 100
	FROM #SMATemp t

	INSERT INTO Dep_CustBetSetting_Member(
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
	)
	SELECT t.CustID, @SportType, @BetType, 1, 10, 100
	FROM #MemberTemp t

	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID = 170)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID, ProductSettingID)
		SELECT @srecommend, 170
	END

	DROP TABLE #MemberTemp
				, #SMATemp
				, #AllUsers
				, #Dep_CustProductStatus
				, #Dummy
				, #TempProductStatus
END
GO
-- END STEP 1: Deploy this SP @ DBCUST.CustDB -------
--------------------------------------------------------------------------------------

-- BEGIN STEP 2: Run this SP at DBCUST & all replicated servers -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

DECLARE @target NVARCHAR(20)

IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'
Print 'Server Name : ' + @target

CREATE TABLE #supers(custid int, isfinished bit default(0))

DECLARE @srecommend INT , @max_custid INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	INNER JOIN Dep_CustProductStatus s WITH (NOLOCK) ON ci.custid = s.CustID
	INNER JOIN Dep_CustPTSetting_Agent a WITH (NOLOCK) ON ci.custid = a.CustID
	CROSS APPLY f_CustSetting_ProductStatusSel(s.bitmapIsDisabled, 33) f		--VS3(Old) Status
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled = 1
	AND cs.site IN('spondemo','Athena000')										
	AND a.Sporttype = 190 AND a.Bettype = 2701									--VS2 PT
	AND f.value = 0
	AND ci.currency = 20


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

	EXEC dbo.Acc_Dep_DynamicCustSetting_09 @srecommend = @srecommend
			,@target = @target
			,@max_custid = @max_custid
						
	waitfor delay '00:00:00.280'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

DROP TABLE #supers
GO
-- END STEP 2: Run this SP at DBCUST & all replicated servers -----
-------------------------------------------------------------

