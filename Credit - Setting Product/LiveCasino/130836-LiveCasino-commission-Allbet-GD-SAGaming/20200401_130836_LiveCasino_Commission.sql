/*
	Created: Helen@20200401
	Task: Allbet, GD, SA Gaming - Change commission for super, direct master, direct agent - Remine: https://nexdev.net/issues/130836
	DB: DBCUST/CustDB
	
	Note: Run UM
*/ 
ALTER PROCEDURE [dbo].[Acc_Custsetting3rd_19]
	@srecommend INT
	,@isExistDirectAccount BIT = 0
	,@target VARCHAR(20) = NULL
	
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	
	IF dbo.f_CheckRepTable('CustDiscount3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustSettingGame') = 0 RETURN

	DECLARE @Discount_XML VARCHAR(MAX) = ''
			, @NewDiscount DECIMAL(9,8) 
			, @custid INT
			, @roleid TINYINT
	
	CREATE TABLE #DirectMaster_updateComm (CustID INT PRIMARY KEY,isfinished bit default(0))
	CREATE TABLE #DirectAgent_updateComm (CustID INT PRIMARY KEY, isfinished bit default(0))
	CREATE TABLE #Cust_tmp_isExistDirectAccount (CustID INT PRIMARY KEY,roleID INT)
	
	SET @Discount_XML = '<ROOT><Discount SportType="211" BetType="2401" Discount="0.00800000"/><Discount SportType="244" BetType="3001" Discount="0.00800000"/></ROOT>'
	SET @NewDiscount = 0.008
	
	-------- UPDATE commission customer setting -------------
	---- for Real Super---------
	IF @isExistDirectAccount = 0
	BEGIN
	
		SET @custid = @srecommend
		SET @roleid = 4
		
		------ For GD
		EXEC Acc_CustSetting3rd_06
				@CustId				= @custid,
				@RoleId				= @roleid,
				@Discount			= @NewDiscount,
				@mode				= 'GoldDeluxe',
				@Sporttype			= 255,
				@Bettype			= 1701	
				 
		------ For AllBet & SA Gaming
		EXEC dbo.Acc_DynamicCustSetting3rd_06
				@CustId			= @custid
				, @RoleId		= @roleid
				, @SettingType  = 3
				, @Discount_XML = @Discount_XML
	END
	ELSE ---- for dummy Super -------
	BEGIN
		INSERT INTO #Cust_tmp_isExistDirectAccount (CustID,roleID)
		SELECT ci.custid,ci.roleid
		FROM custInfo ci (NOLOCK) 
		WHERE ci.srecommend = @srecommend AND roleid IN (2,3)
		
		----------- Direct Master PROCESSING ----------------------
		INSERT INTO #DirectMaster_updateComm (CustID)
		SELECT t.custid
		FROM #Cust_tmp_isExistDirectAccount t WITH(NOLOCK)
			INNER JOIN dbo.customer c WITH (NOLOCK) ON t.custid = c.custid
		WHERE t.custid IN (SELECT custid FROM CustDirectAccount WITH(NOLOCK))
			 AND t.roleid = 3 
			 AND c.site <> '789y'
			
		IF EXISTS (SELECT 1 FROM #DirectMaster_updateComm)
		BEGIN
			SET @roleid = 3
			
			WHILE (1=1)
			BEGIN
				UPDATE TOP (1) #DirectMaster_updateComm
					SET isfinished = 1
						,@custid = custid	
				WHERE isfinished = 0
				
				IF @@ROWCOUNT = 0 BREAK
				
				------ For GD
				EXEC Acc_CustSetting3rd_06
						@CustId				= @custid,
						@RoleId				= @roleid,
						@Discount			= @NewDiscount,
						@mode				= 'GoldDeluxe',
						@Sporttype			= 255,
						@Bettype			= 1701	
				 
				------ For AllBet & SA Gaming
				EXEC dbo.Acc_DynamicCustSetting3rd_06
						@CustId			= @custid
						, @RoleId		= @RoleId
						, @SettingType  = 3
						, @Discount_XML = @Discount_XML
						
				
			END
		END	
		----------- Direct Agent PROCESSING ----------------------
		INSERT INTO #DirectAgent_updateComm (CustID)
		SELECT t.custid
		FROM #Cust_tmp_isExistDirectAccount t WITH(NOLOCK)
			INNER JOIN dbo.customer c WITH (NOLOCK) ON t.custid = c.custid
		WHERE t.custid IN (SELECT custid FROM CustDirectAccount WITH(NOLOCK))
			AND t.roleid = 2 
			AND c.site <> '789y'
			
		IF EXISTS (SELECT 1 FROM #DirectAgent_updateComm)
		BEGIN
		
			SET @roleid = 2
			
			WHILE (1=1)
			BEGIN
				UPDATE TOP (1) #DirectAgent_updateComm
					SET isfinished = 1
						,@custid = custid	
				WHERE isfinished = 0
				
				IF @@ROWCOUNT = 0 BREAK
				
				------ For GD -------------
				EXEC Acc_CustSetting3rd_06
						@CustId				= @custid,
						@RoleId				= @roleid,
						@Discount			= @NewDiscount,
						@mode				= 'GoldDeluxe',
						@Sporttype			= 255,
						@Bettype			= 1701	
				 
				------ For AllBet & SA Gaming
				EXEC dbo.Acc_DynamicCustSetting3rd_06
						@CustId			= @custid
						, @RoleId		= @RoleId
						, @SettingType  = 3
						, @Discount_XML = @Discount_XML
			END
		END	
	END
	
	DROP TABLE #DirectAgent_updateComm
	DROP TABLE #DirectMaster_updateComm	
			
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished BIT DEFAULT(0), isExistDirectAccount BIT)
CREATE TABLE #supers_ExistingDirectAccount (custid INT, site VARCHAR(10) )

DECLARE @srecommend INT, @isExistDirectAccount BIT

INSERT INTO #supers_ExistingDirectAccount (custid,site)
-- Get direct Master
SELECT DISTINCT srecommend,site FROM dbo.Customer WITH(NOLOCK)
WHERE custid IN (select custid FROM dbo.CustDirectAccount WITH(NOLOCK))
	AND roleid=3 
--- get direct agent
UNION 
SELECT DISTINCT srecommend,site FROM dbo.Customer WITH(NOLOCK)
WHERE custid IN (select custid FROM dbo.CustDirectAccount WITH(NOLOCK))
	AND roleid = 2 

-- list of supers
-- real super
INSERT INTO #supers(custid,isExistDirectAccount)
SELECT ci.custid,0
FROM dbo.customer c WITH (NOLOCK) 
	INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
	INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
	LEFT JOIN  dbo.custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4
	AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))
	AND ci.custid NOT IN (SELECT custid FROM #supers_ExistingDirectAccount)
	AND cs.isinternal = 0 	
	AND ci.Enabled = 1
	AND s.islicensee = 0
	AND c.username NOT LIKE '3rdSuper%'
	AND c.site <> '789y'
		
UNION ALL
-- dummy super
SELECT s.custid, 1
FROM #supers_ExistingDirectAccount s
	INNER JOIN dbo.Custinfo ci WITH (NOLOCK) ON s.custid = ci.custid
	INNER JOIN dbo.customer c WITH (NOLOCK) ON s.custid = c.custid
	INNER JOIN dbo.site si WITH(NOLOCK) ON c.site = si.site
	LEFT JOIN  dbo.custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE  cs.isinternal = 0
	AND ci.Enabled = 1
	AND si.islicensee = 0
	AND c.username NOT LIKE '3rdSuper%'
	AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))
	AND s.site <> '789y'
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
		,@isExistDirectAccount = isExistDirectAccount
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
			
	EXEC dbo.Acc_Custsetting3rd_19 @srecommend = @srecommend
			, @isExistDirectAccount = @isExistDirectAccount
			, @target = 'REPLICATED'
			
	WAITFOR DELAY '00:00:0.100'
	
