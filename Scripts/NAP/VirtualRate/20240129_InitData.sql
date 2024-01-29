/*<info serverAlias="DBCUST-CustDB"></info>*/ 
/*
	Created: 20240129@Luke
	Task: NAP - Virtual rate - Change default of VR Status for newly created Super to Enable [Redmine: #200311]
	DB: DBCust/CustDB and all replicated server
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]	
	@target VARCHAR(20)
	,@custlist NVARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;

	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at DBCUST only
		
	IF dbo.f_CheckRepTable('custinfo') = 0 RETURN
	IF dbo.f_CheckRepTable('CustVirtualSetting') = 0 RETURN
	
	CREATE TABLE #CustVR(
		custid	INT,
		seqNo	TINYINT,
		bitmapVirtual BINARY(64)
	)

	INSERT INTO #CustVR(custid, seqNo, bitmapVirtual)
	SELECT custid, seqNo, bitmapVirtual
	FROM OPENJSON(@custlist) WITH(
		custid			INT				'$.id'
		,seqNo			TINYINT			'$.seq'
		,bitmapVirtual	BINARY(64)		'$.bitmap'

	)
	--Update virtual rate setting
	UPDATE cvs
	SET cvs.bitmapVirtual = cvr.bitmapVirtual
	FROM CustVirtualSetting cvs WITH (ROWLOCK)
		INNER JOIN #CustVR cvr ON cvs.custid = cvr.custid AND cvs.seqNo = cvr.seqNo
	
	--Update virtual rate status
	UPDATE c
	SET c.VirtualMultiplier = 1
	FROM custinfo c WITH (ROWLOCK)
		INNER JOIN #CustVR cvr ON c.custid = cvr.custid
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------			
-------------------------------------------------------
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST-----
--------------------------------------------------------------------------------------
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
		@custlist	NVARCHAR(MAX)

SELECT @max_custid = xxx

CREATE TABLE #tmpCust(
	CustID		INT
)
CREATE TABLE #batchCust(
	CustID		INT
)
CREATE TABLE #batchVR(
	CustID INT,
	seqNo TINYINT,
	bitmapVirtual BINARY(64)
)

INSERT INTO #tmpCust(CustID)
SELECT custid 
FROM custinfo with (NOLOCK)
WHERE VirtualMultiplier = 0
	AND custid <= @max_custid

------------------------------------------------------
SELECT @Cust_cnt = COUNT(1)
FROM #tmpCust

DECLARE @msg_total NVARCHAR(200) = 'Total of Customers Affected: %d.'

RAISERROR (@msg_total, 0, 1, @Cust_cnt) WITH NOWAIT

--Update 
WHILE (1=1)
BEGIN
	TRUNCATE TABLE #batchCust
	TRUNCATE TABLE #batchVR

	DELETE TOP (1600) t
	OUTPUT deleted.CustID
	INTO #batchCust(CustID)
	FROM #tmpCust t

	IF @@ROWCOUNT = 0 BREAK

	INSERT INTO #batchVR(CustID, seqNo, bitmapVirtual)
	SELECT custid, seqNo, virtualBitmap
	FROM #batchCust
		CROSS APPLY (VALUES(1, 0x64646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464),
							(2,0x64646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464),
							(3,0x64646464646400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 )
							) t(seqNo, virtualBitmap)
	
	SELECT @custlist = (
		SELECT custid AS id, seqNo AS seq, bitmapVirtual AS bitmap
		FROM #batchVR
		FOR JSON PATH
	)
	EXEC dbo.[Acc_DynamicCustSetting3rd_09] 
			@target = @target
			,@custlist = @custlist
	
	WAITFOR DELAY '00:00:0.050'

	SET @msg_total = 'Updating - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)

	RAISERROR (@msg_total, 0, 1) WITH NOWAIT
END	

DROP TABLE #tmpCust, #batchCust, #batchVR
GO	

PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
GO
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
-----------------------------------------------------------------------------------	
 
