/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20231006
	Task: FW, GDG - clean redundant data
		https://nexdev.net/issues/174511
	DB: DBCust/CustDB
*/
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@CustList XML
	,@TableName VARCHAR(200)
	,@target VARCHAR(20)

AS
/*
	        1 ~ CustPTSetting3rd_Agent
			2 ~ CustPTSetting3rd_Member
			3 ~ CustPTGroupSetting3rd_Member
			4 ~ CustDiscount3rd_Member
			5 ~ CustDiscount3rd_Agent
			6 ~ CustWinLossLimit_Agent
			7 ~ CustWinLossLimit_Member
			8 ~ CustStakeLevel_Agent
			9 ~ CustStakeLevel_Member
*/
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')) RETURN -- run at DBCUST only
	
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN

	CREATE TABLE #tbCustomer(
				 CustID	INT
				,SportType SMALLINT
				,BetType SMALLINT
				,PRIMARY KEY CLUSTERED (CustID, Sporttype, Bettype))

	INSERT INTO #tbCustomer (CustID, SportType, BetType)
	SELECT   t.c.value('@CustID','INT')		AS CustID
			,t.c.value('@SportType','SMALLINT')	AS SportType
			,t.c.value('@BetType','SMALLINT')	AS BetType
	FROM @CustList.nodes('root') t(c)

	IF @TableName = 'CustPTSetting3rd_Agent' --1)
	BEGIN
		DELETE a
		FROM CustPTSetting3rd_Agent a WITH(ROWLOCK)
		INNER JOIN #tbCustomer c ON c.CustID=a.CustID
								AND c.SportType=a.SportType
								AND c.BetType=a.BetType
	END

	IF @TableName = 'CustPTSetting3rd_Member' --2)
	BEGIN
		DELETE a
		FROM CustPTSetting3rd_Member a WITH(ROWLOCK)
		INNER JOIN #tbCustomer c ON c.CustID=a.CustID
								AND c.SportType=a.SportType
								AND c.BetType=a.BetType
	END

	IF @TableName = 'CustPTGroupSetting3rd_Member' --3)
	BEGIN
		DELETE a
		FROM CustPTGroupSetting3rd_Member a WITH(ROWLOCK)
		INNER JOIN #tbCustomer c ON c.CustID=a.AgentID
								AND c.SportType=a.SportType
								AND c.BetType=a.BetType
	END

	IF @TableName = 'CustDiscount3rd_Member' --4)
	BEGIN
		DELETE a
		FROM CustDiscount3rd_Member a WITH(ROWLOCK)
		INNER JOIN #tbCustomer c ON c.CustID=a.CustID
								AND c.SportType=a.SportType
								AND c.BetType=a.BetType
	END

	IF @TableName = 'CustDiscount3rd_Agent' --5)
	BEGIN
		DELETE a
		FROM CustDiscount3rd_Agent a WITH(ROWLOCK)
		INNER JOIN #tbCustomer c ON c.CustID=a.CustID
								AND c.SportType=a.SportType
								AND c.BetType=a.BetType
	END
	
	IF @TableName = 'CustWinLossLimit_Agent' --6)
	BEGIN
		DELETE a
		FROM CustWinLossLimit_Agent a WITH(ROWLOCK)
		INNER JOIN #tbCustomer c ON c.CustID=a.CustID
								AND c.SportType=a.SportType
								AND c.BetType=a.BetType
	END
		
	IF @TableName = 'CustWinLossLimit_Member' --7)
	BEGIN
		DELETE a
		FROM CustWinLossLimit_Member a WITH(ROWLOCK)
		INNER JOIN #tbCustomer c ON c.CustID=a.CustID
								AND c.SportType=a.SportType
								AND c.BetType=a.BetType
	END
			
	IF @TableName = 'CustStakeLevel_Agent' --8)
	BEGIN
		DELETE a
		FROM CustStakeLevel_Agent a WITH(ROWLOCK)
		INNER JOIN #tbCustomer c ON c.CustID=a.CustID
								AND c.SportType=a.SportType
								AND c.BetType=a.BetType
	END
				
	IF @TableName = 'CustStakeLevel_Member' --9)
	BEGIN
		DELETE a
		FROM CustStakeLevel_Member a WITH(ROWLOCK)
		INNER JOIN #tbCustomer c ON c.CustID=a.CustID
								AND c.SportType=a.SportType
								AND c.BetType=a.BetType
	END

	DROP TABLE #tbCustomer
