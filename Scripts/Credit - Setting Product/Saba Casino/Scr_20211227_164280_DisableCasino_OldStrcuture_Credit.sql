/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211227@Eden
	Task: Disable Casino - old structure - Credit [#164280]
	DB: DBCUST/CustDB and all subscriber of CustDB_custseting Pub
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_ExecRep_Cust_09]
	@srecommend INT	
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB-60\DevDBcust')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB-60\DevDBcust')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	
	DECLARE @BatchNum		INT = 5000

	CREATE TABLE #MemberTemp(CustID INT PRIMARY KEY CLUSTERED,)
	
	CREATE TABLE #MemberTempBatch(CustID INT)

	CREATE TABLE #SMATemp(CustID INT PRIMARY KEY CLUSTERED)

	INSERT INTO #MemberTemp (CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1  AND Enabled = 1
	
	INSERT INTO #SMATemp (CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND Enabled = 1
	
	------------------------------------------------------------------------
	UPDATE ci
	SET ci.DisableCasino = 1,
		ci.SyncCasino = 0
	FROM custInfo ci WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #SMATemp t ON ci.custid = t.CustID

	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #MemberTempBatch

		DELETE TOP(@BatchNum) #MemberTemp
		OUTPUT deleted.CustID INTO #MemberTempBatch(CustID)

		IF @@ROWCOUNT = 0
			BREAK;

		UPDATE ci
		SET ci.DisableCasino = 1,
			ci.SyncCasino = 0
		FROM custInfo ci WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #MemberTempBatch t ON ci.custid = t.CustID
	END

	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
	DROP TABLE #MemberTempBatch
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
PRINT N'Step 4: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB-60\DevDBcust')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

IF	OBJECT_ID('tempdb..#supers') IS NOT NULL DROP TABLE	#supers;
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @srecommend INT

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN custinfo c WITH(NOLOCK) ON ci.custid = c.custid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	and c.Enabled = 1			
	AND ci.Site <> 'CN88'
	AND ci.currency IN (
				2	-- 	RM
			,	3	-- 	US$
			,	5	-- 	HK$
			,	6	-- 	EURO
			,	10	-- 	INR1
			,	13	-- 	RMB
			,	15	-- 	IN
			,	16	-- 	Yen
			,	22	-- 	IND
			,	33	-- 	IDD
			,	34	-- 	IDR
			,	35	-- 	$US
			,	43	-- 	THB
			,	45	-- 	WON
			,	47	-- 	DDD
			,	64	-- 	UT
			,	67	-- 	HKK
			,	69	-- 	MMK
			,	95	-- 	USD
			,	20
				)

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.[Acc_ExecRep_Cust_09] 
			 @srecommend = @srecommend
			,@target = @target
			
			
	waitfor delay '00:00:0.200'
END
GO

PRINT N'Step 4: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 