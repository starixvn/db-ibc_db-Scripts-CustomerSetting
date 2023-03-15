/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230314@Eden
	Task: Initialize Product Status of NG for Credit customers - Real currency [Redmine: #179711]
	DB: DBCUST/CustDB AND all replicated server of CustDB_Customer_Info, CustDB_DBTrans_CustInfo publication
*/ 
ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09]
	 @srecommend INT
	,@maxcustid INT
	,@target VARCHAR(20)

AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbcust only
	
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('CustProductStatus') = 1
	   AND dbo.f_CheckRepTable('ProductSettingDetail') = 1
	   AND dbo.f_CheckRepTable('ProductStatusProfile') = 1
	   )
		RETURN
	

	/**************************************************************/	
	DECLARE @BitmapOrder_NG TINYINT = 41
	DECLARE @BitmapOrder_KN TINYINT = 40
	DECLARE @BatchNum INT = 5000

	CREATE TABLE #CustTemp(CustID INT, DisableNumber BIT, HideKeno BIT, Isfinished BIT default 0)
	CREATE TABLE #CustTempBatch(CustID INT, DisableNumber BIT, HideKeno BIT)

	INSERT INTO #CustTemp(CustID,DisableNumber,HideKeno)
	SELECT custid,DisableNumber,HideKeno
	FROM dbo.custInfo ci WITH (NOLOCK)
	WHERE ci.srecommend = @srecommend
		AND ci.Enabled = 1
		AND ci.custid <= @maxcustid

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustTempBatch

		UPDATE TOP (@BatchNum)  t 
		SET t.IsFinished = 1 
		OUTPUT DELETED.CustID, DELETED.DisableNumber,deleted.HideKeno INTO #CustTempBatch(CustID,DisableNumber,HideKeno) 
		FROM #CustTemp t 
		WHERE t.IsFinished = 0

		IF @@ROWCOUNT=0
			BREAK

		UPDATE cs
		SET bitmapIsDisabled = dis.NewBitmap
			, bitmapIsHidden = hid.NewBitmap
			, bitmapHasSynced = sync.NewBitmap
		FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempBatch ci WITH(NOLOCK) ON cs.CustID = ci.CustID
			CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapHasSynced,@BitmapOrder_NG,1) as sync
			CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder_NG,ci.DisableNumber) as Dis
			CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder_NG,0) as Hid

		--Enable Keno by default, will disable on step adjust if yes
		UPDATE cs
		SET bitmapIsDisabled = dis.NewBitmap
			,bitmapIsHidden = hid.NewBitmap
			,bitmapHasSynced = sync.NewBitmap
		FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempBatch ci WITH(NOLOCK) ON cs.CustID = ci.CustID
			CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapHasSynced,@BitmapOrder_KN,1) as sync
			CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder_KN,0) as Dis
			CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder_KN,ci.HideKeno) as Hid

	END
	
	DROP TABLE #CustTemp
	DROP TABLE #CustTempBatch

END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS and DBCUST-----
--------------------------------------------------------------------------------------
SET NOCOUNT ON
PRINT N'Step : Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN custinfo C WITH(NOLOCK) ON c.CustID = ci.custid 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND s.islicensee = 0
		AND ci.custid <= @max_custid
		AND ci.Site<>'CN88'
		AND c.Enabled = 1
		AND ci.currency NOT IN (20,72)

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
			
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustomerInfo_09 
				@srecommend = @srecommend, 
				@maxcustid = @max_custid,
				@target = @target
			
	WAITFOR DELAY '00:00:0.280'
END
GO
GO
PRINT N'Step : End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
SET NOCOUNT OFF
