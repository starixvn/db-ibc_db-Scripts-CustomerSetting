/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211227@Eden
	Task: Delete Existing Setting of Saba Casino - Real Currency [#164280]
	DB: DBCUST/CustDB and all subscriber of CustDB_custseting Pub
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	@target VARCHAR(20)
	
AS
BEGIN	
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbtrans only
	
	IF (dbo.f_CheckRepTable('Dep_CustSettingMode') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0

		OR dbo.f_CheckRepTable('Dep_StakeLevel') = 0 
		OR dbo.f_CheckRepTable('Dep_CustStakeLevel_Agent') = 0 
		OR dbo.f_CheckRepTable('Dep_CustStakeLevel_Member') = 0 

		OR dbo.f_CheckRepTable('Dep_CustDiscountSetting_Member') = 0		
		OR dbo.f_CheckRepTable('Dep_CustDiscountGroupSetting_Member') = 0
		
		OR dbo.f_CheckRepTable('Dep_ProductSetting') = 0
		OR dbo.f_CheckRepTable('Dep_ProductSettingDetail') = 0
		OR dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 
		
		OR dbo.f_CheckRepTable('CustInfo') = 0 
		OR dbo.f_CheckRepTable('Customer') = 0 

		
		OR dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 
	    OR dbo.f_CheckRepTable('Dep_ProductStatusProfile') = 0 
	   )
		RETURN

	DECLARE @sportType SMALLINT = 208 , @BetType SMALLINT = 2101
	
	CREATE TABLE #supers (custid INT)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'			
		AND ci.Enabled=1
		AND (cs.site IN('Macaubet','Aoncash','ITCBet','9bet','M8bola','Q8bola','BE7','NBCbet','Unobet','Bolanation','Luckywin88','Winn69','Axiawin','Jumbo88','Lagadewa','Ratugg','Monstergol')
			OR (cs.site IN('spondemo','Athena000')	AND Ci.currency NOT IN (20)))
	AND Ci.currency IN (
							2	-- 	RM
						,	3	-- 	US$
						,	4	-- 	TB
						,	6	-- 	EURO
						,	12	-- 	GBP
						,	13	-- 	RMB
						,	15	-- 	IN
						,	45	-- 	WON
						,	51	-- 	INH
						,	61	-- 	INR
						,	66	-- 	YUN
						,	70	-- 	MKK
						,	96	-- 	USDT
						,	20	--	UUS
						)	
	ORDER by ci.custid
		
	CREATE TABLE #Dep_CustPTSetting3rd_Agent(CustID INT)
	CREATE TABLE #Dep_CustPTSetting3rd_Member(CustID INT)
	CREATE TABLE #Dep_CustPTGroupSetting3rd_Member(CustID INT)
	CREATE TABLE #Dep_CustStakeLevel_Agent(CustID INT)
	CREATE TABLE #Dep_CustStakeLevel_Member(CustID INT)
	CREATE TABLE #Dep_CustDiscountSetting_Member(CustID INT)
	CREATE TABLE #Dep_CustDiscountGroupSetting_Member(CustID INT)

	INSERT INTO #Dep_CustPTSetting3rd_Agent(CustID)
	SELECT s.Custid
	FROM Dep_CustPTSetting_Agent s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE SportType =@sportType AND c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #Dep_CustPTSetting3rd_Member(CustID)
	SELECT s.CustID
	FROM Dep_CustPTSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE SportType =@sportType AND c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #Dep_CustPTGroupSetting3rd_Member(CustID)
	SELECT AgentID
	FROM Dep_CustPTGroupSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.AgentID=c.custid
	WHERE SportType =@sportType AND c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #Dep_CustStakeLevel_Agent(CustID)
	SELECT S.CustID
	FROM Dep_CustStakeLevel_Agent S WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE SportType =@sportType AND c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #Dep_CustStakeLevel_Member(CustID)
	SELECT S.CustID 
	FROM Dep_CustStakeLevel_Member S WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE SportType =@sportType AND c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #Dep_CustDiscountSetting_Member(CustID)
	SELECT s.Custid
	FROM Dep_CustDiscountSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE SportType =@sportType AND c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #Dep_CustDiscountGroupSetting_Member(CustID)
	SELECT s.AgentID
	FROM Dep_CustDiscountGroupSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.AgentID=c.custid
	WHERE SportType =@sportType AND c.srecommend IN(SELECT CustID FROM #supers)

	--SELECT * FROM #Dep_CustStakeLevel_Agent
	--SELECT * FROM #Dep_CustStakeLevel_Member
	--SELECT * FROM #Dep_CustPTGroupSetting3rd_Member
	--SELECT * FROM #Dep_CustPTSetting3rd_Agent
	--SELECT * FROM #Dep_CustPTSetting3rd_Member
	--SELECT * FROM #Dep_CustDiscountSetting_Member
	--SELECT * FROM #Dep_CustDiscountGroupSetting_Member

	DECLARE @BatchNum INT = 5000
	CREATE TABLE #CustTempBatch (CustID INT)

	---------------PT---------------------------
	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #Dep_CustPTSetting3rd_Agent 
		OUTPUT DELETED.CustID INTO #CustTempBatch(CustID)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustPTSetting_Agent cg WITH(ROWLOCK)		
			INNER JOIN #CustTempBatch ci ON ci.custid = cg.CustID	
		WHERE SportType = @Sporttype AND BetType = @BetType

		TRUNCATE TABLE #CustTempBatch
	END

	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #Dep_CustPTSetting3rd_Member 
		OUTPUT DELETED.CustID INTO #CustTempBatch(CustID)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustPTSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustTempBatch ci ON ci.custid = cg.CustID	
		WHERE SportType = @Sporttype AND BetType = @BetType

		TRUNCATE TABLE #CustTempBatch
	END

	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #Dep_CustPTGroupSetting3rd_Member 
		OUTPUT DELETED.CustID INTO #CustTempBatch(CustID)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustPTGroupSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustTempBatch ci ON ci.custid = cg.AgentID	
		WHERE SportType = @Sporttype AND BetType = @BetType

		TRUNCATE TABLE #CustTempBatch
	END
	
	--------------StakeLevel---------------------------------
	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #Dep_CustStakeLevel_Agent 
		OUTPUT DELETED.CustID INTO #CustTempBatch(CustID)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustStakeLevel_Agent cg WITH(ROWLOCK)		
			INNER JOIN #CustTempBatch ci ON ci.custid = cg.CustID	
		WHERE SportType = @Sporttype AND BetType = @BetType

		TRUNCATE TABLE #CustTempBatch
	END

	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #Dep_CustStakeLevel_Member 
		OUTPUT DELETED.CustID INTO #CustTempBatch(CustID)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustStakeLevel_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustTempBatch ci ON ci.custid = cg.CustID	
		WHERE SportType = @Sporttype AND BetType = @BetType

		TRUNCATE TABLE #CustTempBatch
	END

	---------------Comm------------------------------------
	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #Dep_CustDiscountSetting_Member 
		OUTPUT DELETED.CustID INTO #CustTempBatch(CustID)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustDiscountSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustTempBatch ci ON ci.custid = cg.CustID	
		WHERE SportType = @Sporttype AND BetType = @BetType

		TRUNCATE TABLE #CustTempBatch
	END

	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #Dep_CustDiscountGroupSetting_Member 
		OUTPUT DELETED.CustID INTO #CustTempBatch(CustID)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustDiscountGroupSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustTempBatch ci ON ci.custid = cg.AgentID	
		WHERE SportType = @Sporttype AND BetType = @BetType

		TRUNCATE TABLE #CustTempBatch
	END

	DROP TABLE #CustTempBatch
	DROP TABLE #Dep_CustPTGroupSetting3rd_Member
	DROP TABLE #Dep_CustPTSetting3rd_Agent
	DROP TABLE #Dep_CustPTSetting3rd_Member
	DROP TABLE #Dep_CustStakeLevel_Agent
	DROP TABLE #Dep_CustStakeLevel_Member
	DROP TABLE #supers
	DROP TABLE #Dep_CustDiscountGroupSetting_Member
	DROP TABLE #Dep_CustDiscountSetting_Member
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS AND DBCUST -----
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @target = @target