END
GO
------------------------------------------------------	
-- BEGIN: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST-----
----------------------------------------------------------------------------------------------
PRINT N'Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
PRINT N'--------------------------------------------------------'
----------------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

DECLARE @max_custid INT,
		@CustList   XML,
		@BatchSize	INT = 3000,
		@ReadBatchSize INT = 100000

SELECT @max_custid = 'xxx'
	
CREATE TABLE #Customer(CustID INT
				,SportType	SMALLINT
				,BetType	SMALLINT)

CREATE TABLE #Customer_batch(CustID	INT
				,SportType SMALLINT
				,BetType SMALLINT)

CREATE TABLE #SportBettype (SportType SMALLINT, BetType SMALLINT)

------------------------------------------------
--Get Data
INSERT INTO #SportBettype (SportType, BetType)
SELECT 219, 1011
UNION
SELECT 236, 5701

DECLARE @__messageInfo VARCHAR(200), @__tableName VARCHAR(200)

BEGIN --1) CustPTSetting3rd_Agent
	SET @__tableName = 'CustPTSetting3rd_Agent'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #Customer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM CustPTSetting3rd_Agent cs WITH (NOLOCK) 
			INNER JOIN #SportBettype s ON s.SportType = cs.SportType AND s.BetType = cs.BetType
		WHERE cs.custid <= @max_custid

		IF @@ROWCOUNT = 0
			BREAK

		--loop delete by batch
		WHILE 1 = 1
		BEGIN
			
			TRUNCATE TABLE #Customer_batch

			DELETE TOP (@BatchSize) #Customer
			OUTPUT deleted.CustID, deleted.SportType, deleted.BetType
			INTO #Customer_batch(CustID, SportType, BetType)

			IF @@ROWCOUNT = 0 
				BREAK

			SELECT @CustList=(SELECT CustID		AS '@CustID', 
									 SportType	AS '@SportType',
									 BetType	AS '@BetType'
							  FROM #Customer_batch
							  FOR XML PATH('root')
							 )
	
			EXEC dbo.Acc_DynamicCustSetting3rd_09 @CustList = @CustList
				, @TableName = @__tableName
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END
END

BEGIN --2) CustPTSetting3rd_Member
	SET @__tableName = 'CustPTSetting3rd_Member'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #Customer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM CustPTSetting3rd_Member cs WITH (NOLOCK) 
			INNER JOIN #SportBettype s ON s.SportType = cs.SportType AND s.BetType = cs.BetType
		WHERE cs.custid <= @max_custid

		IF @@ROWCOUNT = 0
			BREAK

		--loop delete by batch
		WHILE 1 = 1
		BEGIN
			
			TRUNCATE TABLE #Customer_batch

			DELETE TOP (@BatchSize) #Customer
			OUTPUT deleted.CustID, deleted.SportType, deleted.BetType
			INTO #Customer_batch(CustID, SportType, BetType)

			IF @@ROWCOUNT = 0 
				BREAK

			SELECT @CustList=(SELECT CustID		AS '@CustID', 
									 SportType	AS '@SportType',
									 BetType	AS '@BetType'
							  FROM #Customer_batch
							  FOR XML PATH('root')
							 )
	
			EXEC dbo.Acc_DynamicCustSetting3rd_09 @CustList = @CustList
				, @TableName = @__tableName
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END
END

