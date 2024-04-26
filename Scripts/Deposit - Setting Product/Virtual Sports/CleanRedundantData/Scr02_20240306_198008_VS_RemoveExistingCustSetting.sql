/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240306
	Task: Deposit - Clean VS1, VS2, VS3 - Existing Customers Setting - [redmine: #198008]
	DB: DBCUST/CUSTDB and all replicated servers
*/
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	 @CustList XML
	,@TableName VARCHAR(200)
	,@target VARCHAR(20)
AS
/*
	Dep_LicenseeProductSetting 
	Dep_CustDiscountGroupSetting_Member
	Dep_CustDiscountSetting_Member
	Dep_CustBetSetting_Agent
	Dep_CustBetSetting_Member
	Dep_CustPTGroupSetting_Member
	Dep_CustPTSetting_Agent
	Dep_CustPTSetting_Member
*/

BEGIN	
	SET NOCOUNT ON;
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbcust only
	
	IF (dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0
		
		OR dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 
		
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 

		OR dbo.f_CheckRepTable('Dep_CustDiscountSetting_Member') = 0 
		OR dbo.f_CheckRepTable('Dep_CustDiscountGroupSetting_Member') = 0 	
		)
		RETURN
	
	CREATE TABLE #tbCustomer(
				 CustID	INT
				,SportType SMALLINT
				,BetType SMALLINT
				,PRIMARY KEY CLUSTERED (CustID, Sporttype, Bettype))
	
	CREATE TABLE #tmpDep_LicenseeProductSetting(
				 CustID	INT
				,ProductSettingID INT
				,PRIMARY KEY CLUSTERED (CustID, ProductSettingID))
	
	--Get dataset
	IF @TableName <> 'Dep_LicenseeProductSetting'
	BEGIN
		INSERT INTO #tbCustomer (CustID, SportType, BetType)
		SELECT   t.c.value('@CustID','INT')			AS CustID
				,t.c.value('@SportType','SMALLINT')	AS SportType
				,t.c.value('@BetType','SMALLINT')	AS BetType
		FROM @CustList.nodes('root') t(c)
	END

	IF @TableName = 'Dep_LicenseeProductSetting' --1)
	BEGIN
		INSERT INTO #tmpDep_LicenseeProductSetting (CustID, ProductSettingID)
		SELECT   t.c.value('@CustID','INT')				AS CustID
				,t.c.value('@ProductSettingID','INT')	AS ProductSettingID
		FROM @CustList.nodes('root') t(c)

		DELETE a
		FROM Dep_LicenseeProductSetting a WITH(ROWLOCK)
		INNER JOIN #tmpDep_LicenseeProductSetting c ON c.CustID=a.CustID
								AND c.ProductSettingID=a.ProductSettingID
	END

	IF @TableName = 'Dep_CustPTSetting_Agent' --2)
	BEGIN
		DELETE a
		FROM Dep_CustPTSetting_Agent a WITH(ROWLOCK)
		INNER JOIN #tbCustomer c ON c.CustID=a.CustID
								AND c.SportType=a.SportType
								AND c.BetType=a.BetType
	END

	IF @TableName = 'Dep_CustPTGroupSetting_Member' --3)
	BEGIN
		DELETE a
		FROM Dep_CustPTGroupSetting_Member a WITH(ROWLOCK)
		INNER JOIN #tbCustomer c ON c.CustID=a.AgentID
								AND c.SportType=a.SportType
								AND c.BetType=a.BetType
	END

	IF @TableName = 'Dep_CustPTSetting_Member' --4)
	BEGIN
		DELETE a
		FROM Dep_CustPTSetting_Member a WITH(ROWLOCK)
		INNER JOIN #tbCustomer c ON c.CustID=a.CustID
								AND c.SportType=a.SportType
								AND c.BetType=a.BetType
	END

	IF @TableName = 'Dep_CustDiscountGroupSetting_Member' --5)
	BEGIN
		DELETE a
		FROM Dep_CustDiscountGroupSetting_Member a WITH(ROWLOCK)
		INNER JOIN #tbCustomer c ON c.CustID=a.AgentID
								AND c.SportType=a.SportType
								AND c.BetType=a.BetType
	END

	IF @TableName = 'Dep_CustDiscountSetting_Member' --6)
	BEGIN
		DELETE a
		FROM Dep_CustDiscountSetting_Member a WITH(ROWLOCK)
		INNER JOIN #tbCustomer c ON c.CustID=a.CustID
								AND c.SportType=a.SportType
								AND c.BetType=a.BetType
	END
	
	IF @TableName = 'Dep_CustBetSetting_Agent' --7)
	BEGIN
		DELETE a
		FROM Dep_CustBetSetting_Agent a WITH(ROWLOCK)
		INNER JOIN #tbCustomer c ON c.CustID=a.CustID
								AND c.SportType=a.SportType
								AND c.BetType=a.BetType
	END
		
	IF @TableName = 'Dep_CustBetSetting_Member' --8)
	BEGIN
		DELETE a
		FROM Dep_CustBetSetting_Member a WITH(ROWLOCK)
		INNER JOIN #tbCustomer c ON c.CustID=a.CustID
								AND c.SportType=a.SportType
								AND c.BetType=a.BetType
	END
	
	DROP TABLE #tbCustomer, #tmpDep_LicenseeProductSetting
