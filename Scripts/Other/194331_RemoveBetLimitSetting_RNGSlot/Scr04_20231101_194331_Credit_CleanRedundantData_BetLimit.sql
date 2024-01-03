/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20231101
	Task: RNG Slot products - clean redundant data - Credit
		https://nexdev.net/issues/194331
	DB: DBCust/CustDB and all replicated server
*/
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_19]
	@CustList XML
	,@TableName VARCHAR(200)
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')) RETURN -- run at DBCUST only

	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN

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

	IF @TableName = 'CustStakeLevel_Agent'	--SMA
	BEGIN
		DELETE a
		FROM dbo.CustStakeLevel_Agent a WITH(ROWLOCK)		
		INNER JOIN #tbCustomer c ON c.CustID=a.CustID
							AND c.SportType=a.SportType
							AND c.BetType=a.BetType
	END
	
	IF @TableName = 'CustStakeLevel_Member'	--Member
	BEGIN
		DELETE a
		FROM dbo.CustStakeLevel_Member a WITH(ROWLOCK)		
		INNER JOIN #tbCustomer c ON c.CustID=a.CustID
							AND c.SportType=a.SportType
							AND c.BetType=a.BetType
	END
END
GO
------------------------------------------------------	
-- BEGIN: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST-----
----------------------------------------------------------------------------------------------
PRINT N'CREDIT - Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
PRINT N'--------------------------------------------------------'
----------------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

DECLARE @Cust_cnt	INT,
		@max_custid INT,
		@CustList   XML,
		@BatchSize	INT = 3000,
		@ReadBatchSize INT = 100000

SELECT @max_custid = xxx
	
CREATE TABLE #Customer(CustID	INT
				,SportType SMALLINT
				,BetType SMALLINT
				,PRIMARY KEY CLUSTERED (CustID, Sporttype, Bettype))

CREATE TABLE #Customer_batch(CustID	INT
				,SportType SMALLINT
				,BetType SMALLINT
				,PRIMARY KEY CLUSTERED (CustID, Sporttype, Bettype))

CREATE TABLE #SportRNG (SportType SMALLINT,BetType SMALLINT)

------------------------------------------------
INSERT INTO #SportRNG (SportType,BetType)
	  SELECT 155, 8699 --MG-RNG
UNION SELECT 156, 8999 --SEAL Entertainment
UNION SELECT 158, 5299 --Jili
UNION SELECT 165, 1901 --Arcadia Gaming
UNION SELECT 167, 7301 --CG
UNION SELECT 172, 7701 --AdvantPlay
UNION SELECT 174, 7801 --AdvantPlay Mini
UNION SELECT 212, 4001 --Macau Games
UNION SELECT 232, 6001 --PG Soft
UNION SELECT 234, 6401 --Joker
UNION SELECT 237, 5401 --MaxGame
UNION SELECT 238, 7001 --Habanero
UNION SELECT 247, 4301 --SG
UNION SELECT 248, 7000 --PP
UNION SELECT 155, 8400 --MG-RNG, old refBettype
UNION SELECT 156, 8900 --SEAL Entertainment, old refBettype

---------------------------------------------------------------------------------------------
DECLARE @__messageInfo VARCHAR(200), @__tableName VARCHAR(200)

--For SMA
BEGIN --CustStakeLevel_Agent
	SET @__tableName = 'CustStakeLevel_Agent'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #Customer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM CustStakeLevel_Agent cs WITH (NOLOCK) 
			INNER JOIN #SportRNG s ON s.SportType = cs.SportType AND s.BetType = cs.BetType
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
	
			EXEC dbo.Acc_DynamicCustSetting3rd_19 
				@CustList = @CustList
				, @TableName = @__tableName
				, @target = @target
			
		END

		--WAITFOR DELAY '00:00:00:280'

		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END
END


--For Member
BEGIN --CustStakeLevel_Member
	SET @__tableName = 'CustStakeLevel_Member'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #Customer(custid, SportType, BetType)
		SELECT TOP(@ReadBatchSize) cs.CustID, cs.SportType, cs.BetType
		FROM CustStakeLevel_Member cs WITH (NOLOCK) 
			INNER JOIN #SportRNG s ON s.SportType = cs.SportType AND s.BetType = cs.BetType
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
	
			EXEC dbo.Acc_DynamicCustSetting3rd_19 
				@CustList = @CustList
				, @TableName = @__tableName
				, @target = @target
			
		END

		--WAITFOR DELAY '00:00:00:280'

		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END
END

PRINT N'--------------------------------------------------------'
PRINT N'CREDIT - Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
GO

-- END: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
-----------------------------------------------------------------------------------
