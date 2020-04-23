/*
	Created: Helen@20200422
	Task: Allbet, GD, SA Gaming - Change commission for super, direct master, direct agent - Remine: https://nexdev.net/issues/133015
	DB: DBCUST/CustDB
	
	Note: Run UM
*/ 
ALTER PROCEDURE [dbo].[Acc_Custsetting3rd_19]
	@srecommend INT
	,@target VARCHAR(20) = NULL
	
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('customer') = 0 RETURN
	
	IF dbo.f_CheckRepTable('CustDiscount3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustSettingGame') = 0 RETURN

	DECLARE @Discount_XML VARCHAR(MAX) = ''
			, @Discount_XML_211 VARCHAR(MAX) = ''
			, @Discount_XML_244 VARCHAR(MAX) = ''
			, @Discount_XML_211_244 VARCHAR(MAX) = ''
			, @NewDiscount DECIMAL(9,8) 
			, @custid INT
			, @uplinedummy INT
			, @roleid TINYINT
			
			, @IsUpd_255 BIT = 0
			, @IsUpd_211 BIT = 0
			, @IsUpd_244 BIT = 0
	
	CREATE TABLE #DirectMaster_updateComm (CustID INT PRIMARY KEY,isUpd_255 BIT, isUpd_211 BIT, isUpd_244 BIT, isfinished bit default(0))
	CREATE TABLE #DirectAgent_updateComm (CustID INT PRIMARY KEY,mrecommend INT, isUpd_255 BIT, isUpd_211 BIT, isUpd_244 BIT, isfinished bit default(0))
	CREATE TABLE #Cust_tmp_isExistDirectAccount (CustID INT PRIMARY KEY,roleID INT)
	
	SET @Discount_XML_211_244 = '<ROOT><Discount SportType="211" BetType="2401" Discount="0.00800000"/><Discount SportType="244" BetType="3001" Discount="0.00800000"/></ROOT>'
	SET @Discount_XML_211 = '<ROOT><Discount SportType="211" BetType="2401" Discount="0.00800000"/></ROOT>'
	SET @Discount_XML_244 = '<ROOT><Discount SportType="244" BetType="3001" Discount="0.00800000"/></ROOT>'
	
	SET @NewDiscount = 0.008
	
	-------- UPDATE commission customer setting -------------
	SET @custid = @srecommend
	SET @roleid = 4
	
	SET @IsUpd_255 = ISNULL((SELECT TOP (1) 1
						FROM dbo.CustSettingGame WITH (NOLOCK) 
						WHERE custid = @custid AND sporttype = 255 AND bettype = 1701 AND sdiscount = 0.01),0)
	SET @IsUpd_211 = ISNULL((SELECT TOP (1) 1
						FROM dbo.CustDiscount3rd_Agent WITH (NOLOCK) 
						WHERE custid = @custid AND sporttype = 211 AND bettype = 2401 AND Discount = 0.01),0)	
	
	
	SET @IsUpd_244 = ISNULL((SELECT TOP (1) 1
						FROM dbo.CustDiscount3rd_Agent WITH (NOLOCK) 
						WHERE custid = @custid AND sporttype = 244 AND bettype = 3001 AND Discount = 0.01),0)	
																
	IF @IsUpd_255 = 0 AND @IsUpd_211 = 0 AND @IsUpd_244 = 0
		RETURN
	
	------ For GD
	IF @IsUpd_255 = 1 
	BEGIN
		EXEC Acc_CustSetting3rd_06
			@CustId				= @custid,
			@RoleId				= @roleid,
			@Discount			= @NewDiscount,
			@mode				= 'GoldDeluxe',
			@Sporttype			= 255,
			@Bettype			= 1701	
	END		 
	------ For AllBet & SA Gaming
	IF @IsUpd_211 = 1 AND @IsUpd_244 = 1
		SET @Discount_XML = @Discount_XML_211_244
	ELSE IF @IsUpd_211 = 1
		SET @Discount_XML = @Discount_XML_211
	ELSE IF @IsUpd_244 = 1
		SET @Discount_XML = @Discount_XML_244
	ELSE
		SET @Discount_XML = ''
				
	IF @Discount_XML <> ''
	BEGIN
		EXEC dbo.Acc_DynamicCustSetting3rd_06
				@CustId			= @custid
				, @RoleId		= @roleid
				, @SettingType  = 3
				, @Discount_XML = @Discount_XML
	END
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished BIT DEFAULT(0))

DECLARE @srecommend INT

-- get super
INSERT INTO #supers(custid)
SELECT ci.custid
FROM dbo.customer c WITH (NOLOCK) 
	INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
	INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
	LEFT JOIN  dbo.custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4
	AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))
	AND cs.isinternal = 0 	
	AND ci.Enabled = 1
	AND s.islicensee = 0
	AND c.username NOT LIKE '3rdSuper%'
	AND c.site = '789y'
UNION ALL
SELECT ci.custid
FROM dbo.customer c WITH (NOLOCK) 
	INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
	INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
	LEFT JOIN  dbo.custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4
	AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))
	AND cs.isinternal = 0 	
	AND ci.Enabled = 1
	AND s.islicensee = 0
	AND c.username NOT LIKE '3rdSuper%'
	AND c.username IN ('Ace','AG','An','Ap','As','Av','Aw','Dh','Fat','Kc','No','Wg','Winb','Winc','Wing','Winz','Wj','Wo')
			
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
-- get super
INSERT INTO #supers(custid)
SELECT ci.custid
FROM dbo.customer c WITH (NOLOCK) 
	INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
	INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
	LEFT JOIN  dbo.custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4
	AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))
	AND cs.isinternal = 0 	
	AND ci.Enabled = 1
	AND s.islicensee = 0
	AND c.username NOT LIKE '3rdSuper%'
	AND c.site = '789y'
UNION ALL
SELECT ci.custid
FROM dbo.customer c WITH (NOLOCK) 
	INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
	INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
	LEFT JOIN  dbo.custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4
	AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))
	AND cs.isinternal = 0 	
	AND ci.Enabled = 1
	AND s.islicensee = 0
	AND c.username NOT LIKE '3rdSuper%'
	AND c.username IN ('Ace','AG','An','Ap','As','Av','Aw','Dh','Fat','Kc','No','Wg','Winb','Winc','Wing','Winz','Wj','Wo')
			
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
		
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_Custsetting3rd_19 @srecommend = @srecommend
			, @target = 'DBCUST'
						
	WAITFOR DELAY '00:00:0.100'
	
END
GO