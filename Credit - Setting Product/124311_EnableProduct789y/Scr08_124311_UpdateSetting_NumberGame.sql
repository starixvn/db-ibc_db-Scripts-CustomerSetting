/*
	Created: Elodie	
	Task: Enable Product Status for all disabled customers under 789y Headline - RedmineID: #124311
	DB: DBCUST/CustDB
	Date: 20200221
*/ 
--	Number Game & Happy 5
ALTER PROCEDURE [dbo].[Acc_CustSetting_16]
	@srecommend INT	
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	
	DECLARE @MinBetDefault SMALLMONEY, @MaxBetDefault SMALLMONEY, @MaxPerMatchDefault SMALLMONEY, @MaxPerBallDefault SMALLMONEY
	SELECT @MinBetDefault = 3, @MaxBetDefault = 500, @MaxPerMatchDefault = 2000, @MaxPerBallDefault = 1000

	CREATE TABLE #DownlineTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		IsDisable BIT,
		MaxPerMatch161 SMALLMONEY,
		MaxPerMatch164 SMALLMONEY,
		MaxPerBall161 SMALLMONEY,
		IsFinishedBetLimit BIT DEFAULT(0)
	)

	INSERT INTO #DownlineTemp (CustID, IsDisable, MaxPerMatch161, MaxPerMatch164, MaxPerBall161)
	SELECT ci.custid, ci.DisableNumber, ci.maxpermatch161, ci.maxpermatch164, ci.MaxPerBall161
	FROM Custinfo ci WITH (NOLOCK)
	WHERE srecommend = @srecommend 
		AND Enabled = 1 

	----------------------------------------BetSetting------------------------------------
	DECLARE @MemberBatchBetSetting TABLE(CustId INT, IsDisable BIT, MaxPerMatch161 SMALLMONEY, MaxPerMatch164 SMALLMONEY, MaxPerBall161 SMALLMONEY)

	WHILE(1=1)
	BEGIN
		UPDATE TOP (5000) t 		 
		SET t.IsFinishedBetLimit = 1
		OUTPUT INSERTED.CustID, INSERTED.IsDisable, INSERTED.MaxPerMatch161, INSERTED.MaxPerMatch164, INSERTED.MaxPerBall161 INTO @MemberBatchBetSetting
		FROM #DownlineTemp t
		WHERE IsFinishedBetLimit = 0
	 
		IF @@ROWCOUNT = 0
			BREAK

		UPDATE ci 
		FROM dbo.custInfo ci WITH (ROWLOCK)
			INNER JOIN dbo.CustSetting3rd cs WITH (ROWLOCK) ON cs.custid = ci.custid AND cs.sporttype IN (161,164)
			INNER JOIN @MemberBatchBetSetting mem ON mem.CustID = cs.custid
		WHERE mem.IsDisable = 1
			OR (cs.sporttype = 161 AND (cs.minbet < 1 OR cs.maxbet < 1 OR mem.MaxPerMatch161 < 1 OR mem.MaxPerBall161 < 1))
			OR (cs.sporttype = 164 AND (cs.minbet < 1 OR cs.maxbet < 1 OR mem.MaxPerMatch164 < 1))

		UPDATE cs
		SET cs.MinBet = @MinBetDefault,
			cs.MaxBet = @MaxBetDefault
		FROM dbo.CustSetting3rd cs WITH (ROWLOCK) 
			INNER JOIN @MemberBatchBetSetting mem ON mem.CustID = cs.custid
		WHERE mem.IsDisable = 1
			OR (cs.sporttype = 161 AND (cs.minbet < 1 OR cs.maxbet < 1 OR mem.MaxPerMatch161 < 1 OR mem.MaxPerBall161 < 1))
			OR (cs.sporttype = 164 AND (cs.minbet < 1 OR cs.maxbet < 1 OR mem.MaxPerMatch164 < 1))
		
		DELETE @MemberBatchBetSetting
	END
	
	--Drop all temp tables
	DROP TABLE #DownlineTemp
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

	EXEC dbo.Acc_CustSetting_16 
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

	EXEC dbo.Acc_CustSetting_16 
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
