/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211227@Eden
	Task: migrate status of Saba Casino [#164280]
	DB: DBCUST/CustDB AND CustDB_Customer_info Pub
*/
ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09]
	@srecommend INT	
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('CustProductStatus') = 1
	   AND dbo.f_CheckRepTable('ProductSettingDetail') = 1
	   AND dbo.f_CheckRepTable('ProductStatusProfile') = 1
	   )
		RETURN

	DECLARE @BitmapOrder TINYINT = 37

	CREATE TABLE #CustTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		IsFinished BIT DEFAULT 0
	)
	
	CREATE TABLE #CustTempBatch(CustID INT)

	INSERT INTO #CustTemp (CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1  AND Enabled = 1 AND custid <= @maxcustid
	
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustTempBatch

		UPDATE TOP (5000)  t 
		SET t.IsFinished = 1 
		OUTPUT DELETED.CustID INTO #CustTempBatch(CustID) 
		FROM #CustTemp t 
		WHERE t.IsFinished = 0

		IF @@ROWCOUNT=0
			BREAK

		UPDATE cs
		SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
			bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,ci.DisableCasino)) 	
		FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempBatch t WITH(NOLOCK) ON cs.CustID = t.CustID
			INNER JOIN custInfo ci WITH(NOLOCK) ON cs.CustID = ci.CustID
	END
	
	DROP TABLE #CustTemp
	DROP TABLE #CustTempBatch
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS AND DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 4: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')
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
	AND ci.currency IN (
				 2	-- 	RM
				,3	-- 	US$
				,13	-- 	RMB
				,15	-- 	IN
				,16	-- 	Yen
				,22	-- 	IND
				,33	-- 	IDD
				,34	-- 	IDR
				,35	-- 	$US
				,43	-- 	THB
				,47	-- 	DDD
				,10	-- 	INR1
				,64	-- 	UT
				,69	-- 	MMK
				,95	-- 	USD
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

	EXEC dbo.Acc_DynamicCustomerInfo_09 
			 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = @target
			
			
	waitfor delay '00:00:0.200'
END
GO

PRINT N'Step 4: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 