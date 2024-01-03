/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20231101
	Task: RNG Slot products - clean redundant data - Deposit
		https://nexdev.net/issues/194331
	DB: DBCust/CustDB and all replicated server
*/
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_19]
	@CustList XML
	,@mode TINYINT	-- 1 ~ SMA; 2 ~ Member; 3 ~ Super : Dep_LicenseeProductSetting
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')) RETURN -- run at DBCUST only

	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Member') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN	

	IF @mode=3	--Super : Dep_LicenseeProductSetting
	BEGIN
		CREATE TABLE #tbSuper(
				 CustID	INT
				,ProductSettingID INT
				,PRIMARY KEY CLUSTERED (CustID, ProductSettingID))

		INSERT INTO #tbSuper (CustID, ProductSettingID)
		SELECT   t.c.value('@CustID','INT')				AS CustID
				,t.c.value('@ProductSettingID','INT')	AS ProductSettingID
		FROM @CustList.nodes('root') t(c)

		DELETE a
		FROM dbo.Dep_LicenseeProductSetting a WITH(ROWLOCK)		
		INNER JOIN #tbSuper c ON c.CustID=a.CustID
								AND c.ProductSettingID=a.ProductSettingID
		
		DROP TABLE #tbSuper
	END
	ELSE
	BEGIN
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

		IF @mode=1	--SMA
		BEGIN
			DELETE a
			FROM dbo.Dep_CustStakeLevel_Agent a WITH(ROWLOCK)		
			INNER JOIN #tbCustomer c ON c.CustID=a.CustID
								AND c.SportType=a.SportType
								AND c.BetType=a.BetType
		END
	
		IF @mode=2	--Member
		BEGIN
			DELETE a
			FROM dbo.Dep_CustStakeLevel_Member a WITH(ROWLOCK)		
			INNER JOIN #tbCustomer c ON c.CustID=a.CustID
								AND c.SportType=a.SportType
								AND c.BetType=a.BetType
		END
		
		DROP TABLE #tbCustomer
	END
END
GO
------------------------------------------------------	
-- BEGIN: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST-----
----------------------------------------------------------------------------------------------
PRINT N'DEPOSIT - Step 4: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
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
		@BatchSize	INT = 3000

SELECT @max_custid = xxx
	
CREATE TABLE #SMA(CustID	INT
				,SportType SMALLINT
				,BetType SMALLINT
				,PRIMARY KEY CLUSTERED (CustID, Sporttype, Bettype))

CREATE TABLE #Member(CustID	INT
				,SportType SMALLINT
				,BetType SMALLINT
				,PRIMARY KEY CLUSTERED (CustID, Sporttype, Bettype))

CREATE TABLE #Super(CustID	INT
				,ProductSettingID INT)

CREATE TABLE #Customer_batch(CustID	INT
				,SportType SMALLINT
				,BetType SMALLINT
				,ProductSettingID INT)

CREATE TABLE #SportRNG (SportType SMALLINT,BetType SMALLINT)

------------------------------------------------
INSERT INTO #SportRNG (SportType, BetType)
	  SELECT 155, 8699 --MG-RNG
UNION SELECT 156, 8900 --SEAL Entertainment
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

------------------------------------------------
--SMA : Dep_CustStakeLevel_Agent
INSERT INTO #SMA(custid, SportType, BetType)
SELECT cs.custid, cs.SportType, cs.BetType
FROM Dep_CustStakeLevel_Agent cs WITH (NOLOCK) 
INNER JOIN #SportRNG s ON s.SportType=cs.SportType AND s.BetType=cs.BetType
LEFT JOIN Customer c WITH (NOLOCK) ON cs.custid=c.custid
WHERE cs.custid <= @max_custid
AND c.CustID IS NULL

--Member : Dep_CustStakeLevel_Member
INSERT INTO #Member(custid, SportType, BetType)
SELECT cs.custid, cs.SportType, cs.BetType
FROM Dep_CustStakeLevel_Member cs WITH (NOLOCK) 
INNER JOIN #SportRNG s ON s.SportType=cs.SportType AND s.BetType=cs.BetType
LEFT JOIN Customer c WITH (NOLOCK) ON cs.custid=c.custid
WHERE cs.custid <= @max_custid
AND c.CustID IS NULL

