/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240306
	Task: Deposit - Clean VS1, VS2, VS3 - Existed Customers PT Setting - [redmine: #198008]
	DB: DBCUST/CUSTDB and all replicated servers
*/
/*
	1) Dep_LicenseeProductSetting 
	2) Dep_CustDiscountGroupSetting_Member
	3) Dep_CustDiscountSetting_Member
	4) Dep_CustBetSetting_Agent
	5) Dep_CustBetSetting_Member
	6) Dep_CustPTGroupSetting_Member
	7) Dep_CustPTSetting_Agent
	8) Dep_CustPTSetting_Member
*/
-- BEGIN: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) AND DBCUST (Run last)-----
--------------------------------------------------------------------------------------
PRINT N'CLEAN PT SETTING: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
PRINT N'--------------------------------------------------------'
DECLARE @target VARCHAR(20)
		,@max_custid INT
		,@CustList   VARCHAR(MAX)
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

			SELECT @CustList = --parse JsonData
				(
					SELECT ca.CustID, ca.ProductSettingID
					FROM #tmpDep_LicenseeProductSetting_batch ca
					FOR JSON PATH
				)

			EXEC dbo.Acc_Dep_DynamicCustSetting_09 
				  @CustList = @CustList
				, @TableName = @__tableName
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:0.050'
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

			SELECT @CustList = --parse JsonData
				(
					SELECT c.CustID, c.SportType, c.BetType
					FROM #tblCustomer_batch c
					FOR JSON PATH
				)
	
			EXEC dbo.Acc_Dep_DynamicCustSetting_09 
				  @CustList = @CustList
				, @TableName = @__tableName
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:0.050'
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

			SELECT @CustList = --parse JsonData
				(
					SELECT c.CustID, c.SportType, c.BetType
					FROM #tblCustomer_batch c
					FOR JSON PATH
				)
	
			EXEC dbo.Acc_Dep_DynamicCustSetting_09 
				  @CustList = @CustList
				, @TableName = @__tableName
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:0.050'
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

			SELECT @CustList = --parse JsonData
				(
					SELECT c.CustID, c.SportType, c.BetType
					FROM #tblCustomer_batch c
					FOR JSON PATH
				)
	
			EXEC dbo.Acc_Dep_DynamicCustSetting_09 
				  @CustList = @CustList
				, @TableName = @__tableName
				, @target = @target
			
		END

		WAITFOR DELAY '00:00:0.050'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END
END

PRINT N'--------------------------------------------------------'
PRINT N'CLEAN PT SETTING: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

DROP TABLE #tblCustomer, #tblCustomer_batch, #Dep_ProductSettingDetail, #tmpDep_LicenseeProductSetting, #tmpDep_LicenseeProductSetting_batch
GO
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (/06/DBTP) AND DBCUST (Run last) -----
-----------------------------------------------------------------------------------	
