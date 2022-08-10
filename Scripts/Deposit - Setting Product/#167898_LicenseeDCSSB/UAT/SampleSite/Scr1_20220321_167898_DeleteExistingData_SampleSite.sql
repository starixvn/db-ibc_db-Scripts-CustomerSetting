/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20220321
	Task: Deleted Existing Data - for SB,NG,Keno DCS - SampleSite UUS [Redmine:#167898]
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

		OR dbo.f_CheckRepTable('Dep_CustBetSettingGame_Agent') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSettingGame_Member') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSettingGameGroup_Member') = 0 

		OR dbo.f_CheckRepTable('Dep_CustDiscountSetting_Member') = 0		
		OR dbo.f_CheckRepTable('Dep_CustDiscountGroupSetting_Member') = 0
		OR dbo.f_CheckRepTable('Dep_CustDiscountSetting_Agent') = 0
		
		OR dbo.f_CheckRepTable('Dep_ProductSetting') = 0
		OR dbo.f_CheckRepTable('Dep_ProductSettingDetail') = 0
		OR dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 
		
		OR dbo.f_CheckRepTable('CustInfo') = 0 
		OR dbo.f_CheckRepTable('Customer') = 0 

		OR dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 
	    OR dbo.f_CheckRepTable('Dep_ProductStatusProfile') = 0 
	   )
		RETURN

	DECLARE @SportBettype_tbl Table(Sporttype SMALLINT, BetType SMALLINT, HavePT BIT, HaveComm BIT, HaveBetSetting BIT, HaveBetSettingGame BIT,ProductID TINYINT)
	INSERT INTO @SportBettype_tbl(Sporttype,BetType,HavePT,HaveComm,HaveBetSetting,HaveBetSettingGame,ProductID)
	SELECT a.SportType,a.BetType,
		MAX(CASE WHEN b.SettingType = 1 THEN 1 ELSE 0 END) AS HavePT,
		MAX(CASE WHEN b.SettingType = 9 THEN 1 ELSE 0 END) AS HaveComm,
		MAX(CASE WHEN b.SettingType IN (2,11) THEN 1 ELSE 0 END) AS HaveBetSetting,
		MAX(CASE WHEN b.SettingType IN (10,12) THEN 1 ELSE 0 END) AS HaveBetSettingGame,
		MAX(b.ProductID) AS ProductID
	FROM Dep_ProductSettingDetail a WITH(NOLOCK)
		INNER JOIN Dep_ProductSetting b WITH(NOLOCK) ON a.ProductSettingID = b.ProductSettingID
	WHERE b.ProductID IN(1,3,8)
	GROUP BY a.SportType,a.BetType

	--SELECT * FROM @SportBettype_tbl

	CREATE TABLE #supers (custid INT)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'			
		AND ci.Enabled=1
		AND ci.roleid = 4
		AND Ci.currency = 20
		AND cs.site IN('SampleSite')
	ORDER by ci.custid
		
	CREATE TABLE #Dep_CustPTSetting3rd_Agent(CustID INT)
	CREATE TABLE #Dep_CustPTSetting3rd_Member(CustID INT)
	CREATE TABLE #Dep_CustPTGroupSetting3rd_Member(CustID INT)

	CREATE TABLE #Dep_CustBetSetting_Agent(CustID INT)
	CREATE TABLE #Dep_CustBetSetting_Member(CustID INT)

	CREATE TABLE #Dep_CustBetSettingGame_Agent(CustID INT)
	CREATE TABLE #Dep_CustBetSettingGame_Member(CustID INT)
	CREATE TABLE #Dep_CustBetSettingGameGroup_Member(CustID INT)

	CREATE TABLE #Dep_CustDiscountSetting_Agent(CustID INT)
	CREATE TABLE #Dep_CustDiscountSetting_Member(CustID INT)
	CREATE TABLE #Dep_CustDiscountGroupSetting_Member(CustID INT)

	CREATE TABLE #Dep_LicenseeProductSetting(CustID INT,ProductSettingID INT, PRIMARY KEY(CustID ,ProductSettingID ))

	--Delete Dep_LicenseeProductSetting
	INSERT INTO #Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT dl.CustID,dl.ProductSettingID
	FROM Dep_LicenseeProductSetting dl WITH(NOLOCK)
			INNER JOIN Dep_ProductSetting dp WITH(NOLOCK) ON dl.ProductSettingID = dp.ProductSettingID
			INNER JOIN CustInfo ci WITH(NOLOCK) ON dl.CustID = ci.custid
			INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE dp.ProductID IN(1,3,8)

	IF EXISTS(SELECT 1 FROM #Dep_LicenseeProductSetting)
	BEGIN
		DELETE cg
		FROM Dep_LicenseeProductSetting cg WITH(ROWLOCK,UPDLOCK) 	
			INNER JOIN #Dep_LicenseeProductSetting t 
				ON cg.CustID=t.CustID AND cg.ProductSettingID=t.ProductSettingID 
	END

	--PT
	INSERT INTO #Dep_CustPTSetting3rd_Agent(CustID)
	SELECT DISTINCT s.Custid
	FROM Dep_CustPTSetting_Agent s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
		INNER JOIN @SportBettype_tbl t ON s.SportType = t.Sporttype AND s.BetType = t.BetType AND t.HavePT = 1
	WHERE c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #Dep_CustPTSetting3rd_Member(CustID)
	SELECT DISTINCT s.CustID
	FROM Dep_CustPTSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
		INNER JOIN @SportBettype_tbl t ON s.SportType = t.Sporttype AND s.BetType = t.BetType AND t.HavePT = 1
	WHERE c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #Dep_CustPTGroupSetting3rd_Member(CustID)
	SELECT DISTINCT s.AgentID
	FROM Dep_CustPTGroupSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.AgentID=c.custid
		INNER JOIN @SportBettype_tbl t ON s.SportType = t.Sporttype AND s.BetType = t.BetType AND t.HavePT = 1
	WHERE c.srecommend IN(SELECT CustID FROM #supers)

	--Bet Setting
	INSERT INTO #Dep_CustBetSetting_Agent(CustID)
	SELECT DISTINCT S.CustID
	FROM Dep_CustBetSetting_Agent S WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
		INNER JOIN @SportBettype_tbl t ON s.SportType = t.Sporttype AND s.BetType = t.BetType AND t.HaveBetSetting = 1
	WHERE c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #Dep_CustBetSetting_Member(CustID)
	SELECT DISTINCT S.CustID 
	FROM Dep_CustBetSetting_Member S WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
		INNER JOIN @SportBettype_tbl t ON s.SportType = t.Sporttype AND s.BetType = t.BetType AND t.HaveBetSetting = 1
	WHERE c.srecommend IN(SELECT CustID FROM #supers)

	--Bet Setting Game
	INSERT INTO #Dep_CustBetSettingGame_Agent(CustID)
	SELECT DISTINCT S.CustID
	FROM Dep_CustBetSettingGame_Agent S WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
		INNER JOIN @SportBettype_tbl t ON s.SportType = t.Sporttype AND s.BetType = t.BetType AND t.HaveBetSettingGame = 1
	WHERE c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #Dep_CustBetSettingGame_Member(CustID)
	SELECT DISTINCT S.CustID 
	FROM Dep_CustBetSettingGame_Member S WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
		INNER JOIN @SportBettype_tbl t ON s.SportType = t.Sporttype AND s.BetType = t.BetType AND t.HaveBetSettingGame = 1
	WHERE c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #Dep_CustBetSettingGameGroup_Member(CustID)
	SELECT DISTINCT S.AgentID 
	FROM Dep_CustBetSettingGameGroup_Member S WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.AgentID=c.custid
		INNER JOIN @SportBettype_tbl t ON s.SportType = t.Sporttype AND s.BetType = t.BetType AND t.HaveBetSettingGame = 1
	WHERE c.srecommend IN(SELECT CustID FROM #supers)

	--Comm
	INSERT INTO #Dep_CustDiscountSetting_Agent(CustID)
	SELECT DISTINCT s.Custid
	FROM Dep_CustDiscountSetting_Agent s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
		INNER JOIN @SportBettype_tbl t ON s.SportType = t.Sporttype AND s.BetType = t.BetType AND t.HaveComm = 1
	WHERE c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #Dep_CustDiscountSetting_Member(CustID)
	SELECT DISTINCT s.Custid
	FROM Dep_CustDiscountSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
		INNER JOIN @SportBettype_tbl t ON s.SportType = t.Sporttype AND s.BetType = t.BetType AND t.HaveComm = 1
	WHERE c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #Dep_CustDiscountGroupSetting_Member(CustID)
	SELECT DISTINCT s.AgentID
	FROM Dep_CustDiscountGroupSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.AgentID=c.custid
		INNER JOIN @SportBettype_tbl t ON s.SportType = t.Sporttype AND s.BetType = t.BetType AND t.HaveComm = 1
	WHERE c.srecommend IN(SELECT CustID FROM #supers)
	
	--SELECT * FROM #Dep_CustPTSetting3rd_Agent
	--SELECT * FROM #Dep_CustPTSetting3rd_Member
	--SELECT * FROM #Dep_CustPTGroupSetting3rd_Member

	--SELECT * FROM #Dep_CustBetSetting_Agent
	--SELECT * FROM #Dep_CustBetSetting_Member

	--SELECT * FROM #Dep_CustBetSettingGame_Agent
	--SELECT * FROM #Dep_CustBetSettingGame_Member
	--SELECT * FROM #Dep_CustBetSettingGameGroup_Member

	--SELECT * FROM #Dep_CustDiscountSetting_Agent
	--SELECT * FROM #Dep_CustDiscountSetting_Member
	--SELECT * FROM #Dep_CustDiscountGroupSetting_Member

	DECLARE @BatchNum INT = 350 
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
			INNER JOIN @SportBettype_tbl t ON cg.SportType = t.Sporttype AND cg.BetType = t.BetType AND t.HavePT = 1

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
			INNER JOIN @SportBettype_tbl t ON cg.SportType = t.Sporttype AND cg.BetType = t.BetType AND t.HavePT = 1

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
			INNER JOIN @SportBettype_tbl t ON cg.SportType = t.Sporttype AND cg.BetType = t.BetType AND t.HavePT = 1

		TRUNCATE TABLE #CustTempBatch
	END
	
	--------------Bet Setting---------------------------------
	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #Dep_CustBetSetting_Agent 
		OUTPUT DELETED.CustID INTO #CustTempBatch(CustID)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustBetSetting_Agent cg WITH(ROWLOCK)		
			INNER JOIN #CustTempBatch ci ON ci.custid = cg.CustID	
			INNER JOIN @SportBettype_tbl t ON cg.SportType = t.Sporttype AND cg.BetType = t.BetType AND t.HaveBetSetting = 1

		TRUNCATE TABLE #CustTempBatch
	END

	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #Dep_CustBetSetting_Member 
		OUTPUT DELETED.CustID INTO #CustTempBatch(CustID)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustBetSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustTempBatch ci ON ci.custid = cg.CustID	
			INNER JOIN @SportBettype_tbl t ON cg.SportType = t.Sporttype AND cg.BetType = t.BetType AND t.HaveBetSetting = 1

		TRUNCATE TABLE #CustTempBatch
	END

	--------------Bet Setting Game---------------------------------
	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #Dep_CustBetSettingGame_Agent 
		OUTPUT DELETED.CustID INTO #CustTempBatch(CustID)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustBetSettingGame_Agent cg WITH(ROWLOCK)		
			INNER JOIN #CustTempBatch ci ON ci.custid = cg.CustID	
			INNER JOIN @SportBettype_tbl t ON cg.SportType = t.Sporttype AND cg.BetType = t.BetType AND t.HaveBetSettingGame = 1

		TRUNCATE TABLE #CustTempBatch
	END

	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #Dep_CustBetSettingGame_Member 
		OUTPUT DELETED.CustID INTO #CustTempBatch(CustID)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustBetSettingGame_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustTempBatch ci ON ci.custid = cg.CustID	
			INNER JOIN @SportBettype_tbl t ON cg.SportType = t.Sporttype AND cg.BetType = t.BetType AND t.HaveBetSettingGame = 1

		TRUNCATE TABLE #CustTempBatch
	END

	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #Dep_CustBetSettingGameGroup_Member 
		OUTPUT DELETED.CustID INTO #CustTempBatch(CustID)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustBetSettingGameGroup_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustTempBatch ci ON ci.custid = cg.AgentID	
			INNER JOIN @SportBettype_tbl t ON cg.SportType = t.Sporttype AND cg.BetType = t.BetType AND t.HaveBetSettingGame = 1

		TRUNCATE TABLE #CustTempBatch
	END

	---------------Comm------------------------------------
	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #Dep_CustDiscountSetting_Agent 
		OUTPUT DELETED.CustID INTO #CustTempBatch(CustID)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustDiscountSetting_Agent cg WITH(ROWLOCK)		
			INNER JOIN #CustTempBatch ci ON ci.custid = cg.CustID	
			INNER JOIN @SportBettype_tbl t ON cg.SportType = t.Sporttype AND cg.BetType = t.BetType AND t.HaveComm = 1

		TRUNCATE TABLE #CustTempBatch
	END

	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #Dep_CustDiscountSetting_Member 
		OUTPUT DELETED.CustID INTO #CustTempBatch(CustID)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustDiscountSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustTempBatch ci ON ci.custid = cg.CustID	
			INNER JOIN @SportBettype_tbl t ON cg.SportType = t.Sporttype AND cg.BetType = t.BetType AND t.HaveComm = 1

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
			INNER JOIN @SportBettype_tbl t ON cg.SportType = t.Sporttype AND cg.BetType = t.BetType AND t.HaveComm = 1

		TRUNCATE TABLE #CustTempBatch
	END

	----Drop temp Tables
	DROP TABLE #CustTempBatch

	DROP TABLE #Dep_CustPTGroupSetting3rd_Member
	DROP TABLE #Dep_CustPTSetting3rd_Agent
	DROP TABLE #Dep_CustPTSetting3rd_Member

	DROP TABLE #Dep_CustBetSetting_Agent
	DROP TABLE #Dep_CustBetSetting_Member

	DROP TABLE #Dep_CustBetSettingGame_Agent
	DROP TABLE #Dep_CustBetSettingGame_Member
	DROP TABLE #Dep_CustBetSettingGameGroup_Member

	DROP TABLE #Dep_CustDiscountSetting_Agent
	DROP TABLE #Dep_CustDiscountGroupSetting_Member
	DROP TABLE #Dep_CustDiscountSetting_Member

	DROP TABLE #Dep_LicenseeProductSetting

	DROP TABLE #supers
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