BEGIN --3) CustPTGroupSetting3rd_Member
	SET @__tableName = 'CustPTGroupSetting3rd_Member'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #Customer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.AgentID, cs.SportType, cs.BetType
		FROM CustPTGroupSetting3rd_Member cs WITH (NOLOCK) 
			INNER JOIN #SportBettype s ON s.SportType = cs.SportType AND s.BetType = cs.BetType
		WHERE cs.AgentID <= @max_custid

		IF @@ROWCOUNT = 0
			BREAK

		--loop delete by batch
		WHILE 1 = 1
		BEGIN
			
			TRUNCATE TABLE #Customer_batch

			DELETE TOP (@BatchSize) #Customer
			OUTPUT deleted.CustID, deleted.SportType, deleted.BetType
			INTO #Customer_batch(CustID, SportType, BetType)

			IF @@ROWCOUNT = 0 
				BREAK

			SELECT @CustList=(SELECT CustID		AS '@CustID', 
									 SportType	AS '@SportType',
									 BetType	AS '@BetType'
							  FROM #Customer_batch
							  FOR XML PATH('root')
							 )
	
			EXEC dbo.Acc_DynamicCustSetting3rd_09 @CustList = @CustList
				, @TableName = @__tableName
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END
END

BEGIN --4) CustDiscount3rd_Member
	SET @__tableName = 'CustDiscount3rd_Member'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #Customer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM CustDiscount3rd_Member cs WITH (NOLOCK) 
			INNER JOIN #SportBettype s ON s.SportType = cs.SportType AND s.BetType = cs.BetType
		WHERE cs.custid <= @max_custid

		IF @@ROWCOUNT = 0
			BREAK

		--loop delete by batch
		WHILE 1 = 1
		BEGIN
			
			TRUNCATE TABLE #Customer_batch

			DELETE TOP (@BatchSize) #Customer
			OUTPUT deleted.CustID, deleted.SportType, deleted.BetType
			INTO #Customer_batch(CustID, SportType, BetType)

			IF @@ROWCOUNT = 0 
				BREAK

			SELECT @CustList=(SELECT CustID		AS '@CustID', 
									 SportType	AS '@SportType',
									 BetType	AS '@BetType'
							  FROM #Customer_batch
							  FOR XML PATH('root')
							 )
	
			EXEC dbo.Acc_DynamicCustSetting3rd_09 @CustList = @CustList
				, @TableName = @__tableName
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END
END

BEGIN --5) CustDiscount3rd_Agent
	SET @__tableName = 'CustDiscount3rd_Agent'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #Customer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM CustDiscount3rd_Agent cs WITH (NOLOCK) 
			INNER JOIN #SportBettype s ON s.SportType = cs.SportType AND s.BetType = cs.BetType
		WHERE cs.custid <= @max_custid

		IF @@ROWCOUNT = 0
			BREAK

		--loop delete by batch
		WHILE 1 = 1
		BEGIN
			
			TRUNCATE TABLE #Customer_batch

			DELETE TOP (@BatchSize) #Customer
			OUTPUT deleted.CustID, deleted.SportType, deleted.BetType
			INTO #Customer_batch(CustID, SportType, BetType)

			IF @@ROWCOUNT = 0 
				BREAK

			SELECT @CustList=(SELECT CustID		AS '@CustID', 
									 SportType	AS '@SportType',
									 BetType	AS '@BetType'
							  FROM #Customer_batch
							  FOR XML PATH('root')
							 )
	
			EXEC dbo.Acc_DynamicCustSetting3rd_09 @CustList = @CustList
				, @TableName = @__tableName
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END
END

BEGIN --6) CustWinLossLimit_Agent
	SET @__tableName = 'CustWinLossLimit_Agent'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #Customer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM CustWinLossLimit_Agent cs WITH (NOLOCK) 
			INNER JOIN #SportBettype s ON s.SportType = cs.SportType AND s.BetType = cs.BetType
		WHERE cs.custid <= @max_custid

		IF @@ROWCOUNT = 0
			BREAK

		--loop delete by batch
		WHILE 1 = 1
		BEGIN
			
			TRUNCATE TABLE #Customer_batch

			DELETE TOP (@BatchSize) #Customer
			OUTPUT deleted.CustID, deleted.SportType, deleted.BetType
			INTO #Customer_batch(CustID, SportType, BetType)

			IF @@ROWCOUNT = 0 
				BREAK

			SELECT @CustList=(SELECT CustID		AS '@CustID', 
									 SportType	AS '@SportType',
									 BetType	AS '@BetType'
							  FROM #Customer_batch
							  FOR XML PATH('root')
							 )
	
			EXEC dbo.Acc_DynamicCustSetting3rd_09 @CustList = @CustList
				, @TableName = @__tableName
				, @target = @target
	
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END
END

