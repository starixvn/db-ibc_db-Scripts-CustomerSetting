/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20240220
	Task: WE Live Casino - Clean redundant customer setting data - Existing Customers
		https://nexdev.net/issues/195886
	DB: DBCust/CustDB and all replicated server
*/ 
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	 @CustList NVARCHAR(MAX)
	,@mode TINYINT	-- 1 ~ SMA; 2 ~ Member
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at DBCUST only
	
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN

	CREATE TABLE #tbCustomer(CustID	INT
							,SportType SMALLINT DEFAULT (228)
							,BetType SMALLINT DEFAULT (10300)
							,PRIMARY KEY CLUSTERED (CustID, Sporttype, Bettype))

	INSERT INTO #tbCustomer (CustID)
	SELECT TRIM(ss.value)
	FROM STRING_SPLIT(@CustList, ',') ss
	WHERE TRIM(ss.value)<>''

	--SMA		
	IF @mode=1
	BEGIN
		CREATE TABLE #tbCustStakeLevel_Agent(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype ))
			
		INSERT INTO #tbCustStakeLevel_Agent(CustID, SportType, BetType)
		SELECT a.CustID, a.SportType, a.BetType
		FROM CustStakeLevel_Agent a WITH(NOLOCK)
			INNER JOIN #tbCustomer ci WITH(NOLOCK) 
					ON a.CustID = ci.custid
					AND a.SportType = ci.SportType 
					AND a.BetType = ci.BetType

		DELETE cg
		FROM dbo.CustStakeLevel_Agent cg WITH(ROWLOCK)	
		INNER JOIN #tbCustStakeLevel_Agent ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

		DROP TABLE #tbCustStakeLevel_Agent
	END
	ELSE IF @mode=2 --Member
	BEGIN
		CREATE TABLE #tbCustStakeLevel_Member(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype ))
			
		INSERT INTO #tbCustStakeLevel_Member(CustID, SportType, BetType)
		SELECT a.CustID, a.SportType, a.BetType
		FROM CustStakeLevel_Member a WITH(NOLOCK)
			INNER JOIN #tbCustomer ci WITH(NOLOCK) 
					ON a.CustID = ci.custid
					AND a.SportType = ci.SportType 
					AND a.BetType = ci.BetType
			
		DELETE cg
		FROM dbo.CustStakeLevel_Member cg WITH(ROWLOCK)		
		INNER JOIN #tbCustStakeLevel_Member ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

		DROP TABLE #tbCustStakeLevel_Member
	END

END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST-----
----------------------------------------------------------------------------------------------
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
----------------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

DECLARE @Cust_cnt	INT,
		@max_custid INT,
		@CustList   NVARCHAR(MAX)

SELECT @max_custid = xxx

CREATE TABLE #SMA (CustID INT PRIMARY KEY)
CREATE TABLE #Member (CustID INT PRIMARY KEY)
CREATE TABLE #Customer_batch (CustID INT PRIMARY KEY)

------------------------------------------------
--SMA
INSERT INTO #SMA(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 
INNER JOIN Customer c WITH (NOLOCK) ON c.custid=ci.custid
WHERE ci.roleid in (2,3,4)  
	AND ci.srecommend NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND ci.custid <= @max_custid
	AND (ci.currency<>20 OR c.site='777777')

--Member
INSERT INTO #Member(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 
INNER JOIN Customer c WITH (NOLOCK) ON c.custid=ci.custid
WHERE ci.roleid=1  
	AND ci.srecommend NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND ci.custid <= @max_custid
	AND (ci.currency<>20 OR c.site='777777')

-- For deployer info
---------------------------------------------------------------------------------------------
SELECT @Cust_cnt = COUNT(1)
FROM #SMA

SELECT @Cust_cnt += COUNT(1)
FROM #Member

DECLARE @msg_total NVARCHAR(200) = 'Total of Customers Affected: %d.'

RAISERROR (@msg_total, 0, 1, @Cust_cnt) WITH NOWAIT

--For SMA
WHILE (1=1)
BEGIN
	DELETE FROM #Customer_batch

	DELETE TOP (3000) T
	OUTPUT deleted.CustID
		INTO #Customer_batch(CustID)
	FROM #SMA t 

	IF @@ROWCOUNT = 0 BREAK

	SELECT @CustList=STUFF ((SELECT ',' + CAST(custid AS VARCHAR(20))
							 FROM #Customer_batch
							 FOR XML PATH('')), 1, 1, '')
	
	EXEC dbo.[Acc_DynamicCustSetting3rd_09] 
			@CustList=@CustList,
			@mode=1,
			@target = @target
	
	WAITFOR DELAY '00:00:0.050'

	SET @msg_total = 'SMA - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)

	RAISERROR (@msg_total, 0, 1) WITH NOWAIT
END	

--For Member
WHILE (1=1)
BEGIN
	DELETE FROM #Customer_batch

	DELETE TOP (3000) T
	OUTPUT deleted.CustID
		INTO #Customer_batch(CustID)
	FROM #Member t 

	IF @@ROWCOUNT = 0 BREAK

	SELECT @CustList=STUFF ((SELECT ',' + CAST(custid AS VARCHAR(20))
							 FROM #Customer_batch
							 FOR XML PATH('')), 1, 1, '')

	EXEC dbo.[Acc_DynamicCustSetting3rd_09]
			@CustList=@CustList,
			@mode=2,
			@target = @target
	
	WAITFOR DELAY '00:00:0.050'

	SET @msg_total = 'Member - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)

	RAISERROR (@msg_total, 0, 1) WITH NOWAIT
END	

DROP TABLE #SMA, #Member, #Customer_batch
GO	

PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
GO

-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
-----------------------------------------------------------------------------------
