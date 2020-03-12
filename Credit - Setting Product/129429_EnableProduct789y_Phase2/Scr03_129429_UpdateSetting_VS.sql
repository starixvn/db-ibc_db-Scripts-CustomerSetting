/*
	Created: Tiara	
	Task: Update betsetting for customers under 789y Headline - RedmineID: #129429
	DB: DBCUST/CustDB
	Date: 20200310
*/
--	Virtual Sports
ALTER PROCEDURE [dbo].[Acc_CustSetting_13]
	@srecommend INT	
	,@ProductId TINYINT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
	
	DECLARE @BitmapOrder TINYINT, @Currency INT, @MinBetDefault SMALLMONEY, @MaxBetDefault SMALLMONEY, @MaxPerMatchDefault SMALLMONEY
	SELECT @MinBetDefault = 3, @MaxBetDefault = 500, @MaxPerMatchDefault = 2000

	SELECT @Currency = currency FROM customer WITH (NOLOCK) WHERE custid = @srecommend

	SELECT @BitmapOrder = ps.bitmapOrder
	FROM dbo.ProductStatusProfile ps WITH (NOLOCK) 
		INNER JOIN dbo.ProductSettingDetail psd WITH (NOLOCK) ON psd.SportType = ps.Sporttype AND psd.BetType = ps.Bettype
	WHERE psd.ProductID = @ProductId AND psd.SettingType = 13

	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		IsFinishedBetLimit BIT DEFAULT(0)

	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		roleid TINYINT
	)

	SELECT t.* 
	INTO #SportBettypeFilter2
	FROM ProductSettingDetail t WITH (NOLOCK)
	WHERE t.SettingType = 2 AND t.ProductID = @ProductID

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

	----------------------------------------BetSetting------------------------------------
	DECLARE @MemberBatchBetSetting TABLE(CustId INT)

	UPDATE cs
	SET cs.MinBet = @MinBetDefault,
		cs.MaxBet = @MaxBetDefault,
		cs.MaxPerMatch = @MaxPerMatchDefault
	FROM dbo.CustBetSetting3rd_Agent cs WITH (ROWLOCK) 
		INNER JOIN #SMATemp sma ON sma.CustID = cs.custid
		INNER JOIN #SportBettypeFilter2 ft WITH (NOLOCK) ON ft.SportType = cs.SportType AND ft.BetType = cs.BetType 
	WHERE cs.MaxBet < 1 OR cs.MaxPerMatch < 1 
	
	WHILE(1=1)
	BEGIN
		UPDATE TOP (5000) t 		 
		SET t.IsFinishedBetLimit = 1
		OUTPUT INSERTED.CustID INTO @MemberBatchBetSetting
		FROM #MemberTemp t
		WHERE IsFinishedBetLimit = 0
	 
		IF @@ROWCOUNT = 0
			BREAK

		UPDATE cs
		SET cs.MinBet = @MinBetDefault,
			cs.MaxBet = @MaxBetDefault,
			cs.MaxPerMatch = @MaxPerMatchDefault
		FROM dbo.CustBetSetting3rd_Member cs WITH (ROWLOCK) 
			INNER JOIN @MemberBatchBetSetting mem ON mem.CustID = cs.custid
			INNER JOIN #SportBettypeFilter2 ft WITH (NOLOCK) ON ft.SportType = cs.SportType AND ft.BetType = cs.BetType 
		WHERE cs.MaxBet < 1 OR cs.MaxPerMatch < 1 
		
		DELETE @MemberBatchBetSetting
	END
	
	--Drop all temp tables
	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
	DROP TABLE #SportBettypeFilter2
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

	EXEC dbo.Acc_CustSetting_13 
			@srecommend = @srecommend
			,@ProductId = 5
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

	EXEC dbo.Acc_CustSetting_13 
		@srecommend = @srecommend
		,@ProductId = 5
		--,@maxcustid = @max_custid
		,@target = 'DBCUST'
						
	WAITFOR DELAY '00:00:0.1'
END
PRINT N'Step 4: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

--Drop all temp tables
DROP TABLE #supers
GO
