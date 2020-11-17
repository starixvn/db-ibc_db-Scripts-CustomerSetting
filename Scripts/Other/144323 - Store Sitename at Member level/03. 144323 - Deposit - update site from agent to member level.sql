/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Tina@20201103
	Task: Store Sitename at Member level - https://nexdev.net/issues/144323
	DB: DBCUST/CustDB
*/ 
ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09]
	@srecommend INT
	,@max_custid INT
	,@target VARCHAR(20)
AS
BEGIN
-- BEGIN STEP 1: DEPLOY THESE SP @ DBCUST.CustDB -----
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('customer') = 0 RETURN

	CREATE TABLE #MemberTemp
	(
		[CustID] INT
		,[Site] VARCHAR(10)
	)

	CREATE TABLE #MemberUpdated
	(
		[CustID] INT PRIMARY KEY CLUSTERED
		,[Site] VARCHAR(10)
	)
	
	DECLARE @index INT = 0
	DECLARE @msg NVARCHAR(200) = 'Currently at order %d.'

	INSERT INTO #MemberTemp (CustID, [Site])
	SELECT ci.custid, ca.[site]
	FROM Customer ci WITH (NOLOCK)
		INNER JOIN Customer ca WITH (NOLOCK) ON ci.[recommend] = ca.custid
	WHERE ci.srecommend = @srecommend AND ci.roleid = 1 AND ci.custid <= @max_custid

	WHILE (1 = 1)
	BEGIN

		TRUNCATE TABLE #MemberUpdated

		DELETE TOP (3000) 
		#MemberTemp
		OUTPUT deleted.CustID, deleted.[Site]
		INTO #MemberUpdated(CustID, [Site])
	
		IF @@ROWCOUNT = 0 BREAK
	
		SET @index = @index + 1
	
		RAISERROR (@msg, 0, 1,@index) WITH NOWAIT
			
		UPDATE C SET C.[site] = mu.[site]
		FROM #MemberUpdated mu
			INNER JOIN Customer C WITH (ROWLOCK, UPDLOCK) ON mu.CustID = C.custid
			
		WAITFOR DELAY '00:00:0.020'
	
	END

END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (srecommend int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

-- list of supers
INSERT INTO #supers(srecommend)
SELECT cs.custid
FROM customer cs WITH (NOLOCK) 
WHERE cs.roleid = 4 AND cs.custid IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK)) -- Get deposit super 

-- For deployer info
DECLARE @totalCust_cnt INT, @index INT = 0
SET @totalCust_cnt = (SELECT COUNT(1) FROM #supers )
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, srecommend: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of affected srecommend: %d.'
RAISERROR (@msg_total, 0, 1, @totalCust_cnt) WITH NOWAIT
		
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = srecommend	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
			
	EXEC [dbo].[Acc_DynamicCustomerInfo_09] @srecommend = @srecommend
			,@max_custid = @max_custid
			,@target = 'REPLICATED'
			
	WAITFOR DELAY '00:00:0.100'
	
END

GO
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (srecommend int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

-- list of supers
INSERT INTO #supers(srecommend)
SELECT cs.custid
FROM customer cs WITH (NOLOCK) 
WHERE cs.roleid = 4 AND cs.custid IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK)) -- Get deposit super 

-- For deployer info
DECLARE @totalCust_cnt INT, @index INT = 0
SET @totalCust_cnt = (SELECT COUNT(1) FROM #supers )
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, srecommend: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of affected srecommend: %d.'
RAISERROR (@msg_total, 0, 1, @totalCust_cnt) WITH NOWAIT
		
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = srecommend	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
			
	EXEC [dbo].[Acc_DynamicCustomerInfo_09] @srecommend = @srecommend
			,@max_custid = @max_custid
			,@target = 'DBCUST'
			
	WAITFOR DELAY '00:00:0.100'
	
END
GO