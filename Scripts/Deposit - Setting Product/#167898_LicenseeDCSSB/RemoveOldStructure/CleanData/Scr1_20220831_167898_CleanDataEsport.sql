/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20220831
	Task: Clean Data Esport Old [Redmine:#167898]
	DB: DBCUST/CustDB and all subscriber of CustDB_custseting Pub
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	@target VARCHAR(20)
	
AS
BEGIN	
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbtrans only
	
	IF (dbo.f_CheckRepTable('Dep_CustSettingMode') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0

		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 

		OR dbo.f_CheckRepTable('Dep_ProductSetting') = 0
		OR dbo.f_CheckRepTable('Dep_ProductSettingDetail') = 0
		OR dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 
		
		OR dbo.f_CheckRepTable('CustInfo') = 0 
		OR dbo.f_CheckRepTable('Customer') = 0 
	   )
		RETURN

	DECLARE @Sporttype SMALLINT = 43
		, @BetType SMALLINT = 1
		
	CREATE TABLE #Dep_CustPTSetting3rd_Agent(CustID INT)
	CREATE TABLE #Dep_CustPTSetting3rd_Member(CustID INT)
	CREATE TABLE #Dep_CustPTGroupSetting3rd_Member(CustID INT)

	CREATE TABLE #Dep_CustBetSetting_Agent(CustID INT)
	CREATE TABLE #Dep_CustBetSetting_Member(CustID INT)

	CREATE TABLE #Dep_LicenseeProductSetting(CustID INT,ProductSettingID INT, PRIMARY KEY(CustID ,ProductSettingID ))
	CREATE TABLE #Dep_LicenseeProductSetting_BATCH(CustID INT,ProductSettingID INT, PRIMARY KEY(CustID ,ProductSettingID ))

	DECLARE @BatchNum INT = 4500 
	DECLARE @CustTempBatch TABLE (CustID INT)

	--Delete Dep_LicenseeProductSetting
	INSERT INTO #Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT dl.CustID,dl.ProductSettingID
	FROM Dep_LicenseeProductSetting dl WITH(NOLOCK)
			INNER JOIN Dep_ProductSetting dp WITH(NOLOCK) ON dl.ProductSettingID = dp.ProductSettingID
	WHERE dp.ProductID = 16

	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #Dep_LicenseeProductSetting 
		OUTPUT DELETED.CustID,deleted.ProductSettingID INTO #Dep_LicenseeProductSetting_BATCH(CustID,ProductSettingID)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM Dep_LicenseeProductSetting cg WITH(ROWLOCK,UPDLOCK) 	
			INNER JOIN #Dep_LicenseeProductSetting_BATCH t 
				ON cg.CustID=t.CustID AND cg.ProductSettingID=t.ProductSettingID 

		TRUNCATE TABLE #Dep_LicenseeProductSetting_BATCH
	END
    ----------------------------------------------------------------
	--PT
	INSERT INTO #Dep_CustPTSetting3rd_Agent(CustID)
	SELECT s.Custid
	FROM Dep_CustPTSetting_Agent s WITH(NOLOCK) 
	WHERE s.SportType = @Sporttype AND s.BetType = @BetType

	INSERT INTO #Dep_CustPTSetting3rd_Member(CustID)
	SELECT s.CustID
	FROM Dep_CustPTSetting_Member s WITH(NOLOCK) 
	WHERE s.SportType = @Sporttype AND s.BetType = @BetType

	INSERT INTO #Dep_CustPTGroupSetting3rd_Member(CustID)
	SELECT s.AgentID
	FROM Dep_CustPTGroupSetting_Member s WITH(NOLOCK) 
	WHERE s.SportType = @Sporttype AND s.BetType = @BetType

	--Bet Setting
	INSERT INTO #Dep_CustBetSetting_Agent(CustID)
	SELECT S.CustID
	FROM Dep_CustBetSetting_Agent S WITH(NOLOCK) 
	WHERE s.SportType = @Sporttype AND s.BetType = @BetType

	INSERT INTO #Dep_CustBetSetting_Member(CustID)
	SELECT S.CustID 
	FROM Dep_CustBetSetting_Member S WITH(NOLOCK) 
	WHERE s.SportType = @Sporttype AND s.BetType = @BetType

	
	--SELECT * FROM #Dep_CustPTSetting3rd_Agent
	--SELECT * FROM #Dep_CustPTSetting3rd_Member
	--SELECT * FROM #Dep_CustPTGroupSetting3rd_Member

	--SELECT * FROM #Dep_CustBetSetting_Agent
	--SELECT * FROM #Dep_CustBetSetting_Member
	---------------PT---------------------------
	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #Dep_CustPTSetting3rd_Agent 
		OUTPUT DELETED.CustID INTO @CustTempBatch(CustID)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustPTSetting_Agent cg WITH(ROWLOCK)		
			INNER JOIN @CustTempBatch ci ON cg.CustID = ci.CustID
		WHERE cg.SportType = @Sporttype AND cg.BetType = @BetType

		DELETE @CustTempBatch
	END

	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #Dep_CustPTSetting3rd_Member 
		OUTPUT DELETED.CustID INTO @CustTempBatch(CustID)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustPTSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN @CustTempBatch ci ON cg.CustID = ci.CustID
		WHERE cg.SportType = @Sporttype AND cg.BetType = @BetType

		DELETE @CustTempBatch
	END

	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #Dep_CustPTGroupSetting3rd_Member 
		OUTPUT DELETED.CustID INTO @CustTempBatch(CustID)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustPTGroupSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN @CustTempBatch ci ON cg.AgentID = ci.CustID
		WHERE cg.SportType = @Sporttype AND cg.BetType = @BetType

		DELETE @CustTempBatch
	END
	
	--------------Bet Setting---------------------------------
	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #Dep_CustBetSetting_Agent 
		OUTPUT DELETED.CustID INTO @CustTempBatch(CustID)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustBetSetting_Agent cg WITH(ROWLOCK)		
			INNER JOIN @CustTempBatch ci ON cg.CustID = ci.CustID
		WHERE cg.SportType = @Sporttype AND cg.BetType = @BetType

		DELETE @CustTempBatch
	END

	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #Dep_CustBetSetting_Member 
		OUTPUT DELETED.CustID INTO @CustTempBatch(CustID)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustBetSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN @CustTempBatch ci ON cg.CustID = ci.CustID
		WHERE cg.SportType = @Sporttype AND cg.BetType = @BetType

		DELETE @CustTempBatch
	END

	----Drop temp Tables
	DROP TABLE #Dep_CustPTGroupSetting3rd_Member
	DROP TABLE #Dep_CustPTSetting3rd_Agent
	DROP TABLE #Dep_CustPTSetting3rd_Member

	DROP TABLE #Dep_CustBetSetting_Agent
	DROP TABLE #Dep_CustBetSetting_Member

	DROP TABLE #Dep_LicenseeProductSetting
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS AND DBCUST -----
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @target = @target
