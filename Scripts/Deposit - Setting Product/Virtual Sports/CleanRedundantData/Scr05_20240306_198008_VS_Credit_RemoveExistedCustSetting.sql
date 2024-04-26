/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240318
	Task: Credit - Clean VS1, VS2, VS3 - Existed Customers Setting - [redmine: #198008]
	DB: DBCUST/CUSTDB and all replicated servers
*/
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
 	 @CustList XML
	,@TableName VARCHAR(200)
	,@target VARCHAR(20)
AS
/*
	CustPTSetting3rd_Agent 
	CustPTSetting3rd_Member
	CustBetSetting3rd_Agent
	CustBetSetting3rd_Member
	CustWinLossLimit_Agent
	CustWinLossLimit_Member
*/

BEGIN	
	SET NOCOUNT ON;
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbcust only
	
	IF (dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0
		OR dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0
		
		OR dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 
		OR dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 

		OR dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 
		OR dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 	
		)
		RETURN
	
	CREATE TABLE #tbCustomer(
				 CustID	INT
				,SportType SMALLINT
				,BetType SMALLINT
				,PRIMARY KEY CLUSTERED (CustID, Sporttype, Bettype))
		
	INSERT INTO #tbCustomer (CustID, SportType, BetType)
	SELECT   t.c.value('@CustID','INT')			AS CustID
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

	IF @TableName = 'CustBetSetting3rd_Agent' --3)
	BEGIN
		DELETE a
		FROM CustBetSetting3rd_Agent a WITH(ROWLOCK)
		INNER JOIN #tbCustomer c ON c.CustID=a.CustID
								AND c.SportType=a.SportType
								AND c.BetType=a.BetType
	END

	IF @TableName = 'CustBetSetting3rd_Member' --4)
	BEGIN
		DELETE a
		FROM CustBetSetting3rd_Member a WITH(ROWLOCK)
		INNER JOIN #tbCustomer c ON c.CustID=a.CustID
								AND c.SportType=a.SportType
								AND c.BetType=a.BetType
	END

	IF @TableName = 'CustWinLossLimit_Agent' --5)
	BEGIN
		DELETE a
		FROM CustWinLossLimit_Agent a WITH(ROWLOCK)
		INNER JOIN #tbCustomer c ON c.CustID=a.CustID
								AND c.SportType=a.SportType
								AND c.BetType=a.BetType
	END
	
	IF @TableName = 'CustWinLossLimit_Member' --6)
	BEGIN
		DELETE a
		FROM CustWinLossLimit_Member a WITH(ROWLOCK)
		INNER JOIN #tbCustomer c ON c.CustID=a.CustID
								AND c.SportType=a.SportType
								AND c.BetType=a.BetType
	END
	
	DROP TABLE #tbCustomer
END
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) AND DBCUST (Run last)-----
--------------------------------------------------------------------------------------
PRINT N'CREDIT - CLEAN SETTING: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
PRINT N'--------------------------------------------------------'
DECLARE @target VARCHAR(20)
		,@max_custid INT
		,@CustList   XML
		,@BatchSize	INT = 3000
		,@ReadBatchSize INT = 100000

SELECT @max_custid = xxx 

IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

---------------------------------------------------------------------------------------------
CREATE TABLE #tblCustomer(
				 CustID		INT
				,SportType	SMALLINT
				,BetType	SMALLINT
				,PRIMARY KEY (CustID, Sporttype, Bettype))

CREATE TABLE #tblCustomer_batch(
				 CustID		INT
				,SportType	SMALLINT
				,BetType	SMALLINT
				,PRIMARY KEY (CustID, Sporttype, Bettype))

---------------------------------------------------------------------------------------------
CREATE TABLE #Sports (SportType SMALLINT)

INSERT INTO #Sports(SportType)
	  SELECT 178
UNION SELECT 179
UNION SELECT 180
UNION SELECT 181
UNION SELECT 182
UNION SELECT 183
UNION SELECT 184
UNION SELECT 185
UNION SELECT 186
UNION SELECT 190
UNION SELECT 191
UNION SELECT 192
UNION SELECT 193
UNION SELECT 194
UNION SELECT 195
UNION SELECT 196
UNION SELECT 197
UNION SELECT 199
UNION SELECT 231

---------------------------------------------------------------------------------------------
DECLARE @__messageInfo VARCHAR(200), @__tableName VARCHAR(200)

