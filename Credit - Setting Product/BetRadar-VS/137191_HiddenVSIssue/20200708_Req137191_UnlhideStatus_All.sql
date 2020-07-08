/*
	Created: Elodie	
	Task: Unhide Product Status of VS for all
	DB: DBCUST/CustDB
	Date: 20200708
*/ 
ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09]
	@Custid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('CustProductStatus') = 1
	   AND dbo.f_CheckRepTable('ProductSettingDetail') = 1
	   AND dbo.f_CheckRepTable('ProductStatusProfile') = 1
	   )
		RETURN	

	DECLARE @BitmapOrder TINYINT = 10

	/*******************************CUST PRODUCT STATUS TABLE*******************************/	
	UPDATE cs
	SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
		cs.bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,1)),
		cs.bitmapHasSynced = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapHasSynced,@BitmapOrder,1)) 
	FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN dbo.custInfo ci WITH(NOLOCK) ON cs.CustID = ci.CustID		
	WHERE ci.srecommend = @Custid

END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

INSERT INTO #supers(custid)
SELECT cps.CustID
FROM CustProductStatus cps WITH (NOLOCK)
		INNER JOIN vw_Customer c WITH (NOLOCK) on cps.CustID = c.custid
		INNER JOIN custInfo ci WITH (NOLOCK) on ci.custid = c.custid
		INNER JOIN Site s WITH (NOLOCK) on c.site = s.site
		INNER JOIN Exchange e WITH (NOLOCK) on e.exchangeid = c.currency
		left join custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE c.custid not in (SELECT custid FROM Dep_CustSuper WITH (NOLOCK))
		AND c.roleid = 4
		AND c.username not like '%3rdSuper%'
		AND c.currency <> 20
		AND ci.Enabled = 1
		AND s.isLicensee = 0
		AND cs.IsInternal = 0
		AND (ISNULL(dbo.f_GetProductStatus(cps.bitmapIsHidden, 10), 1) = 1
			OR ISNULL(dbo.f_GetProductStatus(cps.bitmapHasSynced, 10), 1) = 0)

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
			,@target = 'REPLICATED'
			
			
	waitfor delay '00:00:0.200'
END
GO

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

INSERT INTO #supers(custid)
SELECT cps.CustID
FROM CustProductStatus cps WITH (NOLOCK)
		INNER JOIN vw_Customer c WITH (NOLOCK) on cps.CustID = c.custid
		INNER JOIN custInfo ci WITH (NOLOCK) on ci.custid = c.custid
		INNER JOIN Site s WITH (NOLOCK) on c.site = s.site
		INNER JOIN Exchange e WITH (NOLOCK) on e.exchangeid = c.currency
		left join custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE c.custid not in (SELECT custid FROM Dep_CustSuper WITH (NOLOCK))
		AND c.roleid = 4
		AND c.username not like '%3rdSuper%'
		AND c.currency <> 20
		AND ci.Enabled = 1
		AND s.isLicensee = 0
		AND cs.IsInternal = 0
		AND (ISNULL(dbo.f_GetProductStatus(cps.bitmapIsHidden, 10), 1) = 1
			OR ISNULL(dbo.f_GetProductStatus(cps.bitmapHasSynced, 10), 1) = 0)	

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
			,@target = 'DBCUST'
						
	waitfor delay '00:00:0.200'
END