END
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) AND DBCUST (Run last)-----
--------------------------------------------------------------------------------------
PRINT N'CLEAN SETTING: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
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
CREATE TABLE #Dep_ProductSettingDetail (ProductSettingID INT, SettingType SMALLINT, SportType SMALLINT, BetType SMALLINT)

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

CREATE TABLE #tmpDep_LicenseeProductSetting(
				 CustID		INT
				,ProductSettingID INT
				,PRIMARY KEY (CustID, ProductSettingID))
				
CREATE TABLE #tmpDep_LicenseeProductSetting_batch(
				 CustID		INT
				,ProductSettingID INT
				,PRIMARY KEY (CustID, ProductSettingID))

---------------------------------------------------------------------------------------------
INSERT INTO #Dep_ProductSettingDetail(ProductSettingID, SettingType, SportType, BetType)
SELECT ps.ProductSettingID, SettingType, SportType, BetType
FROM Dep_ProductSettingDetail psd WITH(NOLOCK)
	INNER JOIN Dep_ProductSetting ps WITh(NOLOCK) ON psd.ProductSettingID=ps.ProductSettingID
WHERE ps.ProductID in (5,27,49,77) 
	AND ps.ProductSettingID NOT BETWEEN 182 AND 185
	AND PS.SettingType<>4

---------------------------------------------------------------------------------------------
DECLARE @__messageInfo VARCHAR(200), @__tableName VARCHAR(200)

BEGIN --1) Dep_LicenseeProductSetting 
	SET @__tableName = 'Dep_LicenseeProductSetting '
	WHILE 1 = 1
	BEGIN
		INSERT INTO #tmpDep_LicenseeProductSetting(custid, ProductSettingID)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.ProductSettingID
		FROM Dep_LicenseeProductSetting  cs WITH (NOLOCK) 
			CROSS APPLY (SELECT TOP 1 ProductSettingID
						 FROM #Dep_ProductSettingDetail s 
						 WHERE cs.ProductSettingID=s.ProductSettingID) T
		WHERE cs.CustID <= @max_custid

		IF @@ROWCOUNT = 0
			BREAK

		--loop delete by batch
		WHILE 1 = 1
		BEGIN
			TRUNCATE TABLE #tmpDep_LicenseeProductSetting_batch

			DELETE TOP (@BatchSize) #tmpDep_LicenseeProductSetting
			OUTPUT deleted.CustID, deleted.ProductSettingID
			INTO #tmpDep_LicenseeProductSetting_batch(CustID, ProductSettingID)

			IF @@ROWCOUNT = 0 
				BREAK

			SELECT @CustList=(SELECT CustID				AS '@CustID', 
									 ProductSettingID	AS '@ProductSettingID'
							  FROM #tmpDep_LicenseeProductSetting_batch
							  FOR XML PATH('root')
							 )
	
			EXEC dbo.Acc_Dep_DynamicCustSetting_09 
				  @CustList = @CustList
				, @TableName = @__tableName
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END
END

BEGIN --2) Dep_CustPTSetting_Agent
	SET @__tableName = 'Dep_CustPTSetting_Agent'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #tblCustomer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM Dep_CustPTSetting_Agent cs WITH (NOLOCK) 
			INNER JOIN #Dep_ProductSettingDetail s ON s.SportType = cs.SportType AND s.BetType = cs.BetType
		WHERE cs.custid <= @max_custid AND s.SettingType=1

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
	
			EXEC dbo.Acc_Dep_DynamicCustSetting_09 
				  @CustList = @CustList
				, @TableName = @__tableName
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END
END

