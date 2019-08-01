/*
	Created by: Eden
	Date: 2019-07-24
	Task: Hide ColossusBet
*/ 
---------------------------------------------------------------
-- BEGIN STEP 1: Deploy this SP at DBCUST.CustDB
------------------------------------------------------
ALTER PROCEDURE [dbo].Acc_CustomerInfo_Execrep_19
	 @target VARCHAR(20)	
	,@srecommend INT
AS
BEGIN
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
				
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN
	
	CREATE TABLE #TempCust(CustID INT PRIMARY KEY)

	-->Hide ColossusBet
	WHILE(1=1)
	BEGIN
		TRUNCATE TABLE #TempCust

		INSERT INTO  #TempCust(CustID)
		SELECT TOP (5000) custid
		FROM Custinfo WITH (NOLOCK)
		WHERE srecommend = @srecommend
			  AND HideColossusBet = 0

		IF @@ROWCOUNT = 0
			BREAK;

		-->Hide ColossusBet
		UPDATE c
		SET HideColossusBet = 1
		FROM Custinfo c WITH(ROWLOCK)
			JOIN #TempCust tmp ON c.custid = tmp.CustID

	END

	
	DROP TABLE #TempCust
END
GO

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------

-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
-----------------------------------------------------------------------------------	
BEGIN
	DECLARE @srecommend INT
	CREATE TABLE #Supers(CustID INT PRIMARY KEY,isfinished bit default(0))
	
	INSERT INTO #Supers(custid)
	SELECT ci.custid 
	FROM dbo.customer c WITH (NOLOCK) 
		INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
		INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
	WHERE ci.roleid = 4
		AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))	
		AND s.islicensee = 0
		AND ci.custid IN ( SELECT srecommend FROM custinfo WITH(NOLOCK) WHERE HideColossusBet = 0 )

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

		EXEC dbo.Acc_CustomerInfo_Execrep_19 
				 @srecommend = @srecommend
				,@target = 'REPLICATED'
						
		WAITFOR DELAY '00:00:0.100'
	END

	PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
	DROP TABLE #Supers
END
GO

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------	
BEGIN
	DECLARE @srecommend INT
	CREATE TABLE #Supers(CustID INT PRIMARY KEY,isfinished bit default(0))
	
	INSERT INTO #Supers(custid)
	SELECT ci.custid 
	FROM dbo.customer c WITH (NOLOCK) 
		INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
		INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
	WHERE ci.roleid = 4
		AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))	
		AND s.islicensee = 0
		AND ci.custid IN ( SELECT srecommend FROM custinfo WITH(NOLOCK) WHERE HideColossusBet = 0 )

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

		EXEC dbo.Acc_CustomerInfo_Execrep_19 
				 @srecommend = @srecommend
				,@target = 'DBCUST'
						
		WAITFOR DELAY '00:00:0.200'
	END

	PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
	DROP TABLE #Supers
END
GO
-- END STEP 3: RUN THIS SCRIPT AT DBCUST SERVER  -----
-----------------------------------------------------------------------------------	
