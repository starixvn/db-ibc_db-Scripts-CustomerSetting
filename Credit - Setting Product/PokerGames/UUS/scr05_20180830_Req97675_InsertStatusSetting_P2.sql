ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09]
	@srecommend INT	
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('CustProductStatus') = 1
	   AND dbo.f_CheckRepTable('ProductSettingDetail') = 1
	   AND dbo.f_CheckRepTable('ProductStatusProfile') = 1
	   )
		RETURN

	DECLARE @Sporttype SMALLINT = 163
	DECLARE @xmlStrValue_0 XML

	SET @xmlStrValue_0 =(
			SELECT (
					SELECT psp.bitmapOrder	AS '@b'
						, 0	AS '@s'
					FROM ProductStatusProfile psp WITH (NOLOCK)
					WHERE psp.Sporttype = @Sporttype AND Bettype BETWEEN 1401 AND 1405
					FOR XML PATH('r')
						, TYPE
					)
			FOR XML PATH('root')
				, TYPE
			)
	/*******************************CUST PRODUCTSTATUS TABLE*******************************/	
	UPDATE cs
	SET 	
		cs.bitmapIsDisabled = (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsDisabled, CONVERT(VARCHAR(MAX),@xmlStrValue_0)))	,
		cs.bitmapIsHidden =  (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsHidden, CONVERT(VARCHAR(MAX),@xmlStrValue_0))) 
	FROM CustProductStatus cs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN custInfo ci WITH (NOLOCK) ON cs.CustID = ci.CustID
	WHERE ci.srecommend = @srecommend 	
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
 INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
 LEFT JOIN custsuper cs WITH (NOLOCK) ON c.custid = cs.custid
WHERE c.roleid = 4  
 AND c.username NOT LIKE '3rdSuper%'
 AND cs.isinternal = 0
 AND c.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
 AND s.islicensee = 0
 AND c.site IN ('789y', 'BEST-ODDS')
 AND c.currency = 20
 AND c.custid <= @max_custid

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
			@srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'REPLICATED'
						
	waitfor delay '00:00:0.100'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
 INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
 LEFT JOIN custsuper cs WITH (NOLOCK) ON c.custid = cs.custid
WHERE c.roleid = 4  
 AND c.username NOT LIKE '3rdSuper%'
 AND cs.isinternal = 0
 AND c.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
 AND s.islicensee = 0
 AND c.site IN ('789y', 'BEST-ODDS')
 AND c.currency = 20
 AND c.custid <= @max_custid

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
			@srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'DBCUST'
						
	waitfor delay '00:00:0.100'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 