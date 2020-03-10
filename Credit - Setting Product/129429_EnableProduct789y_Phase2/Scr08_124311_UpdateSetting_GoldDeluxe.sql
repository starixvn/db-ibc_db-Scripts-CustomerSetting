/*
	Created: Elodie	
	Task: Enable Product Status for all disabled customers under 789y Headline - RedmineID: #124311
	DB: DBCUST/CustDB
	Date: 20200221
*/ 
--	Gold Deluxe
ALTER PROCEDURE [dbo].[Acc_CustSetting_17]
	@srecommend INT	
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF dbo.f_CheckRepTable('CustGameType') = 0 RETURN
	
	DECLARE @Currency INT
	SELECT @Currency = currency FROM customer WITH (NOLOCK) WHERE custid = @srecommend

	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		IsDisable BIT,
		IsFinishedStakeLevel BIT DEFAULT(0)
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		roleid TINYINT,
		IsDisable BIT
	)	

	INSERT INTO #SMATemp (CustID, roleid, IsDisable)
	SELECT DISTINCT ci.custid, roleid, ci.DisableGoldDeluxe
	FROM Custinfo ci WITH (NOLOCK)
	WHERE srecommend = @srecommend 
		AND roleid IN (2,3,4) 
		AND Enabled = 1 
	
	INSERT INTO #MemberTemp (CustID, IsDisable)
	SELECT DISTINCT ci.custid, ci.DisableGoldDeluxe
	FROM Custinfo ci WITH (NOLOCK)
	WHERE srecommend = @srecommend 
		AND roleid = 1  
		AND Enabled = 1 

	CREATE TABLE #CustGameTypeMaster
	(
		CustID INT NOT NULL,
		GameTypeID INT NOT NULL,
		StakeLevelList VARCHAR(100) NULL
	)

	CREATE CLUSTERED INDEX CIX_CustGameType ON #CustGameTypeMaster (CustId, GameTypeId)	


	----------------------------------------Stake Level------------------------------------
	DECLARE @MemberBatchStakeLevel TABLE(CustId INT, IsDisable BIT)
	--Update super
	UPDATE cs
	SET cs.StakeLevelList = T1.LowestUpline
	FROM CustGameType cs WITH (ROWLOCK)
		INNER JOIN #SMATemp s ON s.CustID = cs.CustID
		CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS LowestUpline
					FROM StakeLevel SL WITH(NOLOCK)
					WHERE SL.ExchangeId = @Currency AND SL.GameTypeID = cs.GameTypeID
					ORDER BY MinStake, MaxStake ASC
					) T1 -- Direct Upline
	WHERE cs.CustID = @srecommend
		AND cs.GameTypeID IN (1701,1702)
		AND (cs.StakeLevelList IS NULL OR cs.StakeLevelList = '' OR s.IsDisable = 1)

	--Update master
	UPDATE cs
	SET cs.StakeLevelList = T1.LowestUpline
	FROM CustGameType cs WITH (ROWLOCK)
		INNER JOIN #SMATemp m ON m.CustID = cs.CustID
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cs.CustID
		INNER JOIN CustGameType css ON ci.srecommend = css.CustID AND cs.GameTypeID = css.GameTypeID	 		
		CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS LowestUpline
					FROM (SELECT CAST(val AS INT) AS val
						  FROM dbo.strSplit(css.StakeLevelList,','))  CD
							INNER JOIN dbo.StakeLevel SL WITH(NOLOCK) ON CD.val = SL.StakeLevelID
						ORDER BY MinStake, MaxStake ASC
					) T1 -- Direct Upline
	WHERE m.roleid = 3
		AND css.CustID = @srecommend
		AND cs.GameTypeID IN (1701,1702)
		AND (cs.StakeLevelList IS NULL OR cs.StakeLevelList = '' OR m.IsDisable = 1)

	INSERT INTO #CustGameTypeMaster (CustID, GameTypeId, StakeLevelList)
	SELECT ci.custid, GameTypeId, cs.StakeLevelList
	FROM #SMATemp ci WITH (NOLOCK)
		INNER JOIN dbo.CustGameType cs WITH (NOLOCK) ON cs.CustID = ci.custid
	WHERE roleid = 3
		AND cs.GameTypeID IN (1701,1702)

	--Update agent
	UPDATE cs
	SET cs.StakeLevelList = T1.LowestUpline
	FROM CustGameType cs WITH (ROWLOCK)
		INNER JOIN #SMATemp a ON a.CustID = cs.CustID
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cs.CustID
		INNER JOIN #CustGameTypeMaster csm ON ci.mrecommend = csm.CustID AND cs.GameTypeID = csm.GameTypeID	 		
		CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS LowestUpline
					FROM (SELECT CAST(val AS INT) AS val
						  FROM dbo.strSplit(csm.StakeLevelList,','))  CD
							INNER JOIN dbo.StakeLevel SL WITH(NOLOCK) ON CD.val = SL.StakeLevelID
						ORDER BY MinStake, MaxStake ASC
					) T1 -- Direct Upline
	WHERE a.roleid = 2
		AND cs.GameTypeID IN (1701,1702)
		AND (cs.StakeLevelList IS NULL OR cs.StakeLevelList = '' OR a.IsDisable = 1)

	WHILE(1=1)
	BEGIN
		UPDATE TOP (5000) t 		 
		SET t.IsFinishedStakeLevel = 1
		OUTPUT INSERTED.CustID, INSERTED.IsDisable INTO @MemberBatchStakeLevel(CustId, IsDisable)
		FROM #MemberTemp t
		WHERE IsFinishedStakeLevel = 0
	 
		IF @@ROWCOUNT = 0
			BREAK

		--Update member
		UPDATE cs
		SET cs.StakeLevelList = T1.LowestUpline
		FROM dbo.CustGameType cs WITH (ROWLOCK)
			INNER JOIN @MemberBatchStakeLevel mem ON mem.CustID = cs.CustID
			INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cs.CustID
			INNER JOIN CustGameType csa ON ci.recommend = csa.CustID AND cs.GameTypeID = csa.GameTypeID 		
			CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS LowestUpline
						FROM (SELECT CAST(val AS INT) AS val
								FROM dbo.strSplit(csa.StakeLevelList,','))  CD
								INNER JOIN dbo.StakeLevel SL WITH(NOLOCK) ON CD.val = SL.StakeLevelID
							ORDER BY MinStake, MaxStake ASC
						) T1 -- Direct Upline
		WHERE cs.GameTypeID IN (1701,1702)
			AND (cs.StakeLevelList IS NULL OR cs.StakeLevelList = '' OR mem.IsDisable = 1)
		
		DELETE @MemberBatchStakeLevel
	END
	
	--Drop all temp tables
	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
END
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
--Create Supers temp table:
DECLARE @max_custid INT, @srecommend INT

--SELECT @max_custid = xxx

CREATE TABLE #supers (custid int,isfinished bit default(0))

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN custInfo C WITH (NOLOCK) ON C.custid = ci.custid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND ci.site IN ('789y')
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND Enabled = 1 

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

	EXEC dbo.Acc_CustSetting_17 
			@srecommend = @srecommend
			--,@maxcustid = @max_custid
			,@target = 'REPLICATED'
						
	WAITFOR DELAY '00:00:0.1'
END

--Drop all temp tables
DROP TABLE #supers
GO

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 4: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
DECLARE @max_custid INT, @srecommend INT

--SELECT @max_custid = xxx

CREATE TABLE #supers (custid int,isfinished bit default(0))

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN custInfo C WITH (NOLOCK) ON C.custid = ci.custid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND ci.site IN ('789y')
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND Enabled = 1
			
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

	EXEC dbo.Acc_CustSetting_17 
		@srecommend = @srecommend
		--,@maxcustid = @max_custid
		,@target = 'DBCUST'
						
	WAITFOR DELAY '00:00:0.1'
END
PRINT N'Step 4: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

--Drop all temp tables
DROP TABLE #supers
GO
