/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20240607
	Task: VGaming & Virtual Games - clean data - Existed customers
		https://nexdev.net/issues/205654
	DB: DBCust/CustDB and all replicated server
*/
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@CustList VARCHAR(MAX) --JsonData
	,@TableName VARCHAR(200)
	,@target VARCHAR(20)
AS
/*
	1) Dep_LicenseeProductSetting 
	2) Dep_CustStakeLevel_Agent 
	3) Dep_CustStakeLevel_Member
*/
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')) RETURN -- run at DBCUST only

	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Member') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN	

	IF @TableName = 'Dep_LicenseeProductSetting' --1)
	BEGIN
		DELETE a
		FROM Dep_LicenseeProductSetting a WITH(ROWLOCK)
		INNER JOIN OPENJSON(@CustList) 
			WITH (CustID			INT	'$.CustID',
				  ProductSettingID	INT	'$.ProductSettingID'
				) AS js
			ON js.CustID=a.CustID AND js.ProductSettingID=a.ProductSettingID
	END

	IF @TableName = 'Dep_CustStakeLevel_Agent' --2)
	BEGIN
		DELETE a
		FROM Dep_CustStakeLevel_Agent a WITH(ROWLOCK)
		INNER JOIN OPENJSON(@CustList) 
			WITH (  CustID		INT	'$.CustID',
					SportType	SMALLINT	'$.SportType',
					BetType		SMALLINT	'$.BetType'
				) AS js
			ON js.CustID=a.CustID
			AND js.SportType=a.SportType
			AND js.BetType=a.BetType
	END
		
	IF @TableName = 'Dep_CustStakeLevel_Member' --3)
	BEGIN
		DELETE a
		FROM Dep_CustStakeLevel_Member a WITH(ROWLOCK)
		INNER JOIN OPENJSON(@CustList) 
			WITH (  CustID		INT	'$.CustID',
					SportType	SMALLINT '$.SportType',
					BetType		SMALLINT '$.BetType'
				) AS js
			ON js.CustID=a.CustID
			AND js.SportType=a.SportType
			AND js.BetType=a.BetType
	END
END
GO
------------------------------------------------------	
-- BEGIN: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST-----
----------------------------------------------------------------------------------------------
PRINT N'Existed Customers: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
PRINT N'--------------------------------------------------------'
DECLARE @target VARCHAR(20)
		,@max_custid INT
		,@CustList   VARCHAR(MAX)
		,@BatchSize	INT = 3000
		,@ReadBatchSize INT = 100000
		,@Cust_cnt INT, @idx INT=1

SELECT @max_custid = xxx--(SELECT MAX(CUSTID) FROM custInfo WITH (NOLOCK)) 

IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

---------------------------------------------------------------------------------------------
CREATE TABLE #Dep_ProductSettingDetail (ProductSettingID INT, SportType SMALLINT, BetType SMALLINT)

CREATE TABLE #tblCustomer(
				 CustID		INT
				,SportType	SMALLINT
				,BetType	SMALLINT
				,PRIMARY KEY CLUSTERED (CustID, Sporttype, Bettype))

CREATE TABLE #tblCustomer_batch(
				 CustID		INT
				,SportType	SMALLINT
				,BetType	SMALLINT
				,PRIMARY KEY CLUSTERED (CustID, Sporttype, Bettype))

CREATE TABLE #tmpDep_LicenseeProductSetting(
				 CustID		INT
				,ProductSettingID INT
				,PRIMARY KEY (CustID, ProductSettingID))
				
CREATE TABLE #tmpDep_LicenseeProductSetting_batch(
				 CustID		INT
				,ProductSettingID INT
				,PRIMARY KEY (CustID, ProductSettingID))
---------------------------------------------------------------------------------------------
--Get product setting
INSERT INTO #Dep_ProductSettingDetail(ProductSettingID, SportType, BetType)
SELECT ps.ProductSettingID, SportType, BetType
FROM Dep_ProductSettingDetail psd WITH(NOLOCK)
	INNER JOIN Dep_ProductSetting ps WITh(NOLOCK) ON psd.ProductSettingID=ps.ProductSettingID
