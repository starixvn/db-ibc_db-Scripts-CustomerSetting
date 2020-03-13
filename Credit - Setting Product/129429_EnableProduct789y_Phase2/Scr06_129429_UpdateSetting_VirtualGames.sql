/*
	Created: Tiara	
	Task: Update betsetting for customers under 789y Headline - RedmineID: #129429
	DB: DBCUST/CustDB
	Date: 20200310
*/ 
--	Virtual Games
ALTER PROCEDURE [dbo].[Acc_CustSetting_12]
	@srecommend INT	
	,@ProductId TINYINT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	
	DECLARE @Currency INT
	SELECT @Currency = currency FROM customer WITH (NOLOCK) WHERE custid = @srecommend

	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		IsFinishedStakeLevel BIT DEFAULT(0)

	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		roleid TINYINT
	)

	SELECT t.* 
	INTO #SportBettypeFilter7
	FROM ProductSettingDetail t WITH (NOLOCK)
	WHERE t.SettingType = 7 AND t.ProductID = @ProductID

	INSERT INTO #SMATemp (CustID, roleid)
	SELECT DISTINCT ci.custid, roleid
	FROM Custinfo ci WITH (NOLOCK)
	WHERE srecommend = @srecommend 
		AND roleid IN (2,3,4) 
		AND Enabled = 1 
	
	INSERT INTO #MemberTemp (CustID)
	SELECT DISTINCT ci.custid
	FROM Custinfo ci WITH (NOLOCK)
	WHERE srecommend = @srecommend 
		AND roleid = 1  
		AND Enabled = 1 

	----------------------------------------Stake Level-----------------------------------
	DECLARE @MemberBatchStakeLevel TABLE(CustId INT)
	--Update Super
	UPDATE cs
	SET cs.StakeLevelList = T1.LowestUpline
	FROM CustStakeLevel_Agent cs WITH (ROWLOCK)
		INNER JOIN #SMATemp s ON s.CustID = cs.CustID
		INNER JOIN #SportBettypeFilter7 ft WITH (NOLOCK) ON ft.SportType = cs.SportType AND ft.BetType = cs.BetType 
		CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS LowestUpline
					FROM StakeLevel SL WITH(NOLOCK)
					WHERE SL.ExchangeId = @Currency AND SL.GameTypeID = cs.BetType
					ORDER BY MaxStake, SL.MinStake, sl.GameGroupID
					) T1 -- Direct Upline
	WHERE cs.CustID = @srecommend
		AND (cs.StakeLevelList IS NULL OR cs.StakeLevelList = '' )
	
	--Update Master
	UPDATE cs
	SET cs.StakeLevelList = T1.LowestUpline
	FROM CustStakeLevel_Agent cs WITH (ROWLOCK)
		INNER JOIN #SportBettypeFilter7 ft WITH (NOLOCK) ON ft.SportType = cs.SportType AND ft.BetType = cs.BetType 
		INNER JOIN #SMATemp m ON m.CustID = cs.CustID
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cs.CustID
		INNER JOIN CustStakeLevel_Agent css ON ci.srecommend = css.CustID AND cs.SportType = css.SportType AND cs.BetType = css.BetType
		CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS LowestUpline
					FROM (SELECT CAST(val AS INT) AS val
						  FROM dbo.strSplit(css.StakeLevelList,','))  CD
							INNER JOIN dbo.StakeLevel SL WITH(NOLOCK) ON CD.val = SL.StakeLevelID
						ORDER BY MaxStake, SL.MinStake, sl.GameGroupID
					) T1 -- Direct Upline
	WHERE m.roleid = 3
		AND (cs.StakeLevelList IS NULL OR cs.StakeLevelList = '' )

	--Update Agent
	UPDATE cs
	SET cs.StakeLevelList = T1.LowestUpline
	FROM CustStakeLevel_Agent cs WITH (ROWLOCK)
		INNER JOIN #SportBettypeFilter7 ft WITH (NOLOCK) ON ft.SportType = cs.SportType AND ft.BetType = cs.BetType 
		INNER JOIN #SMATemp a ON a.CustID = cs.CustID
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cs.CustID
		INNER JOIN CustStakeLevel_Agent csm ON ci.mrecommend = csm.CustID AND cs.SportType = csm.SportType AND cs.BetType = csm.BetType	 		
		CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS LowestUpline
					FROM (SELECT CAST(val AS INT) AS val
						  FROM dbo.strSplit(csm.StakeLevelList,','))  CD
							INNER JOIN dbo.StakeLevel SL WITH(NOLOCK) ON CD.val = SL.StakeLevelID
						ORDER BY MaxStake, SL.MinStake, sl.GameGroupID
					) T1 -- Direct Upline
	WHERE a.roleid = 2
		AND (cs.StakeLevelList IS NULL OR cs.StakeLevelList = '')

	WHILE(1=1)
	BEGIN
		UPDATE TOP (5000) t 		 
		SET t.IsFinishedStakeLevel = 1
		OUTPUT INSERTED.CustID INTO @MemberBatchStakeLevel(CustId)
		FROM #MemberTemp t
		WHERE IsFinishedStakeLevel = 0
	 
		IF @@ROWCOUNT = 0
			BREAK

		--Update Member
		UPDATE cs
		SET cs.StakeLevelList = T1.LowestUpline
		FROM dbo.CustStakeLevel_Member cs WITH (ROWLOCK)
			INNER JOIN #SportBettypeFilter7 ft WITH (NOLOCK) ON ft.SportType = cs.SportType AND ft.BetType = cs.BetType 
			INNER JOIN @MemberBatchStakeLevel mem ON mem.CustID = cs.CustID
			INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cs.CustID
			INNER JOIN CustStakeLevel_Agent csa ON ci.recommend = csa.CustID AND cs.SportType = csa.SportType AND cs.BetType = csa.BetType	 	 		
			CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS LowestUpline
						FROM (SELECT CAST(val AS INT) AS val
								FROM dbo.strSplit(csa.StakeLevelList,','))  CD
								INNER JOIN dbo.StakeLevel SL WITH(NOLOCK) ON CD.val = SL.StakeLevelID
							ORDER BY MaxStake, SL.MinStake, sl.GameGroupID
						) T1 -- Direct Upline
		WHERE (cs.StakeLevelList IS NULL OR cs.StakeLevelList = '' )
		
		DELETE @MemberBatchStakeLevel
	END
	
	--Drop all temp tables
	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
	DROP TABLE #SportBettypeFilter7
END
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
--Create Supers temp table:
DECLARE @max_custid INT, @srecommend INT

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

	EXEC dbo.Acc_CustSetting_12 
			@srecommend = @srecommend
			,@ProductId = 38
			,@target = 'REPLICATED'
						
	WAITFOR DELAY '00:00:0.1'
END

--Drop all temp tables
DROP TABLE #supers
GO
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 3: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
DECLARE @max_custid INT, @srecommend INT

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

	EXEC dbo.Acc_CustSetting_12 
		@srecommend = @srecommend
		,@ProductId = 38
		,@target = 'DBCUST'
						
	WAITFOR DELAY '00:00:0.1'
END
PRINT N'Step 3: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

--Drop all temp tables
DROP TABLE #supers
GO
