/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Helen@20200609
	Task: Macau Games - Remove commission - https://nexdev.net/issues/135086
	DB: DBCUST/CustDB
	
	Note: Run UM (plan at 07/01/2020)
*/ 
ALTER PROCEDURE [dbo].[Acc_Custsetting3rd_19]
	@srecommend INT
	,@target VARCHAR(20) = NULL
	
AS
BEGIN
-- BEGIN STEP 1: DEPLOY THESE SP @ DBCUST.CustDB -----
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ( 'DB233','DB230\SQLSERVER2008R2','DBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ( 'DB233','DB230\SQLSERVER2008R2','DBCUST')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('customer') = 0 RETURN
	
	IF dbo.f_CheckRepTable('CustDiscount3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 0 RETURN

	DECLARE @Discount_XML VARCHAR(MAX) = ''
			, @custid INT
			, @roleid TINYINT
			, @IsUpd_212 BIT = 0
	
	SET @Discount_XML = N'<ROOT><Discount SportType="212" BetType="4001" Discount="0.00000000"/></ROOT>'
	
	-------- UPDATE commission customer setting -------------
	---- for Real Super---------

	SET @custid = @srecommend
	SET @roleid = 4
		
	SET @IsUpd_212 = ISNULL((SELECT TOP (1) 1
						FROM dbo.CustDiscount3rd_Agent WITH (NOLOCK) 
						WHERE custid = @custid AND sporttype = 212 AND bettype = 4001 AND Discount <> 0),0)	
																
	IF @IsUpd_212 = 0 
		RETURN
		
	------ For Macau Games
	EXEC dbo.Acc_DynamicCustSetting3rd_06
			@CustId			= @custid
			, @RoleId		= @roleid
			, @SettingType  = 3
			, @Discount_XML = @Discount_XML
	
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished BIT DEFAULT(0))
DECLARE @srecommend INT

-- list of supers
-- real super
INSERT INTO #supers(custid)
SELECT ci.custid
FROM dbo.customer c WITH (NOLOCK) 
	INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
	INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
	INNER JOIN  dbo.custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4
	AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))
	AND cs.isinternal = 0 	
	AND ci.Enabled = 1
	AND s.islicensee = 0
	AND c.username NOT LIKE '3rdSuper%'

-- For deployer info
DECLARE @totalCust_cnt INT, @index INT = 0
SET @totalCust_cnt = (SELECT COUNT(1) FROM #Supers )
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of affected custid: %d.'
RAISERROR (@msg_total, 0, 1, @totalCust_cnt) WITH NOWAIT
		
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
			
	EXEC dbo.Acc_Custsetting3rd_19 @srecommend = @srecommend
			, @target = 'REPLICATED'
			
	WAITFOR DELAY '00:00:0.100'
	
END


GO 
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished BIT DEFAULT(0))
DECLARE @srecommend INT

INSERT INTO #supers(custid)
SELECT ci.custid
FROM dbo.customer c WITH (NOLOCK) 
	INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
	INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
	INNER JOIN  dbo.custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4
	AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))
	AND cs.isinternal = 0 	
	AND ci.Enabled = 1
	AND s.islicensee = 0
	AND c.username NOT LIKE '3rdSuper%'

-- For deployer info
DECLARE @totalCust_cnt INT, @index INT = 0
SET @totalCust_cnt = (SELECT COUNT(1) FROM #Supers )
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of affected custid: %d.'
RAISERROR (@msg_total, 0, 1, @totalCust_cnt) WITH NOWAIT
		
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
			
	EXEC dbo.Acc_Custsetting3rd_19 @srecommend = @srecommend
			, @target = 'DBCUST'
			
	WAITFOR DELAY '00:00:0.100'
	
END
GO