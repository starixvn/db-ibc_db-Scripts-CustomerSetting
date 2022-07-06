/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220630@Eden
	Task: Update jackpot Status - Real currency [#171715]
	DB: DBCUST/CustDB AND CustDB_Customer_info, CustDB_DBTrans_CustInfo Pub
*/
ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09]
	 @srecommend INT	
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbtrans only
	
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('CustProductStatus') = 1
	   )
		RETURN

	DECLARE @BitmapOrder_MG TINYINT = 5
	DECLARE @BitmapOrder_JP TINYINT = 39

	CREATE TABLE #CustTemp(CustID INT PRIMARY KEY)
	CREATE TABLE #CustTemp_Upd(CustID INT,IsFinished BIT DEFAULT 0)
	CREATE TABLE #CustTempBatch(CustID INT)
	
	INSERT INTO #CustTemp (CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND custid <= @maxcustid 
	
	INSERT INTO #CustTemp_Upd(CustID)
	SELECT c.CustID
	FROM [dbo].[CustProductStatus] c WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #CustTemp ci ON ci.CustID = c.CustID
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(C.bitmapIsDisabled, @BitmapOrder_MG) as isDisabledMG
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(C.bitmapIsDisabled, @BitmapOrder_JP) as isDisabledJP
	WHERE isDisabledMG.value = 1 AND isDisabledJP.value = 0

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustTempBatch

		UPDATE TOP (5000)  t 
		SET t.IsFinished = 1 
		OUTPUT DELETED.CustID INTO #CustTempBatch(CustID) 
		FROM #CustTemp_Upd t 
		WHERE t.IsFinished = 0

		IF @@ROWCOUNT=0
			BREAK

		UPDATE cs
		SET cs.bitmapIsDisabled = dis.NewBitmap
		FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempBatch ci ON cs.CustID = ci.CustID
			CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder_JP,1) as dis
			CROSS APPLY dbo.f_CustSetting_ProductStatusSel(Cs.bitmapIsDisabled, @BitmapOrder_MG) as isDisabledMG
			CROSS APPLY dbo.f_CustSetting_ProductStatusSel(Cs.bitmapIsDisabled, @BitmapOrder_JP) as isDisabledJP
		WHERE isDisabledMG.value = 1 AND isDisabledJP.value = 0
	END
	
	DROP TABLE #CustTemp
	DROP TABLE #CustTempBatch
	DROP TABLE #CustTemp_Upd
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS AND DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 4: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

IF	OBJECT_ID('tempdb..#supers') IS NOT NULL DROP TABLE	#supers;
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

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
	AND ci.custid <= @max_custid
	AND ci.currency <> 20

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

	EXEC dbo.Acc_DynamicCustomerInfo_09 
			 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = @target
			
			
	waitfor delay '00:00:0.200'
END
GO

PRINT N'Step 4: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 