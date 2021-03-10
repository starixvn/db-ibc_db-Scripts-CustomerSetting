/*
	Created: Winfred
	Date: 20210223
	Task: Initialize Product Status for Sports Lottery UUS [Redmine: 147361]
	DB: DBCUST/CustDB
	
	P/s : Step 3 Copy Status for Sports Lottery UUS
*/
ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09]
	@Custid INT
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
	

	/*******************************CUST PRODUCT STATUS TABLE*******************************/	
	DECLARE @BitmapOrder TINYINT = 32
	SELECT custid
	INTO #CustList
	FROM dbo.custInfo ci WITH (NOLOCK)
	WHERE ci.srecommend = @Custid
		AND ci.Enabled = 1
		AND ci.custid <= @maxcustid

	UPDATE cs
	SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
		bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,isDisabled.value)) 	
	FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #CustList ci WITH(NOLOCK) ON cs.CustID = ci.CustID
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, 11) as isDisabled

END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND s.islicensee = 0
		AND ci.custid <= @max_custid
		AND ci.Site NOT IN ('CN88')
		AND ci.currency IN (20,72) -- UUS, YNG
		AND Ci.custid NOT IN (356942,410722,410800,462612,479690,499837,507226,512864,776702,833216,838365,897682,932905,984326,984549,1008937,
		1060883,1211012,1593254,1598401,1604404,1993804,1993818,3139575,3671274,4138910,5340162,5340166,5551985,5931469,5973408,6418627,
		6621107,7669811,7694778,7945498,8017299,8095139,8488565,8621974,8907700,9525991,9934460,10535290,10542643,11581838,11734366,
		12300617,12742869,12968884,13338762,13543345,13549891,14063528,14423359,14453695,14776453,14827154,14827246,15778049,16154752,
		16901190,16928094,17436696,17724317,18023072,19646705,20055370,20124800,20309230,22150801,22378516,23416974,23475292,25589933,
		26576899,27349067,27377389,27474847,28532147,43136376,45571377,46080688,46107818)
		-- exclude headline SDRMB, 266HK, M863HK, SBSR, YKH, S188RM, PYY, POT, SF8, S80R
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

	EXEC dbo.Acc_DynamicCustomerInfo_09 @custid = @srecommend
			,@maxcustid = @max_custid
			,@target = 'REPLICATED'
			
			
	waitfor delay '00:00:0.280'
END
GO

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 3: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND s.islicensee = 0
		AND ci.custid <= @max_custid
		AND ci.Site NOT IN ('CN88')
		AND ci.currency IN (20,72) -- UUS, YNG
		AND Ci.custid NOT IN (356942,410722,410800,462612,479690,499837,507226,512864,776702,833216,838365,897682,932905,984326,984549,1008937,
		1060883,1211012,1593254,1598401,1604404,1993804,1993818,3139575,3671274,4138910,5340162,5340166,5551985,5931469,5973408,6418627,
		6621107,7669811,7694778,7945498,8017299,8095139,8488565,8621974,8907700,9525991,9934460,10535290,10542643,11581838,11734366,
		12300617,12742869,12968884,13338762,13543345,13549891,14063528,14423359,14453695,14776453,14827154,14827246,15778049,16154752,
		16901190,16928094,17436696,17724317,18023072,19646705,20055370,20124800,20309230,22150801,22378516,23416974,23475292,25589933,
		26576899,27349067,27377389,27474847,28532147,43136376,45571377,46080688,46107818)
		-- exclude headline SDRMB, 266HK, M863HK, SBSR, YKH, S188RM, PYY, POT, SF8, S80R
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

	EXEC dbo.Acc_DynamicCustomerInfo_09 @custid = @srecommend
			,@maxcustid = @max_custid
			,@target = 'DBCUST'
						
	waitfor delay '00:00:0.280'
END

PRINT N'Step 3: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
