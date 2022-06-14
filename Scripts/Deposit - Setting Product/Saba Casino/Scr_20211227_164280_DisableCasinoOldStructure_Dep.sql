/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211227@Eden
	Task: Disable Casino - old structure - Deposit  [#164280]
	DB: DBCUST/CustDB and all subscriber of CustDB_custseting Pub
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_ExecRep_Cust_09]
 	 @srecommend INT	
	, @target VARCHAR(20)
	
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
-- END STEP 5.1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 5.2: Run this SP at replicated DB: DB06, DBTP -----
--------------------------------------------------------------------------------------
PRINT N'Step 5: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB-60\DevDBcust')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
		DROP TABLE	#supers;
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @srecommend INT

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'
		AND ci.Enabled=1
		AND cs.site IN ('11bet'
						,'12Bet'
						,'368Cash'
						,'3star88'
						,'88Macao'
						,'9bet'
						,'9Club'
						,'9wickets'
						,'Ae88'
						,'AG'
						,'AOGcasino'
						,'Aoncash'
						,'asiabet88'
						,'Athena000'
						,'BE7'
						,'Bolanation'
						,'Boma365'
						,'Dabet'
						,'DEWA'
						--,'Fabet'
						,'FB88'
						,'Happy1668'
						,'Heaven'
						,'HonorW'
						,'iBET'
						,'IONclub'
						,'ISC888'
						,'ITCbet'
						,'Kbet'
						,'Liga'
						,'LIGAWLHKB'
						--,'Lucky88'
						,'M8bola'
						,'Macaubet'
						,'N88'
						,'N8B'
						,'N8G'
						,'Nova88'
						,'OLE777'
						,'One88'
						,'OXbet'
						,'Q8bola'
						--,'Red88'
						,'RICbet'
						,'Saba789'
						,'Senibet'
						,'Sin88'
						,'Sky88'
						,'spondemo'
						,'TIC88'
						,'TLC'
						,'UN168'
						,'Unobet'
						,'Uwoniwin'
						,'webet88'
						,'XO88'
						,'Zbet'
						)
		AND Ci.currency IN (
								2	-- 	RM
							,	3	-- 	US$
							,	4	-- 	TB
							,	6	-- 	EURO
							,	12	-- 	GBP
							,	13	-- 	RMB
							,	15	-- 	IN
							,	45	-- 	WON
							,	51	-- 	INH
							,	61	-- 	INR
							,	66	-- 	YUN
							,	70	-- 	MKK
							,	96	-- 	USDT
							,	20	--	UUS
							)
		ORDER BY ci.custid 

DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	
	
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_ExecRep_Cust_09] @srecommend = @srecommend, @target = @target
				
	WAITFOR DELAY '00:00:00.280'			
END	

DROP TABLE #supers		
GO
PRINT N'Step 5: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