--Super : Dep_LicenseeProductSetting
INSERT INTO #Super(CustID, ProductSettingID)
SELECT d.CustID, d.ProductSettingID
FROM Dep_LicenseeProductSetting d WITH (NOLOCK)
LEFT JOIN Customer c WITH (NOLOCK) ON c.custid=d.CustID
WHERE c.custid IS NULL
AND d.custid <= @max_custid
---------------------------------------------------------------------------------------------

SELECT @Cust_cnt = COUNT(1)
FROM #SMA

SELECT @Cust_cnt += COUNT(1)
FROM #Member

SELECT @Cust_cnt += COUNT(1)
FROM #Super

DECLARE @msg_total NVARCHAR(200) = 'Deposit - Total of Redundant Data Affected: %d.'

RAISERROR (@msg_total, 0, 1, @Cust_cnt) WITH NOWAIT

--For SMA
WHILE (1=1)
BEGIN
	DELETE FROM #Customer_batch

	DELETE TOP (@BatchSize) T
	OUTPUT deleted.CustID, deleted.SportType, deleted.BetType
		INTO #Customer_batch(CustID, SportType, BetType)
	FROM #SMA t 

	IF @@ROWCOUNT = 0 BREAK

	SELECT @CustList=(SELECT CustID		AS '@CustID', 
							 SportType	AS '@SportType',
							 BetType	AS '@BetType'
					  FROM #Customer_batch
					  FOR XML PATH('root')
					 )
	
	EXEC dbo.[Acc_Dep_DynamicCustSetting_19] 
			@CustList=@CustList,
			@mode=1,
			@target = @target
	
	WAITFOR DELAY '00:00:00:280'

	SET @msg_total = 'SMA - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)

	RAISERROR (@msg_total, 0, 1) WITH NOWAIT
END	

--For Member
WHILE (1=1)
BEGIN
	DELETE FROM #Customer_batch

	DELETE TOP (@BatchSize) T
	OUTPUT deleted.CustID, deleted.SportType, deleted.BetType
		INTO #Customer_batch(CustID, SportType, BetType)
	FROM #Member t 

	IF @@ROWCOUNT = 0 BREAK

	SELECT @CustList=(SELECT CustID		AS '@CustID', 
							 SportType	AS '@SportType',
							 BetType	AS '@BetType'
					  FROM #Customer_batch
					  FOR XML PATH('root')
					 )

	EXEC dbo.[Acc_Dep_DynamicCustSetting_19]
			@CustList=@CustList,
			@mode=2,
			@target = @target
	
	WAITFOR DELAY '00:00:00:280'

	SET @msg_total = 'Member - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)

	RAISERROR (@msg_total, 0, 1) WITH NOWAIT
END	

--For Super - Dep_LicenseeProductSetting
WHILE (1=1)
BEGIN
	DELETE FROM #Customer_batch

	DELETE TOP (@BatchSize) T
	OUTPUT deleted.CustID, deleted.ProductSettingID
		INTO #Customer_batch(CustID, ProductSettingID)
	FROM #Super t 

	IF @@ROWCOUNT = 0 BREAK

	SELECT @CustList=(SELECT CustID				AS '@CustID', 
							 ProductSettingID	AS '@ProductSettingID'
					  FROM #Customer_batch
					  FOR XML PATH('root')
					 )

	EXEC dbo.[Acc_Dep_DynamicCustSetting_19]
			@CustList=@CustList,
			@mode=3,
			@target = @target
	
	WAITFOR DELAY '00:00:00:280'

	SET @msg_total = 'Super - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)

	RAISERROR (@msg_total, 0, 1) WITH NOWAIT
END	


PRINT N'--------------------------------------------------------'
PRINT N'DEPOSIT - Step 4: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
GO

-- END: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
-----------------------------------------------------------------------------------
