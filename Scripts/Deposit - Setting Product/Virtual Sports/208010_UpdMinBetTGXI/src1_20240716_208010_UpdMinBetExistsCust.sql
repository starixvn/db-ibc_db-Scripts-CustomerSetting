/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240716@Winfred
	Task: [TGXI] - Adjust minbet for Virtual Sports Exists customer [Redmine: #208010]
	DB: DBCust/CustDB and all replicated servers
*/
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	 @target VARCHAR(20),
	 @CustList XML,
	 @mode	 TINYINT -- 1 ~ SMA, 2 ~ Member
AS
BEGIN	
	SET NOCOUNT ON;
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbcust only
	
	IF (dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0	
		)
		RETURN
	
	CREATE TABLE #tbCustomer(
				 CustID	INT
				,RoleID TINYINT
				,SportType SMALLINT DEFAULT (9908)
				,BetType SMALLINT DEFAULT (1201)
				,PRIMARY KEY CLUSTERED (CustID, Sporttype, Bettype))


	INSERT INTO #tbCustomer (CustID, RoleID)
	SELECT   t.c.value('@CustID','INT')		AS CustID
			,t.c.value('@RoleID','TINYINT')	AS RoleID
	FROM @CustList.nodes('root') t(c)

	IF @mode=1 --For SMA
	BEGIN

		BEGIN --Bet Setting
			--Dep_CustBetSetting_Agent
			UPDATE main
			SET main.minbet	= 5
			FROM dbo.Dep_CustBetSetting_Agent main WITH(ROWLOCK)
				INNER JOIN #tbCustomer tmp	ON main.CustID=tmp.CustID AND tmp.SportType = main.sporttype AND tmp.BetType = main.bettype
		END
	END

	IF @mode=2 --For Member
	BEGIN
		UPDATE main
		SET main.minbet	= 5
		FROM dbo.Dep_CustBetSetting_Member main WITH(ROWLOCK)
			INNER JOIN #tbCustomer tmp	ON main.CustID=tmp.CustID AND tmp.SportType = main.sporttype AND tmp.BetType = main.bettype
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
PRINT N'COPY SETTING: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
PRINT N'--------------------------------------------------------'
DECLARE @target VARCHAR(20)
		,@max_custid INT
		,@CustList   XML
		,@BatchSize	INT = 5000
		,@srecommend INT

SELECT @max_custid = xxx

IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
CREATE TABLE #SMAs (CustID INT PRIMARY KEY, RoleID TINYINT)
CREATE TABLE #Members (CustID INT PRIMARY KEY)
CREATE TABLE #tbCustomers_batch (CustID INT PRIMARY KEY, RoleID TINYINT)

---------------------------------------------------------------------------------------------
SET @srecommend = 52761582 

--Dummy line
INSERT INTO #Dummy(CustID)
SELECT c.CustID 
FROM Customer c WITH(NOLOCK) 
WHERE c.roleid=3 
	AND c.srecommend = @srecommend
	AND c.custid <= @max_custid
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

--SMAs
INSERT INTO #SMAs (CustID, RoleID)
SELECT c.custid, c.roleid
FROM dbo.CustInfo c WITH(NOLOCK)
WHERE mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND c.srecommend = @srecommend
	AND c.custid <= @max_custid
	AND c.roleid IN (2,3,4)
	AND c.Enabled=1

--Members
INSERT INTO #Members (CustID)
SELECT c.custid
FROM dbo.CustInfo c WITH(NOLOCK)
WHERE mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND c.srecommend = @srecommend
	AND c.custid <= @max_custid
	AND c.roleid = 1
	AND c.Enabled=1
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
DECLARE @Cust_cnt INT

SELECT @Cust_cnt = COUNT(1)
FROM #SMAs

SELECT @Cust_cnt += COUNT(1)
FROM #Members

DECLARE @msg_total NVARCHAR(200) = 'Total of Customers Affected: %d.'

RAISERROR (@msg_total, 0, 1, @Cust_cnt) WITH NOWAIT

--For SMA
WHILE (1 = 1)
BEGIN
	DELETE FROM #tbCustomers_batch

	DELETE TOP (@BatchSize) T
	OUTPUT deleted.CustID, deleted.RoleID
		INTO #tbCustomers_batch(CustID,RoleID)
	FROM #SMAs t 

	IF @@ROWCOUNT = 0 BREAK
	
	SELECT @CustList=(SELECT CustID	AS '@CustID' 
							,RoleID AS '@RoleID'
					FROM #tbCustomers_batch
					FOR XML PATH('root')
				)

	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] 
				@target = @target,
				@CustList=@CustList,
				@mode = 1
	
	WAITFOR DELAY '00:00:0.050'

	SET @msg_total = 'Agent - Curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)

	RAISERROR (@msg_total, 0, 1) WITH NOWAIT
END			
	
--For Member
WHILE (1 = 1)
BEGIN
	DELETE FROM #tbCustomers_batch

	DELETE TOP (@BatchSize) T
	OUTPUT deleted.CustID, 1
		INTO #tbCustomers_batch(CustID,RoleID)
	FROM #Members t 

	IF @@ROWCOUNT = 0 BREAK
	
	SELECT @CustList=(SELECT CustID	AS '@CustID' 
							,RoleID AS '@RoleID'
					FROM #tbCustomers_batch
					FOR XML PATH('root')
				)

	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] 
				@target = @target,
				@CustList=@CustList,
				@mode = 2
	
	WAITFOR DELAY '00:00:0.050'

	SET @msg_total = 'Member - Curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)

	RAISERROR (@msg_total, 0, 1) WITH NOWAIT
END		
	
PRINT N'--------------------------------------------------------'
PRINT N'COPY SETTING: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

DROP TABLE #SMAs, #Members, #tbCustomers_batch, #Dummy
GO
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (/06/DBTP) AND DBCUST (Run last) -----
-----------------------------------------------------------------------------------	
