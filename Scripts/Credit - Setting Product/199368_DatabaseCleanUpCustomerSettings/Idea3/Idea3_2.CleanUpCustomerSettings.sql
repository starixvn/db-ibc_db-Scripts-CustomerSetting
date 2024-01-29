/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240110@Helios
	Task: Collect Data To Temp Table [#199368]
		https://nexdev.net/issues/199368
	DB: DBCust/CustDB 
	-- RUN AT ALL REPLICATED SERVERS & DBCUST --
*/

------------------------------------------------------	
-- BEGIN: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST-----
----------------------------------------------------------------------------------------------
PRINT N'Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
PRINT N'--------------------------------------------------------'
----------------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

DECLARE	@max_custid		INT,
		@JsonData		VARCHAR(MAX),
		@BatchSize		INT = 3000,
		@ReadBatchSize	INT = 100000

SELECT @max_custid = 'xxxx'
	
CREATE TABLE #tblCustomer
	(
		  CustID		INT
		, SportType		SMALLINT
		, BetType		SMALLINT
	)

CREATE TABLE #tblCustomer_batch	
	(
		  CustID		INT
		, SportType		SMALLINT
		, BetType		SMALLINT
	)

CREATE TABLE #tblCust
	(
		  CustID		INT
	)

CREATE TABLE #tblCust_batch	
	(
		  CustID		INT
	)


DECLARE @__messageInfo VARCHAR(200), @__tableName VARCHAR(200)

BEGIN
	
	---- CustPTSetting3rd_Agent : Remark = 1
	SET @__tableName = 'CustPTSetting3rd_Agent'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #tblCustomer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM CustPTSetting3rd_Agent cs WITH (NOLOCK) 
			INNER JOIN Tmp_CleanUpCustomerSetting tcucs WITH (NOLOCK) ON cs.CustID = tcucs.CustID
		WHERE cs.custid <= @max_custid

		IF @@ROWCOUNT = 0
			BREAK

		--loop delete by batch
		WHILE 1 = 1
		BEGIN
			
			TRUNCATE TABLE #tblCustomer_batch

			DELETE TOP (@BatchSize) #tblCustomer
			OUTPUT deleted.CustID, deleted.SportType, deleted.BetType
			INTO #tblCustomer_batch(CustID, SportType, BetType)

			IF @@ROWCOUNT = 0 
				BREAK

			SELECT @JsonData=(	  SELECT	CustID , SportType, BetType
							  FROM	#tblCustomer_batch
							  FOR JSON PATH
							 )
	
			EXEC dbo.Acc_DynamicCustSetting3rd_19 @__tableName = @__tableName
				, @JsonData = @JsonData
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END

	---- CustPTSetting3rd_Member : Remark = 2
	SET @__tableName = 'CustPTSetting3rd_Member'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #tblCustomer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM CustPTSetting3rd_Member cs WITH (NOLOCK) 
			INNER JOIN Tmp_CleanUpCustomerSetting tcucs WITH (NOLOCK) ON cs.CustID = tcucs.CustID
		WHERE cs.custid <= @max_custid

		IF @@ROWCOUNT = 0
			BREAK

		--loop delete by batch
		WHILE 1 = 1
		BEGIN
			
			TRUNCATE TABLE #tblCustomer_batch

			DELETE TOP (@BatchSize) #tblCustomer
			OUTPUT deleted.CustID, deleted.SportType, deleted.BetType
			INTO #tblCustomer_batch(CustID, SportType, BetType)

			IF @@ROWCOUNT = 0 
				BREAK

			SELECT @JsonData=(	  SELECT	CustID , SportType, BetType
							  FROM	#tblCustomer_batch
							  FOR JSON PATH
							 )
	
			EXEC dbo.Acc_DynamicCustSetting3rd_19 @__tableName = @__tableName
				, @JsonData = @JsonData
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END

	---- CustBetSetting3rd_Agent : Remark = 3
	SET @__tableName = 'CustBetSetting3rd_Agent'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #tblCustomer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM CustBetSetting3rd_Agent cs WITH (NOLOCK) 
			INNER JOIN Tmp_CleanUpCustomerSetting tcucs WITH (NOLOCK) ON cs.CustID = tcucs.CustID
		WHERE cs.custid <= @max_custid

		IF @@ROWCOUNT = 0
			BREAK

		--loop delete by batch
		WHILE 1 = 1
		BEGIN
			
			TRUNCATE TABLE #tblCustomer_batch

			DELETE TOP (@BatchSize) #tblCustomer
			OUTPUT deleted.CustID, deleted.SportType, deleted.BetType
			INTO #tblCustomer_batch(CustID, SportType, BetType)

			IF @@ROWCOUNT = 0 
				BREAK

			SELECT @JsonData=(	  SELECT	CustID , SportType, BetType
							  FROM	#tblCustomer_batch
							  FOR JSON PATH
							 )
	
			EXEC dbo.Acc_DynamicCustSetting3rd_19 @__tableName = @__tableName
				, @JsonData = @JsonData
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END

	---- CustBetSetting3rd_Member : Remark = 4
	SET @__tableName = 'CustBetSetting3rd_Member'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #tblCustomer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM CustBetSetting3rd_Member cs WITH (NOLOCK) 
			INNER JOIN Tmp_CleanUpCustomerSetting tcucs WITH (NOLOCK) ON cs.CustID = tcucs.CustID
		WHERE cs.custid <= @max_custid

		IF @@ROWCOUNT = 0
			BREAK

		--loop delete by batch
		WHILE 1 = 1
		BEGIN
			
			TRUNCATE TABLE #tblCustomer_batch

			DELETE TOP (@BatchSize) #tblCustomer
			OUTPUT deleted.CustID, deleted.SportType, deleted.BetType
			INTO #tblCustomer_batch(CustID, SportType, BetType)

			IF @@ROWCOUNT = 0 
				BREAK

			SELECT @JsonData=(	  SELECT	CustID , SportType, BetType
							  FROM	#tblCustomer_batch
							  FOR JSON PATH
							 )
	
			EXEC dbo.Acc_DynamicCustSetting3rd_19 @__tableName = @__tableName
				, @JsonData = @JsonData
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END

	---- CustDiscount3rd_Agent : Remark = 5
	SET @__tableName = 'CustDiscount3rd_Agent'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #tblCustomer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM CustDiscount3rd_Agent cs WITH (NOLOCK) 
			INNER JOIN Tmp_CleanUpCustomerSetting tcucs WITH (NOLOCK) ON cs.CustID = tcucs.CustID
		WHERE cs.custid <= @max_custid

		IF @@ROWCOUNT = 0
			BREAK

		--loop delete by batch
		WHILE 1 = 1
		BEGIN
			
			TRUNCATE TABLE #tblCustomer_batch

			DELETE TOP (@BatchSize) #tblCustomer
			OUTPUT deleted.CustID, deleted.SportType, deleted.BetType
			INTO #tblCustomer_batch(CustID, SportType, BetType)

			IF @@ROWCOUNT = 0 
				BREAK

			SELECT @JsonData=(	  SELECT	CustID , SportType, BetType
							  FROM	#tblCustomer_batch
							  FOR JSON PATH
							 )
	
			EXEC dbo.Acc_DynamicCustSetting3rd_19 @__tableName = @__tableName
				, @JsonData = @JsonData
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END

	---- CustDiscount3rd_Member : Remark = 6
	SET @__tableName = 'CustDiscount3rd_Member'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #tblCustomer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM CustDiscount3rd_Member cs WITH (NOLOCK) 
			INNER JOIN Tmp_CleanUpCustomerSetting tcucs WITH (NOLOCK) ON cs.CustID = tcucs.CustID
		WHERE cs.custid <= @max_custid

		IF @@ROWCOUNT = 0
			BREAK

		--loop delete by batch
		WHILE 1 = 1
		BEGIN
			
			TRUNCATE TABLE #tblCustomer_batch

			DELETE TOP (@BatchSize) #tblCustomer
			OUTPUT deleted.CustID, deleted.SportType, deleted.BetType
			INTO #tblCustomer_batch(CustID, SportType, BetType)

			IF @@ROWCOUNT = 0 
				BREAK

			SELECT @JsonData=(	  SELECT	CustID , SportType, BetType
							  FROM	#tblCustomer_batch
							  FOR JSON PATH
							 )
	
			EXEC dbo.Acc_DynamicCustSetting3rd_19 @__tableName = @__tableName
				, @JsonData = @JsonData
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END

	---- CustWinLossLimit_Agent : Remark = 7
	SET @__tableName = 'CustWinLossLimit_Agent'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #tblCustomer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM CustWinLossLimit_Agent cs WITH (NOLOCK) 
			INNER JOIN Tmp_CleanUpCustomerSetting tcucs WITH (NOLOCK) ON cs.CustID = tcucs.CustID
		WHERE cs.custid <= @max_custid

		IF @@ROWCOUNT = 0
			BREAK

		--loop delete by batch
		WHILE 1 = 1
		BEGIN
			
			TRUNCATE TABLE #tblCustomer_batch

			DELETE TOP (@BatchSize) #tblCustomer
			OUTPUT deleted.CustID, deleted.SportType, deleted.BetType
			INTO #tblCustomer_batch(CustID, SportType, BetType)

			IF @@ROWCOUNT = 0 
				BREAK

			SELECT @JsonData=(	  SELECT	CustID , SportType, BetType
							  FROM	#tblCustomer_batch
							  FOR JSON PATH
							 )
	
			EXEC dbo.Acc_DynamicCustSetting3rd_19 @__tableName = @__tableName
				, @JsonData = @JsonData
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END

	---- CustWinLossLimit_Member : Remark = 8
	SET @__tableName = 'CustWinLossLimit_Member'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #tblCustomer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM CustWinLossLimit_Member cs WITH (NOLOCK) 
			INNER JOIN Tmp_CleanUpCustomerSetting tcucs WITH (NOLOCK) ON cs.CustID = tcucs.CustID
		WHERE cs.custid <= @max_custid

		IF @@ROWCOUNT = 0
			BREAK

		--loop delete by batch
		WHILE 1 = 1
		BEGIN
			
			TRUNCATE TABLE #tblCustomer_batch

			DELETE TOP (@BatchSize) #tblCustomer
			OUTPUT deleted.CustID, deleted.SportType, deleted.BetType
			INTO #tblCustomer_batch(CustID, SportType, BetType)

			IF @@ROWCOUNT = 0 
				BREAK

			SELECT @JsonData=(	  SELECT	CustID , SportType, BetType
							  FROM	#tblCustomer_batch
							  FOR JSON PATH
							 )
	
			EXEC dbo.Acc_DynamicCustSetting3rd_19 @__tableName = @__tableName
				, @JsonData = @JsonData
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END

	---- CustStakeLevel_Agent : Remark = 9
	SET @__tableName = 'CustStakeLevel_Agent'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #tblCustomer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM CustStakeLevel_Agent cs WITH (NOLOCK) 
			INNER JOIN Tmp_CleanUpCustomerSetting tcucs WITH (NOLOCK) ON cs.CustID = tcucs.CustID
		WHERE cs.custid <= @max_custid

		IF @@ROWCOUNT = 0
			BREAK

		--loop delete by batch
		WHILE 1 = 1
		BEGIN
			
			TRUNCATE TABLE #tblCustomer_batch

			DELETE TOP (@BatchSize) #tblCustomer
			OUTPUT deleted.CustID, deleted.SportType, deleted.BetType
			INTO #tblCustomer_batch(CustID, SportType, BetType)

			IF @@ROWCOUNT = 0 
				BREAK

			SELECT @JsonData=(	  SELECT	CustID , SportType, BetType
							  FROM	#tblCustomer_batch
							  FOR JSON PATH
							 )
	
			EXEC dbo.Acc_DynamicCustSetting3rd_19 @__tableName = @__tableName
				, @JsonData = @JsonData
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END

	---- CustStakeLevel_Member : Remark = 10
	SET @__tableName = 'CustStakeLevel_Member'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #tblCustomer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM CustStakeLevel_Member cs WITH (NOLOCK) 
			INNER JOIN Tmp_CleanUpCustomerSetting tcucs WITH (NOLOCK) ON cs.CustID = tcucs.CustID
		WHERE cs.custid <= @max_custid

		IF @@ROWCOUNT = 0
			BREAK

		--loop delete by batch
		WHILE 1 = 1
		BEGIN
			
			TRUNCATE TABLE #tblCustomer_batch

			DELETE TOP (@BatchSize) #tblCustomer
			OUTPUT deleted.CustID, deleted.SportType, deleted.BetType
			INTO #tblCustomer_batch(CustID, SportType, BetType)

			IF @@ROWCOUNT = 0 
				BREAK

			SELECT @JsonData=(	  SELECT	CustID , SportType, BetType
							  FROM	#tblCustomer_batch
							  FOR JSON PATH
							 )
	
			EXEC dbo.Acc_DynamicCustSetting3rd_19 @__tableName = @__tableName
				, @JsonData = @JsonData
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END

	---- CustPTGroupSetting3rd_Member : Remark = 11
	SET @__tableName = 'CustPTGroupSetting3rd_Member'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #tblCustomer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.AgentID, cs.SportType, cs.BetType
		FROM CustPTGroupSetting3rd_Member cs WITH (NOLOCK) 
			INNER JOIN Tmp_CleanUpCustomerSetting tcucs WITH (NOLOCK) ON cs.AgentID = tcucs.CustID
		WHERE cs.AgentID <= @max_custid

		IF @@ROWCOUNT = 0
			BREAK

		--loop delete by batch
		WHILE 1 = 1
		BEGIN
			
			TRUNCATE TABLE #tblCustomer_batch

			DELETE TOP (@BatchSize) #tblCustomer
			OUTPUT deleted.CustID, deleted.SportType, deleted.BetType
			INTO #tblCustomer_batch(CustID, SportType, BetType)

			IF @@ROWCOUNT = 0 
				BREAK

			SELECT @JsonData=(	  SELECT	CustID , SportType, BetType
							  FROM	#tblCustomer_batch
							  FOR JSON PATH
							 )
	
			EXEC dbo.Acc_DynamicCustSetting3rd_19 @__tableName = @__tableName
				, @JsonData = @JsonData
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END

	---- CustSettingMode3rd : Remark = 12
	SET @__tableName = 'CustSettingMode3rd'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #tblCust (custid)
		SELECT TOP(@ReadBatchSize) cs.CustID
		FROM CustSettingMode3rd cs WITH (NOLOCK) 
			INNER JOIN Tmp_CleanUpCustomerSetting tcucs WITH (NOLOCK) ON cs.CustID = tcucs.CustID
		WHERE cs.custid <= @max_custid

		IF @@ROWCOUNT = 0
			BREAK

		--loop delete by batch
		WHILE 1 = 1
		BEGIN
			
			TRUNCATE TABLE #tblCust_batch

			DELETE TOP (@BatchSize) #tblCust
			OUTPUT deleted.CustID
			INTO #tblCust_batch (CustID)

			IF @@ROWCOUNT = 0 
				BREAK

			SELECT @JsonData=(	  SELECT	CustID
							  FROM	#tblCust_batch
							  FOR JSON PATH
							 )
	
			EXEC dbo.Acc_DynamicCustSetting3rd_19 @__tableName = @__tableName
				, @JsonData = @JsonData
				, @target = @target
		
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END

	

	

	DROP TABLE #tblCustomer
	DROP TABLE #tblCustomer_batch

	DROP TABLE #tblCust
	DROP TABLE #tblCust_batch
END