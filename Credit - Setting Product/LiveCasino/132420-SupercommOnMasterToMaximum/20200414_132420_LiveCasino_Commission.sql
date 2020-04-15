/*
	Created: Helen@20200401
	Task: Alpha - Update Super comm on Master to maximum - Remine: https://nexdev.net/issues/132420
	DB: DBCUST/CustDB
	
	Note: Run non UM
	
	Sports:
	NonDCS:
		Gold Deluxe 255
	DCS
		Allbet 211
		SA Gaming 244
		Sexy Gaming 243
		Bbin 241
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
	IF dbo.f_CheckRepTable('CustGameType') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN

	DECLARE @Discount_XML_211_244_243_241 VARCHAR(MAX) = ''
			, @custid INT
			, @Discount_255 DECIMAL(9,8) 
			, @Discount_211 DECIMAL(9,8) 
			, @Discount_244 DECIMAL(9,8) 
			, @Discount_243 DECIMAL(9,8) 
			, @Discount_241 DECIMAL(9,8) 
			
	
	CREATE TABLE #MasterList (CustID INT PRIMARY KEY
								,isfinished_255 bit default(0)
								,isfinished_211_244_243_241 bit default(0)
								)
	
	CREATE TABLE #StakeLevel_List_255 (custid INT,GameTypeID INT, StakeLevelList VARCHAR(100))
	
	CREATE TABLE #StakeLevel_List_211_244_243_241 (custid INT,sporttype SMALLINT,bettype INT, StakeLevelList VARCHAR(200))
	
	----- DATA preparation ---------
	INSERT INTO #MasterList (CustID)
	SELECT custid
	FROM dbo.Customer c WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 3
	
	INSERT INTO #StakeLevel_List_255 (custid, GameTypeID,StakeLevelList)
	SELECT custid,GameTypeID, StakeLevelList
	FROM dbo.CustGameType WITH (NOLOCK)
	WHERE CustID = @srecommend AND GameTypeID IN (1701,1702)
	
	INSERT INTO #StakeLevel_List_211_244_243_241 (custid, sporttype, bettype, StakeLevelList)
	SELECT custid, sporttype, bettype, StakeLevelList
	FROM dbo.CustStakeLevel_Agent WITH (NOLOCK)
	WHERE CustID = @srecommend AND SportType IN (211, 244, 243, 241)
	
	-------- UPDATE commission customer setting -------------
	SET @Discount_255 = ISNULL((SELECT TOP (1) sdiscount
						FROM dbo.CustSettingGame WITH (NOLOCK) 
						WHERE custid = @srecommend AND sporttype = 255 AND bettype = 1701),0)
							
	SET @Discount_211 =	ISNULL((SELECT TOP (1) Discount
						FROM dbo.CustDiscount3rd_Agent WITH (NOLOCK) 
						WHERE custid = @srecommend AND sporttype = 211 AND bettype = 2401 ),0)

	SET @Discount_241 =	ISNULL((SELECT TOP (1) Discount
						FROM dbo.CustDiscount3rd_Agent WITH (NOLOCK) 
						WHERE custid = @srecommend AND sporttype = 241 AND bettype = 3300 ),0)

	SET @Discount_243 =	ISNULL((SELECT TOP (1) Discount
						FROM dbo.CustDiscount3rd_Agent WITH (NOLOCK) 
						WHERE custid = @srecommend AND sporttype = 243 AND bettype = 3101 ),0)
						
	SET @Discount_244 =	ISNULL((SELECT TOP (1) Discount
						FROM dbo.CustDiscount3rd_Agent WITH (NOLOCK) 
						WHERE custid = @srecommend AND sporttype = 244 AND bettype = 3001 ),0)

	SET @Discount_XML_211_244_243_241 = ''
	SET @Discount_XML_211_244_243_241 = @Discount_XML_211_244_243_241 + '<ROOT><Discount SportType="211" BetType="2401" Discount="'+CONVERT(VARCHAR(20),@Discount_211)+'"/><Discount SportType="241" BetType="3300" Discount="'+CONVERT(VARCHAR(20),@Discount_241)+'"/><Discount SportType="243" BetType="3101" Discount="'+CONVERT(VARCHAR(20),@Discount_243)+'"/><Discount SportType="244" BetType="3001" Discount="'+CONVERT(VARCHAR(20),@Discount_244)+'"/>	</ROOT>'
						
	------ For GD
	WHILE (1=1)
	BEGIN
		UPDATE TOP (1) #MasterList
				SET isfinished_255 = 1
					,@custid = custid
		WHERE isfinished_255 = 0
			
		IF @@ROWCOUNT = 0 BREAK

		EXEC Acc_CustSetting3rd_06
			@CustId				= @custid,
			@RoleId				= 3,
			@Discount			= @Discount_255,
			@mode				= 'GoldDeluxe',
			@Sporttype			= 255,
			@Bettype			= 1701	
	END
	
	-- Stake Level List
	UPDATE cgt
		SET StakeLevelList = sl.StakeLevelList
	FROM dbo.CustGameType cgt WITH (ROWLOCK)
		INNER JOIN #MasterList m ON cgt.CustID = m.CustID
		INNER JOIN #StakeLevel_List_255 sl ON cgt.GameTypeID = sl.GameTypeID	
	
	------ For AllBet & SA Gaming
	WHILE (1=1)
	BEGIN
		UPDATE TOP (1) #MasterList
				SET isfinished_211_244_243_241 = 1
					,@custid = custid
		WHERE isfinished_211_244_243_241 = 0
			
		IF @@ROWCOUNT = 0 BREAK

		EXEC dbo.Acc_DynamicCustSetting3rd_06
				@CustId			= @custid
				, @RoleId		= 3
				, @SettingType  = 3
				, @Discount_XML = @Discount_XML_211_244_243_241
	END
	-- update stakelevel
	UPDATE cgt
		SET StakeLevelList = sl.StakeLevelList
	FROM dbo.CustStakeLevel_Agent cgt WITH (ROWLOCK)
		INNER JOIN #MasterList m ON cgt.CustID = m.CustID
		INNER JOIN #StakeLevel_List_211_244_243_241 sl ON cgt.SportType = sl.sporttype AND cgt.BetType = sl.bettype 	
	
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished BIT DEFAULT(0))

DECLARE @srecommend INT
-- list of supers
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
	AND c.username IN ('Ace','AG','An','Ap','As','Av','Aw','Dh','Fat','Kc','No','Wg','Winb','Winc','Wing','Winz','Wj','Wo','Mod','dh','hd')

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
-- list of supers
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
	AND c.username IN ('Ace','AG','An','Ap','As','Av','Aw','Dh','Fat','Kc','No','Wg','Winb','Winc','Wing','Winz','Wj','Wo','Mod','dh','hd')

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