BEGIN --7) CustWinLossLimit_Member
	SET @__tableName = 'CustWinLossLimit_Member'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #Customer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM CustWinLossLimit_Member cs WITH (NOLOCK) 
			INNER JOIN #SportBettype s ON s.SportType = cs.SportType AND s.BetType = cs.BetType
		WHERE cs.custid <= @max_custid

		IF @@ROWCOUNT = 0
			BREAK

		--loop delete by batch
		WHILE 1 = 1
		BEGIN
			
			TRUNCATE TABLE #Customer_batch

			DELETE TOP (@BatchSize) #Customer
			OUTPUT deleted.CustID, deleted.SportType, deleted.BetType
			INTO #Customer_batch(CustID, SportType, BetType)

			IF @@ROWCOUNT = 0 
				BREAK

			SELECT @CustList=(SELECT CustID		AS '@CustID', 
									 SportType	AS '@SportType',
									 BetType	AS '@BetType'
							  FROM #Customer_batch
							  FOR XML PATH('root')
							 )
	
			EXEC dbo.Acc_DynamicCustSetting3rd_09 @CustList = @CustList
				, @TableName = @__tableName
				, @target = @target
	
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END
END

BEGIN --8)CustStakeLevel_Agent
	SET @__tableName = 'CustStakeLevel_Agent'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #Customer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM CustStakeLevel_Agent cs WITH (NOLOCK) 
			INNER JOIN #SportBettype s ON s.SportType = cs.SportType AND s.BetType = cs.BetType
		WHERE cs.custid <= @max_custid

		IF @@ROWCOUNT = 0
			BREAK

		--loop delete by batch
		WHILE 1 = 1
		BEGIN
			
			TRUNCATE TABLE #Customer_batch

			DELETE TOP (@BatchSize) #Customer
			OUTPUT deleted.CustID, deleted.SportType, deleted.BetType
			INTO #Customer_batch(CustID, SportType, BetType)

			IF @@ROWCOUNT = 0 
				BREAK

			SELECT @CustList=(SELECT CustID		AS '@CustID', 
									 SportType	AS '@SportType',
									 BetType	AS '@BetType'
							  FROM #Customer_batch
							  FOR XML PATH('root')
							 )
	
			EXEC dbo.Acc_DynamicCustSetting3rd_09 @CustList = @CustList
				, @TableName = @__tableName
				, @target = @target
	
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END
END

BEGIN --9) CustStakeLevel_Member
	SET @__tableName = 'CustStakeLevel_Member'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #Customer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM CustStakeLevel_Member cs WITH (NOLOCK) 
			INNER JOIN #SportBettype s ON s.SportType = cs.SportType AND s.BetType = cs.BetType
		WHERE cs.custid <= @max_custid

		IF @@ROWCOUNT = 0
			BREAK

		--loop delete by batch
		WHILE 1 = 1
		BEGIN
			
			TRUNCATE TABLE #Customer_batch

			DELETE TOP (@BatchSize) #Customer
			OUTPUT deleted.CustID, deleted.SportType, deleted.BetType
			INTO #Customer_batch(CustID, SportType, BetType)

			IF @@ROWCOUNT = 0 
				BREAK

			SELECT @CustList=(SELECT CustID		AS '@CustID', 
									 SportType	AS '@SportType',
									 BetType	AS '@BetType'
							  FROM #Customer_batch
							  FOR XML PATH('root')
							 )
	
			EXEC dbo.Acc_DynamicCustSetting3rd_09 @CustList = @CustList
				, @TableName = @__tableName
				, @target = @target
	
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END
END

PRINT N'--------------------------------------------------------'
PRINT N'End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
GO
-- END: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
-----------------------------------------------------------------------------------
   