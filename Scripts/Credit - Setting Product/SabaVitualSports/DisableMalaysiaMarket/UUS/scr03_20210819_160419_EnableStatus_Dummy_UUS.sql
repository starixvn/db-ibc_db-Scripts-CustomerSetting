/*<info serverAlias="DBCUST-CustDB"></info>*/
ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09]
	@Custid INT
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	/*
		Task : Enable status Saba Virtual Sport for Malaysia Market [RedmineID: #160419]
		DB: DBCUST/CustDB
	*/
	-- BEGIN STEP 1: DEPLOY THESE SP @ DBCUST.CustDB -----
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
	DECLARE @BitmapOrderSapa TINYINT = 28
	
	CREATE TABLE #CustList (CustID INT PRIMARY KEY,isfinished BIT DEFAULT(0))

	INSERT INTO #CustList(CustID)
	SELECT ci.custid
	FROM dbo.customer c WITH (NOLOCK) 
		INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
	WHERE ci.srecommend = @Custid
		AND ci.roleid IN (3,2,1)
		AND ci.Enabled = 1
		AND ci.custid <= @maxcustid
		AND c.site IN ('733333', '722222', '222223')
		AND ci.currency  IN (20)
	UNION ALL SELECT @Custid

	DECLARE @Cust_Temp TABLE(CustID INT)
	DECLARE @BatchSize SMALLINT = 5000
	
	WHILE(1 =1)
	BEGIN
		UPDATE TOP (@BatchSize) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID INTO @Cust_Temp(CustID)
		FROM #CustList c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0
		BEGIN 
			BREAK
		END 	
			
		UPDATE cs
		SET 
			cs.bitmapHasSynced = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapHasSynced,@BitmapOrderSapa,1)),
			cs.bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrderSapa,0)),
			cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrderSapa,0)) 
		FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK)
			INNER JOIN @Cust_Temp ci ON cs.CustID = ci.CustID	
		
		DELETE FROM @Cust_Temp
	END
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid INT,isfinished BIT DEFAULT(0))
DECLARE @srecommend INT,@max_custid INT
SELECT @max_custid = xxx

----Get list dummy super
--SELECT DISTINCT srecommend INTO #temp1
--FROM CustDirectAccount da WITH (NOLOCK)
--	INNER JOIN vw_customer ci WITH(NOLOCK) ON da.CustID = ci.custid
--WHERE ci.site IN ('733333', '222223', '722222')
--	AND ci.roleid IN (2, 3) AND ci.currency IN (2,67)
--UNION 
--SELECT DISTINCT ci.srecommend
--FROM CustDirectAccount da WITH (NOLOCK)
--	INNER JOIN vw_customer ci WITH(NOLOCK) ON da.CustID = ci.custid
--	INNER JOIN vw_customer ca WITH(NOLOCK) ON ci.recommend = ca.custid
--WHERE ci.site IN ('733333', '222223', '722222')
--	AND ci.roleid IN (1) AND ci.currency IN (2,67)
--ORDER BY srecommend

INSERT INTO #supers(custid)
SELECT 20
UNION ALL SELECT 14174238
	
DECLARE @totalCust_cnt INT, @index INT = 0
SET @totalCust_cnt = (SELECT COUNT(1) FROM #Supers )
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of affected custid: %d.'
RAISERROR (@msg_total, 0, 1, @totalCust_cnt) WITH NOWAIT

DECLARE @RunRecord INT
--SET @RunRecord = 1
SET  @RunRecord = @totalCust_cnt
		
WHILE (@index <= @RunRecord)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustomerInfo_09 @Custid = @srecommend
			, @maxcustid= @max_custid
			, @target = 'REPLICATED'

	WAITFOR DELAY '00:00:0.100'
	
END
GO
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid INT,isfinished BIT DEFAULT(0))
DECLARE @srecommend INT,@max_custid INT
SELECT @max_custid = xxx
--DROP TABLE #supers
-- list of supers
-- real super
INSERT INTO #supers(custid)
SELECT 20
UNION ALL SELECT 14174238

DECLARE @totalCust_cnt INT, @index INT = 0
SET @totalCust_cnt = (SELECT COUNT(1) FROM #Supers )
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of affected custid: %d.'
RAISERROR (@msg_total, 0, 1, @totalCust_cnt) WITH NOWAIT

DECLARE @RunRecord INT
--SET @RunRecord = 1
SET  @RunRecord = @totalCust_cnt
		
WHILE (@index <= @RunRecord)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustomerInfo_09 @Custid = @srecommend
			, @maxcustid= @max_custid, @target = 'DBCUST'

	WAITFOR DELAY '00:00:0.100'
	
END
GO	