WHERE ps.ProductID in (38,66) AND ps.SettingType IN (7,8)

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
DECLARE @__messageInfo VARCHAR(200), @__tableName VARCHAR(200)

DECLARE @msg_total NVARCHAR(200)

BEGIN --1) Dep_LicenseeProductSetting 
	SET @__tableName = 'Dep_LicenseeProductSetting'

	SELECT @Cust_cnt=COUNT(1)
	FROM Dep_LicenseeProductSetting  cs WITH (NOLOCK) 
	WHERE cs.CustID <= @max_custid
	AND cs.ProductSettingID IN (SELECT ps.ProductSettingID FROM #Dep_ProductSettingDetail ps)
	
	SET @msg_total = @__tableName + ' - Total of Rows Affected: %d.'

	RAISERROR (@msg_total, 0, 1, @Cust_cnt) WITH NOWAIT
	
	WHILE 1 = 1
	BEGIN
		INSERT INTO #tmpDep_LicenseeProductSetting(custid, ProductSettingID)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.ProductSettingID
		FROM Dep_LicenseeProductSetting  cs WITH (NOLOCK) 
		WHERE cs.CustID <= @max_custid
		AND cs.ProductSettingID IN (SELECT ps.ProductSettingID FROM #Dep_ProductSettingDetail ps)

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
		SET @__messageInfo = CAST(@idx AS VARCHAR(10)) + ' - tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT

		SET @idx += 1
	END
END

BEGIN --2) Dep_CustStakeLevel_Agent
	SELECT @__tableName = 'Dep_CustStakeLevel_Agent', @idx=1
	
	SELECT @Cust_cnt=COUNT(1)
	FROM Dep_CustStakeLevel_Agent cs WITH (NOLOCK) 
		INNER JOIN #Dep_ProductSettingDetail  s  ON s.SportType=cs.SportType
													AND s.BetType=cs.BetType
	WHERE cs.CustID <= @max_custid

	SET @msg_total = @__tableName + ' - Total of Rows Affected: %d.'

	RAISERROR (@msg_total, 0, 1, @Cust_cnt) WITH NOWAIT

	WHILE 1 = 1
	BEGIN
		INSERT INTO #tblCustomer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM Dep_CustStakeLevel_Agent cs WITH (NOLOCK) 
			INNER JOIN #Dep_ProductSettingDetail  s  ON s.SportType=cs.SportType
													AND s.BetType=cs.BetType
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
		SET @__messageInfo = CAST(@idx AS VARCHAR(10)) + ' - tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT

		SET @idx += 1
	END
END

BEGIN --3) Dep_CustStakeLevel_Member
	SELECT @__tableName = 'Dep_CustStakeLevel_Member', @idx=1

	SELECT @Cust_cnt=COUNT(1)
	FROM Dep_CustStakeLevel_Member cs WITH (NOLOCK) 
		INNER JOIN #Dep_ProductSettingDetail  s  ON s.SportType=cs.SportType
												AND s.BetType=cs.BetType
	WHERE cs.CustID <= @max_custid

	SET @msg_total = @__tableName + ' - Total of Rows Affected: %d.'

	RAISERROR (@msg_total, 0, 1, @Cust_cnt) WITH NOWAIT

	WHILE 1 = 1
	BEGIN
		INSERT INTO #tblCustomer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM Dep_CustStakeLevel_Member cs WITH (NOLOCK) 
			INNER JOIN #Dep_ProductSettingDetail  s  ON s.SportType=cs.SportType
													AND s.BetType=cs.BetType
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
		SET @__messageInfo = CAST(@idx AS VARCHAR(10)) + ' - tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT

		SET @idx += 1
	END
END

PRINT N'--------------------------------------------------------'
PRINT N'Existed Customers: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';


-- END: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
-----------------------------------------------------------------------------------