BEGIN --3) Dep_CustPTGroupSetting_Member
	SET @__tableName = 'Dep_CustPTGroupSetting_Member'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #tblCustomer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.AgentID, cs.SportType, cs.BetType
		FROM Dep_CustPTGroupSetting_Member cs WITH (NOLOCK) 
			INNER JOIN #Dep_ProductSettingDetail s ON s.SportType = cs.SportType AND s.BetType = cs.BetType
		WHERE cs.AgentID <= @max_custid AND s.SettingType=1

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
	
			EXEC dbo.Acc_Dep_DynamicCustSetting_09 
				  @CustList = @CustList
				, @TableName = @__tableName
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END
END

BEGIN --4) Dep_CustPTSetting_Member
	SET @__tableName = 'Dep_CustPTSetting_Member'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #tblCustomer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM Dep_CustPTSetting_Member cs WITH (NOLOCK) 
			INNER JOIN #Dep_ProductSettingDetail s ON s.SportType = cs.SportType AND s.BetType = cs.BetType
		WHERE cs.custid <= @max_custid AND s.SettingType=1

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
	
			EXEC dbo.Acc_Dep_DynamicCustSetting_09 
				  @CustList = @CustList
				, @TableName = @__tableName
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END
END

BEGIN --5) Dep_CustDiscountGroupSetting_Member
	SET @__tableName = 'Dep_CustDiscountGroupSetting_Member'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #tblCustomer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.AgentID, cs.SportType, cs.BetType
		FROM Dep_CustDiscountGroupSetting_Member cs WITH (NOLOCK) 
			INNER JOIN #Dep_ProductSettingDetail s ON s.SportType = cs.SportType AND s.BetType = cs.BetType
		WHERE cs.AgentID <= @max_custid AND s.SettingType=9

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
	
			EXEC dbo.Acc_Dep_DynamicCustSetting_09 
				  @CustList = @CustList
				, @TableName = @__tableName
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END
END

BEGIN --6) Dep_CustDiscountSetting_Member
	SET @__tableName = 'Dep_CustDiscountSetting_Member'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #tblCustomer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM Dep_CustDiscountSetting_Member cs WITH (NOLOCK) 
			INNER JOIN #Dep_ProductSettingDetail s ON s.SportType = cs.SportType AND s.BetType = cs.BetType
		WHERE cs.CustID <= @max_custid AND s.SettingType=9

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
	
			EXEC dbo.Acc_Dep_DynamicCustSetting_09 
				  @CustList = @CustList
				, @TableName = @__tableName
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END
END

BEGIN --7) Dep_CustBetSetting_Agent
	SET @__tableName = 'Dep_CustBetSetting_Agent'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #tblCustomer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM Dep_CustBetSetting_Agent cs WITH (NOLOCK) 
			INNER JOIN #Dep_ProductSettingDetail s ON s.SportType = cs.SportType AND s.BetType = cs.BetType
		WHERE cs.CustID <= @max_custid AND s.SettingType IN (2,11)

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
	
			EXEC dbo.Acc_Dep_DynamicCustSetting_09 
				  @CustList = @CustList
				, @TableName = @__tableName
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END
END

BEGIN --8) Dep_CustBetSetting_Member
	SET @__tableName = 'Dep_CustBetSetting_Member'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #tblCustomer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM Dep_CustBetSetting_Member cs WITH (NOLOCK) 
			INNER JOIN #Dep_ProductSettingDetail s ON s.SportType = cs.SportType AND s.BetType = cs.BetType
		WHERE cs.CustID <= @max_custid AND s.SettingType IN (2,11)

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
	
			EXEC dbo.Acc_Dep_DynamicCustSetting_09 
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
PRINT N'CLEAN SETTING: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

DROP TABLE #tblCustomer, #tblCustomer_batch, #Dep_ProductSettingDetail, #tmpDep_LicenseeProductSetting, #tmpDep_LicenseeProductSetting_batch
GO
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (/06/DBTP) AND DBCUST (Run last) -----
-----------------------------------------------------------------------------------	
