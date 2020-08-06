/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: Winfred
	Task:  Initialize Stake PG [PG Game] RedmineID:#137763
	DB: DBCust/CustDB
*/
ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09]
	@Custid INT
	,@maxcustid INT
	,@target VARCHAR(20)

AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('StakeLevel') = 1
	   AND dbo.f_CheckRepTable('StakeLevelGroupDetail') = 1
	   AND dbo.f_CheckRepTable('CustStakeLevel_Agent') = 1
	   AND dbo.f_CheckRepTable('CustStakeLevel_Member') = 1
	   )
		RETURN
			
	CREATE TABLE #CustListAgent (CustID INT PRIMARY KEY)
	CREATE TABLE #CustListMember (CustID INT PRIMARY KEY CLUSTERED,isfinished BIT DEFAULT(0))
		
	DECLARE @GameTypeID	 INT,@GameGroupID INT,@SportType SMALLINT,@Currency INT,@StakeLevelID INT
	SELECT @GameTypeID = 6001,@SportType = 232 
	SELECT @currency = ci.currency FROM dbo.custInfo ci WITH (NOLOCK) WHERE ci.custid = @Custid
	
	SELECT @StakeLevelID = sl.StakeLevelID 
	FROM dbo.StakeLevel sl WITH (NOLOCK) 
	WHERE sl.GameTypeID = GameTypeID
		AND sl.GameGroupID = @GameGroupID
		AND sl.ExchangeId = @Currency
	
	INSERT INTO #CustListAgent(CustID)
	SELECT custid
	FROM dbo.custInfo ci WITH (NOLOCK)
	WHERE ci.srecommend = @Custid
		AND ci.Enabled = 1
		AND ci.roleid in (2,3,4)
		AND ci.custid <= @maxcustid
	
	INSERT INTO #CustListMember(CustID)
	SELECT custid
	FROM dbo.custInfo ci WITH (NOLOCK)
	WHERE ci.srecommend = @Custid AND ci.Enabled = 1 AND ci.roleid = 1	AND ci.custid <= @maxcustid 
	--------------------------------- BetSetting ---------------------------------
	INSERT INTO dbo.CustStakeLevel_Agent  ([CustID]
										   ,[SportType]
										   ,[BetType]
										   ,[StakeLevelList])
	SELECT CustID , @SportType,@GameTypeID,@StakeLevelID as [StakeLevelList]
	FROM #CustListAgent 

	DECLARE @Cust_Temp TABLE(CustID INT)
	DECLARE @BatchSize SMALLINT = 5000
	
	WHILE(1 =1)
	BEGIN
		UPDATE TOP (@BatchSize) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID INTO @Cust_Temp(CustID)
		FROM #CustListMember c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0
		BEGIN 
			BREAK
		END 	
			
		INSERT INTO dbo.CustStakeLevel_Member([CustID]
										   ,[SportType]
										   ,[BetType]
										   ,[StakeLevelList]
										   ,LastUpdated) 
		SELECT CustID , @SportType,@GameTypeID,@StakeLevelID as [StakeLevelList],GETDATE() as LastUpdated
		FROM @Cust_Temp	
		
		DELETE FROM @Cust_Temp
	END
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
	FROM customer ci WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
		LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.roleid = 4  
			AND ci.username NOT LIKE '3rdSuper%'
			AND cs.isinternal = 0
			AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
			AND s.islicensee = 0
			AND ci.custid <= @max_custid
			AND ci.Site IN ('755555','IBCIndo','Indo','KORIBC','789y')
			AND ci.currency IN (15 --IN
								,22 --IND
								,33 --IDD
								,34 --IDR
								,47 --DDD
								,45 --Won
								,4  --TB
								,43 --THB
								,95 --USD
								,3 --US$
								,16 --Yen
								,64 --UT
							)

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

		EXEC dbo.Acc_DynamicCustomerInfo_09 @custid = @srecommend
				,@maxcustid = @max_custid
				,@target = 'REPLICATED'
				
				
		waitfor delay '00:00:0.280'
	END
	GO

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
	PRINT N'Step 3: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

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
			AND ci.Site IN ('755555','IBCIndo','Indo','KORIBC','789y')
			AND ci.currency IN (15 --IN
								,22 --IND
								,33 --IDD
								,34 --IDR
								,47 --DDD
								,45 --Won
								,4  --TB
								,43 --THB
								,95 --USD
								,3 --US$
								,16 --Yen
								,64 --UT
							)

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

		EXEC dbo.Acc_DynamicCustomerInfo_09 @custid = @srecommend
				,@maxcustid = @max_custid
				,@target = 'DBCUST'
							
		waitfor delay '00:00:0.280'
	END

	PRINT N'Step 3: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