END

GO
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished BIT DEFAULT(0), isExistDirectAccount BIT)
CREATE TABLE #supers_ExistingDirectAccount (custid INT, site VARCHAR(10) )

DECLARE @srecommend INT, @isExistDirectAccount BIT

INSERT INTO #supers_ExistingDirectAccount (custid,site)
-- Get direct Master
SELECT DISTINCT srecommend,site FROM dbo.Customer WITH(NOLOCK)
WHERE custid IN (select custid FROM dbo.CustDirectAccount WITH(NOLOCK))
	AND roleid = 3 
--- get direct agent
UNION 
SELECT DISTINCT srecommend,site FROM dbo.Customer WITH(NOLOCK)
WHERE custid IN (SELECT custid FROM dbo.CustDirectAccount WITH(NOLOCK))
	AND roleid = 2 

-- list of supers
-- real super
INSERT INTO #supers(custid,isExistDirectAccount)
SELECT ci.custid,0
FROM dbo.customer c WITH (NOLOCK) 
	INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
	INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND ci.custid NOT IN (SELECT custid FROM #supers_ExistingDirectAccount)
	AND cs.isinternal = 0 	
	AND ci.Enabled = 1
	AND s.islicensee = 0
	AND c.username NOT LIKE '3rdSuper%'
	AND c.site <> '789y'
		
UNION ALL
-- dummy super
SELECT s.custid, 1
FROM #supers_ExistingDirectAccount s
	INNER JOIN dbo.Custinfo ci WITH (NOLOCK) ON s.custid = ci.custid
	INNER JOIN dbo.customer c WITH (NOLOCK) ON s.custid = c.custid
	INNER JOIN dbo.site si WITH(NOLOCK) ON c.site = si.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE  cs.isinternal = 0
	AND ci.Enabled = 1
	AND si.islicensee = 0
	AND c.username NOT LIKE '3rdSuper%'
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.site <> '789y'

-- For deployer info
DECLARE @totalCust_cnt INT, @index INT = 0
SET @totalCust_cnt = (SELECT COUNT(1) FROM #supers )
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of affected custid: %d.'
RAISERROR (@msg_total, 0, 1, @totalCust_cnt) WITH NOWAIT
	
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
		,@isExistDirectAccount = isExistDirectAccount
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_Custsetting3rd_19 @srecommend = @srecommend
			, @isExistDirectAccount = @isExistDirectAccount
			, @target = 'DBCUST'
						
	WAITFOR DELAY '00:00:0.100'
	
END
GO