BEGIN --1) CustPTSetting3rd_Agent
	SET @__tableName = 'CustPTSetting3rd_Agent'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #tblCustomer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM CustPTSetting3rd_Agent cs WITH (NOLOCK) 
			INNER JOIN #Sports s ON s.SportType = cs.SportType
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

			SELECT @CustList=(SELECT CustID		AS '@CustID', 
									 SportType	AS '@SportType',
									 BetType	AS '@BetType'
							  FROM #tblCustomer_batch
							  FOR XML PATH('root')
							 )
	
			EXEC dbo.Acc_DynamicCustSetting3rd_09 
				  @CustList = @CustList
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
		INSERT INTO #tblCustomer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM CustPTSetting3rd_Member cs WITH (NOLOCK) 
			INNER JOIN #Sports s ON s.SportType = cs.SportType
		WHERE cs.CustID <= @max_custid

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

			SELECT @CustList=(SELECT CustID		AS '@CustID', 
									 SportType	AS '@SportType',
									 BetType	AS '@BetType'
							  FROM #tblCustomer_batch
							  FOR XML PATH('root')
							 )
	
			EXEC dbo.Acc_DynamicCustSetting3rd_09 
				  @CustList = @CustList
				, @TableName = @__tableName
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END
END

BEGIN --3) CustBetSetting3rd_Agent
	SET @__tableName = 'CustBetSetting3rd_Agent'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #tblCustomer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM CustBetSetting3rd_Agent cs WITH (NOLOCK) 
			INNER JOIN #Sports s ON s.SportType = cs.SportType
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

			SELECT @CustList=(SELECT CustID		AS '@CustID', 
									 SportType	AS '@SportType',
									 BetType	AS '@BetType'
							  FROM #tblCustomer_batch
							  FOR XML PATH('root')
							 )
	
			EXEC dbo.Acc_DynamicCustSetting3rd_09 
				  @CustList = @CustList
				, @TableName = @__tableName
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END
END

BEGIN --4) CustBetSetting3rd_Member
	SET @__tableName = 'CustBetSetting3rd_Member'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #tblCustomer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM CustBetSetting3rd_Member cs WITH (NOLOCK) 
			INNER JOIN #Sports s ON s.SportType = cs.SportType
		WHERE cs.CustID <= @max_custid

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

			SELECT @CustList=(SELECT CustID		AS '@CustID', 
									 SportType	AS '@SportType',
									 BetType	AS '@BetType'
							  FROM #tblCustomer_batch
							  FOR XML PATH('root')
							 )
	
			EXEC dbo.Acc_DynamicCustSetting3rd_09 
				  @CustList = @CustList
				, @TableName = @__tableName
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END
END

BEGIN --5) CustWinLossLimit_Agent
	SET @__tableName = 'CustWinLossLimit_Agent'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #tblCustomer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM CustWinLossLimit_Agent cs WITH (NOLOCK) 
			INNER JOIN #Sports s ON s.SportType = cs.SportType
		WHERE cs.CustID <= @max_custid

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

			SELECT @CustList=(SELECT CustID		AS '@CustID', 
									 SportType	AS '@SportType',
									 BetType	AS '@BetType'
							  FROM #tblCustomer_batch
							  FOR XML PATH('root')
							 )
	
			EXEC dbo.Acc_DynamicCustSetting3rd_09 
				  @CustList = @CustList
				, @TableName = @__tableName
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END
END

BEGIN --6) CustWinLossLimit_Member
	SET @__tableName = 'CustWinLossLimit_Member'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #tblCustomer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM CustWinLossLimit_Member cs WITH (NOLOCK) 
			INNER JOIN #Sports s ON s.SportType = cs.SportType
		WHERE cs.CustID <= @max_custid

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

			SELECT @CustList=(SELECT CustID		AS '@CustID', 
									 SportType	AS '@SportType',
									 BetType	AS '@BetType'
							  FROM #tblCustomer_batch
							  FOR XML PATH('root')
							 )
	
			EXEC dbo.Acc_DynamicCustSetting3rd_09 
				  @CustList = @CustList
				, @TableName = @__tableName
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END
END

PRINT N'--------------------------------------------------------'
PRINT N'CREDIT - CLEAN SETTING: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

DROP TABLE #tblCustomer, #tblCustomer_batch, #Sports
GO
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (/06/DBTP) AND DBCUST (Run last) -----
-----------------------------------------------------------------------------------	
