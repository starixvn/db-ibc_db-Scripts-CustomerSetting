/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20230906
	Task: [Baji] - Adjust Sportsbook betlimit RedmineID:#193659
	DB: DBCUST/CustDB
	
*/
-- BEGIN STEP 1.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@max_custid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB-60\DEVDBCUST','TESTDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB-60\DEVDBCUST','TESTDBCUST')) RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('Dep_CustBetSettingGame_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSettingGameGroup_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSettingGame_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSettingDetail') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('custInfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_custsuper') = 0 RETURN	
	
	DECLARE @srecommend INT 
	CREATE TABLE #Dummy				(CustID INT PRIMARY KEY)	
	CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY CLUSTERED, RoleID INT,isfinished BIT DEFAULT(0))
		
	CREATE TABLE #CustList (CustID INT PRIMARY KEY,isfinished BIT DEFAULT(0))
	CREATE TABLE #CustListTemp (CustID INT PRIMARY KEY)
	DECLARE  @SportBetType	TABLE (SportType INT, BetType INT, MinBet MONEY, MaxBet MONEY)
	
	SET @srecommend = 47466472 --BajiSuperBDT

	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend = @srecommend AND roleid=3 
		AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
		AND custid<=@max_custid 
		
	INSERT INTO #tmpSMA(CustID,RoleID)
	SELECT CustID,RoleID
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend = @srecommend AND ci.custid<=@max_custid 
		AND roleid IN(2,3,4) AND ci.Enabled=1 AND mrecommend NOT IN (SELECT custid FROM #Dummy)		
		
	INSERT INTO #CustList(custid)	
	SELECT ci.CustID
	FROM custInfo ci WITH(NOLOCK)
		LEFT JOIN Dep_CustSettingMode m WITH(NOLOCK) ON ci.custid = m.CustID
	WHERE ci.srecommend = @srecommend AND ci.custid<=@max_custid 
		AND roleid = 1 AND ci.Enabled=1	AND mrecommend NOT IN (SELECT custid FROM #Dummy)
		AND ISNULL(m.IsGroupedBetLimit,0) = 0
	
	DECLARE @batch SMALLINT = 400
	
	INSERT INTO @SportBetType(SportType,BetType,MinBet,MaxBet) --15 row
	SELECT SportType, BetType, 1 AS MinBet, CASE WHEN BetType =9 AND SportType IN (1,99) THEN 60000 ELSE NULL END AS MaxBet
	FROM Dep_ProductSetting a WITH(NOLOCK)
	INNER JOIN Dep_ProductSettingDetail b WITH(NOLOCK) ON a.ProductSettingID = b.ProductSettingID
	WHERE ProductID = 1 AND SettingType = 10 AND SettingStatus = 0
	-- SMA
	UPDATE main
	SET   main.minbet	= tmp.MinBet
		, main.maxbet	= CASE WHEN main.BetType =9 AND main.SportType IN (1,99) THEN tmp.MaxBet ELSE  main.MaxBet END
	FROM dbo.Dep_CustBetSettingGame_Agent main WITH(ROWLOCK)
		INNER JOIN #tmpSMA a ON main.CustID = a.CustID
		INNER JOIN @SportBetType tmp	ON tmp.SportType = main.sporttype AND tmp.BetType = main.bettype

	UPDATE main
	SET   main.minbet	= tmp.MinBet
		, main.maxbet	= CASE WHEN main.BetType =9 AND main.SportType IN (1,99) THEN tmp.MaxBet ELSE  main.MaxBet END
	FROM dbo.Dep_CustBetSettingGameGroup_Member main WITH(ROWLOCK)
		INNER JOIN #tmpSMA a ON main.AgentID = a.CustID AND a.RoleID = 2
		INNER JOIN @SportBetType tmp	ON tmp.SportType = main.sporttype AND tmp.BetType = main.bettype

	WHILE(1 = 1)
	BEGIN
			
		UPDATE TOP (@batch) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID INTO #CustListTemp(CustID)
		FROM #CustList c 
		WHERE isfinished = 0
			
		IF @@ROWCOUNT = 0 BREAK
		-------------------------------------Betlimit Setting----------------------------------------------
		
		UPDATE dca 
		SET dca.MinBet= tmp.MinBet,
			dca.MaxBet=CASE WHEN dca.BetType =9 AND dca.SportType IN (1,99) THEN tmp.MaxBet ELSE  dca.MaxBet END,
			dca.MaxPerMatch=CASE WHEN dca.BetType =9 AND dca.SportType IN (1,99) AND dca.MaxPerMatch < tmp.MaxBet THEN tmp.MaxBet ELSE  dca.MaxPerMatch END
		FROM Dep_CustBetSettingGame_Member dca WITH (ROWLOCK, UPDLOCK)
			INNER JOIN #CustListTemp c ON dca.CustID = c.CustID 
			INNER JOIN @SportBetType tmp ON tmp.SportType = dca.sporttype AND tmp.BetType = dca.bettype

		TRUNCATE TABLE #CustListTemp
	END 	

	DROP TABLE #CustList
	DROP TABLE #CustListTemp
END
GO
-- BEGIN STEP 1: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----		
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

DECLARE @max_custid INT 
SELECT @max_custid = xxx

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
BEGIN
	SET @target = 'DBCUST'
END
ELSE 
BEGIN	
	SET @target = 'REPLICATED'
END
PRINT 'Server Name : ' + @target

EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @max_custid = @max_custid, @target = @target

GO
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

