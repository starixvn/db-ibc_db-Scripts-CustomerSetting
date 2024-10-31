/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20241003
	Task: NovaCasino - Init default value - EXISTS CUST [Redmine: #211405]
	DB: DBCust/CustDB and all replicated server
*/ 
-- BEGIN: DEPLOY THIS SP --------
ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09]
	 @CustList		VARCHAR(MAX)
	,@target		VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at DBCUST only
	
	IF  dbo.f_CheckRepTable('CustSuper') = 0	RETURN
	IF  dbo.f_CheckRepTable('CustMaster') = 0	RETURN
	IF  dbo.f_CheckRepTable('CustAgent') = 0	RETURN
	
	DECLARE @Default BINARY(2)=0x00
	
	CREATE TABLE #CustList (CustID INT PRIMARY KEY, RoleId TINYINT)
	
	INSERT INTO #CustList(CustID, RoleId)
	SELECT CustID, RoleId 
	FROM OPENJSON(@CustList) WITH (
		CustID		INT		'$.CustID',
		RoleId		TINYINT	'$.RoleId' 
	)
	WHERE ISJSON(@CustList) = 1
	
	IF EXISTS (SELECT TOP 1 1 FROM #CustList WHERE RoleId=4)
	BEGIN
		UPDATE c
		SET c.IsSynced=@Default
		FROM CustSuper c WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #CustList t ON t.CustID=c.custid
		WHERE t.RoleId=4
	END

	IF EXISTS (SELECT TOP 1 1 FROM #CustList WHERE RoleId=3)
	BEGIN
		UPDATE c
		SET c.IsSynced=@Default
		FROM CustMaster c WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #CustList t ON t.CustID=c.custid
		WHERE t.RoleId=3
	END

	IF EXISTS (SELECT TOP 1 1 FROM #CustList WHERE RoleId=2)
	BEGIN
		UPDATE c
		SET c.IsSynced=@Default
		FROM CustAgent c WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #CustList t ON t.CustID=c.custid
		WHERE t.RoleId=2
	END

	DROP TABLE #CustList
END
GO

-- END: DEPLOY THIS SP --------
------------------------------------------------------	
PRINT N'Exists Customer: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

DECLARE @target VARCHAR(20)

IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

CREATE TABLE #tbCustomer(CustID	INT PRIMARY KEY, RoleId TINYINT)

CREATE TABLE #Customer_batch(CustID	INT PRIMARY KEY, RoleId TINYINT)

DECLARE @max_custid INT, 
		@Cust_cnt	INT,
		@CustList	VARCHAR(MAX)
		,@Batch		INT = 2000
		,@TotalBatch INT

SELECT @max_custid = xxx

INSERT INTO #tbCustomer(CustID, RoleId)
SELECT c.custid, c.roleid
FROM custInfo c WITH (NOLOCK) 
LEFT JOIN Dep_CustSuper cs WITH(NOLOCK)	ON cs.custid=c.srecommend
WHERE cs.custid IS NULL AND c.roleid IN (2,3,4)
	AND c.Enabled=1 AND c.custid <= @max_custid
	
-- For deployer info
---------------------------------------------------------------------------------------------
SELECT @Cust_cnt = COUNT(1)
FROM #tbCustomer

DECLARE @msg_total NVARCHAR(200) = 'Total of Customers Affected: %d.'

RAISERROR (@msg_total, 0, 1, @Cust_cnt) WITH NOWAIT

SELECT @TotalBatch = CAST(@Cust_cnt/@Batch AS INT) + CASE WHEN COUNT(1)%@Batch <> 0 THEN 1 ELSE 0 END --MOD

DECLARE @i INT = 1

WHILE (1=1)
BEGIN
	DELETE FROM #Customer_batch

	DELETE TOP (@Batch) T
	OUTPUT deleted.CustID, deleted.RoleId
		INTO #Customer_batch(CustID, RoleId)
	FROM #tbCustomer t 

	IF @@ROWCOUNT = 0 BREAK

	SELECT @CustList = --parse JsonData
				(
					SELECT ca.CustID, ca.RoleId
					FROM #Customer_batch ca
					FOR JSON PATH
				)

	
	EXEC dbo.Acc_DynamicCustomerInfo_09 
			 @CustList = @CustList
			,@target = @target

	WAITFOR DELAY '00:00:0.050'

	SET @msg_total = 'Currently at batch %d' + '/' + CAST(@TotalBatch AS varchar)
				+ ' Curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)

	RAISERROR (@msg_total, 0, 1, @i) WITH NOWAIT

	SELECT @i = @i + 1
END	

DROP TABLE #tbCustomer, #Customer_batch
GO	

PRINT N'Exists Customer: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
GO
