/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20231101
	Task: RNG Slot products - clean redundant data - Credit
		https://nexdev.net/issues/194331
	DB: DBCust/CustDB and all replicated server
*/
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@CustList NVARCHAR(MAX)
	,@mode TINYINT	-- 1 ~ SMA; 2 ~ Member
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')) RETURN -- run at DBCUST only

	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('ProductSettingDetail') = 0 RETURN	

	CREATE TABLE #tbCustomer (
				 CustID	INT
				,SportType SMALLINT
				,BetType SMALLINT
				,PRIMARY KEY CLUSTERED (CustID, Sporttype, Bettype))
	
	INSERT INTO #tbCustomer (CustID, SportType, BetType)
	SELECT  TRIM(value)	AS CustID, s.SportType, s.BetType
	FROM STRING_SPLIT(@CustList,',') t
	CROSS APPLY (SELECT psd.SportType, psd.BetType
				 FROM ProductSettingDetail psd WITH (NOLOCK)
				 WHERE SettingType=8 AND ProductID=18
				 AND SettingStatus = 2) s
	WHERE TRIM(value)<>''

	DECLARE @batch INT = 3000

	IF @mode=1	--SMA
	BEGIN
		--Credit
		CREATE TABLE #tbCustStakeLevel_Agent(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID,Sporttype,Bettype ))
			
		CREATE TABLE #tbCustStakeLevel_AgentTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID,Sporttype,Bettype ))

		INSERT INTO #tbCustStakeLevel_Agent(CustID, SportType, BetType)
		SELECT a.CustID, a.SportType, a.BetType
		FROM CustStakeLevel_Agent a WITH(NOLOCK)
		INNER JOIN #tbCustomer c ON c.CustID=a.CustID
								AND c.SportType=a.SportType
								AND c.BetType=a.BetType

		WHILE EXISTS(SELECT TOP 1 1 FROM #tbCustStakeLevel_Agent)
		BEGIN
			DELETE TOP (@batch) #tbCustStakeLevel_Agent OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
			INTO #tbCustStakeLevel_AgentTemp(CustID, SportType, BetType)

			IF @@ROWCOUNT=0
				BREAK
			
			DELETE cg
			FROM dbo.CustStakeLevel_Agent cg WITH(ROWLOCK)		
			INNER JOIN #tbCustStakeLevel_AgentTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

			TRUNCATE TABLE #tbCustStakeLevel_AgentTemp

			WAITFOR DELAY '00:00:00:030'
		END

		DROP TABLE #tbCustStakeLevel_Agent
		DROP TABLE #tbCustStakeLevel_AgentTemp
	END
	
	IF @mode=2	--Member
	BEGIN
		CREATE TABLE #tbCustStakeLevel_Member(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID,Sporttype,Bettype))

		CREATE TABLE #tbCustStakeLevel_MemberTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID,Sporttype,Bettype))
			
		INSERT INTO #tbCustStakeLevel_Member(CustID, SportType, BetType)
		SELECT a.CustID, a.SportType, a.BetType
		FROM CustStakeLevel_Member a WITH(NOLOCK)
		INNER JOIN #tbCustomer c ON c.CustID=a.CustID
								AND c.SportType=a.SportType
								AND c.BetType=a.BetType

		WHILE EXISTS(SELECT TOP 1 1 FROM #tbCustStakeLevel_Member)
		BEGIN
			DELETE TOP (@batch) #tbCustStakeLevel_Member OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
			INTO #tbCustStakeLevel_MemberTemp(CustID, SportType, BetType)

			IF @@ROWCOUNT=0
				BREAK
			
			DELETE cg
			FROM dbo.CustStakeLevel_Member cg WITH(ROWLOCK)		
			INNER JOIN #tbCustStakeLevel_MemberTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

			TRUNCATE TABLE #tbCustStakeLevel_MemberTemp

			WAITFOR DELAY '00:00:00:030'
		END

		DROP TABLE #tbCustStakeLevel_Member
		DROP TABLE #tbCustStakeLevel_MemberTemp
	END
END
GO
------------------------------------------------------	
-- BEGIN: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST-----
----------------------------------------------------------------------------------------------
PRINT N'CREDIT - Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
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
		@CustList   NVARCHAR(MAX),
		@BatchSize	INT = 1500

SELECT @max_custid = xxx
	
CREATE TABLE #SMA(CustID INT PRIMARY KEY)

CREATE TABLE #Member(CustID INT PRIMARY KEY)

CREATE TABLE #Customer_batch(CustID INT PRIMARY KEY)

------------------------------------------------
--SMA
INSERT INTO #SMA(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
LEFT JOIN Dep_CustSuper cs WITH (NOLOCK) ON cs.custid=ci.srecommend
WHERE ci.custid <= @max_custid
AND ci.roleid IN (2,3,4)  
AND cs.custid IS NULL

--Member
INSERT INTO #Member(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
LEFT JOIN Dep_CustSuper cs WITH (NOLOCK) ON cs.custid=ci.srecommend
WHERE ci.custid <= @max_custid
AND ci.roleid = 1
AND cs.custid IS NULL

---------------------------------------------------------------------------------------------

SELECT @Cust_cnt = COUNT(1)
FROM #SMA

SELECT @Cust_cnt += COUNT(1)
FROM #Member

DECLARE @msg_total NVARCHAR(200) = 'Credit - Total of Customers Affected: %d.'

RAISERROR (@msg_total, 0, 1, @Cust_cnt) WITH NOWAIT

--For SMA
WHILE (1=1)
BEGIN
	DELETE FROM #Customer_batch

	DELETE TOP (@BatchSize) T
	OUTPUT deleted.CustID
		INTO #Customer_batch(CustID)
	FROM #SMA t 

	IF @@ROWCOUNT = 0 BREAK

	SELECT @CustList=STUFF((SELECT ',' + CAST(CustID AS VARCHAR)
							FROM #Customer_batch
							FOR XML PATH('')
							),1,1,'')
	
	EXEC dbo.[Acc_DynamicCustSetting3rd_09] 
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
	OUTPUT deleted.CustID
		INTO #Customer_batch(CustID)
	FROM #Member t 

	IF @@ROWCOUNT = 0 BREAK

	SELECT @CustList=STUFF((SELECT ',' + CAST(CustID AS VARCHAR)
							FROM #Customer_batch
							FOR XML PATH('')
							),1,1,'')

	EXEC dbo.[Acc_DynamicCustSetting3rd_09]
			@CustList=@CustList,
			@mode=2,
			@target = @target
	
	WAITFOR DELAY '00:00:00:280'

	SET @msg_total = 'Member - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)

	RAISERROR (@msg_total, 0, 1) WITH NOWAIT
END	

PRINT N'--------------------------------------------------------'
PRINT N'CREDIT - Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
GO

-- END: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
-----------------------------------------------------------------------------------
