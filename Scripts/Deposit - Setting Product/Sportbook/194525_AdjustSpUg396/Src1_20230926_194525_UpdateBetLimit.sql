/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20230926
	Task: [ug396] - Adjust Sportsbook betlimit for subsidiary "3mplay & 3mplay2" RedmineID:#194525
	DB: DBCUST/CustDB
	Step 1 : update betlimit for existing data
*/
-- BEGIN STEP 1.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@CustIDs VARCHAR(MAX)= ''
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB-60\DEVDBCUST','TESTDBCUST','DBSPARE')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB-60\DEVDBCUST','TESTDBCUST','DBSPARE')) RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('Dep_CustBetSettingGame_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSettingGameGroup_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSettingGame_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSettingDetail') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('custInfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_custsuper') = 0 RETURN	
	
	CREATE TABLE #Member (CustID INT ,SportType INT, BetType INT, MinBet MONEY, MaxBet MONEY, MaxPerMatch MONEY, MaxPayoutPerMatch MONEY, PRIMARY KEY CLUSTERED (CustID,SportType,BetType) )
	DECLARE  @SportBetType	TABLE (SportType INT, BetType INT, MinBet MONEY, MaxBet MONEY, MaxPerMatch MONEY, MaxPayoutPerMatch MONEY)

	INSERT INTO @SportBetType(SportType,BetType,MinBet,MaxBet,MaxPerMatch,MaxPayoutPerMatch) --15 row
	SELECT SportType, BetType,  5 AS MinBet, 250000 AS MaxBet,500000 AS MaxPerMatch, 4000000 AS MaxPayoutPerMatch
	FROM Dep_ProductSetting a WITH(NOLOCK)
	INNER JOIN Dep_ProductSettingDetail b WITH(NOLOCK) ON a.ProductSettingID = b.ProductSettingID
	WHERE ProductID = 1 AND SettingType = 10 AND SettingStatus = 0
	
	INSERT INTO #Member(custid,SportType,BetType,MinBet,MaxBet,MaxPerMatch,MaxPayoutPerMatch)	
	SELECT VALUE AS custid , SportType,BetType,MinBet,MaxBet,MaxPerMatch,MaxPayoutPerMatch
	FROM STRING_SPLIT(@CustIDs,',') a
		CROSS APPLY @SportBetType b
	WHERE VALUE <> ''

	UPDATE dca 
	SET dca.MinBet= tmp.MinBet,
		dca.MaxBet= CASE WHEN (dca.SportType NOT IN (1,99) OR ( dca.BetType <> 9 AND dca.SportType IN (1,99))) 
							THEN  tmp.MaxBet ELSE dca.MaxBet END ,
		dca.MaxPerMatch= CASE WHEN (dca.SportType NOT IN (1,99) OR ( dca.BetType <> 9 AND dca.SportType IN (1,99))) 
							THEN tmp.MaxPerMatch  ELSE dca.MaxPerMatch END,
		dca.MaxPayoutPerMatch= CASE WHEN (dca.SportType NOT IN (1,99) OR ( dca.BetType <> 9 AND dca.SportType IN (1,99))) 
							THEN tmp.MaxPayoutPerMatch   ELSE dca.MaxPayoutPerMatch END
	FROM Dep_CustBetSettingGame_Member dca WITH (ROWLOCK, UPDLOCK)
			INNER JOIN #Member tmp ON tmp.CustID =  dca.CustID AND tmp.SportType = dca.sporttype AND tmp.BetType = dca.bettype
						
	DROP TABLE #Member
END
GO
-- BEGIN STEP 1: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----		
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

	DECLARE @max_custid INT 
	SELECT @max_custid = xxx

	DECLARE @target VARCHAR(20)
	IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')
	BEGIN
		SET @target = 'DBCUST'
	END
	ELSE 
	BEGIN	
		SET @target = 'REPLICATED'
	END
	PRINT 'Server Name : ' + @target
	 
	DECLARE @srecommend INT, @CustIDs VARCHAR(MAX)  
	CREATE TABLE #Dummy		(CustID INT PRIMARY KEY)	
	CREATE TABLE #tmpSMA	(CustID INT PRIMARY KEY CLUSTERED, RoleID INT,isfinished BIT DEFAULT(0))
	CREATE TABLE #CustList  (CustID INT ,isfinished BIT DEFAULT(0), PRIMARY KEY CLUSTERED (isfinished,CustID))
	CREATE TABLE #CustListTemp (CustID INT PRIMARY KEY)
	DECLARE  @SportBetType	TABLE (SportType INT, BetType INT, MinBet MONEY, MaxBet MONEY, MaxPerMatch MONEY, MaxPayoutPerMatch MONEY)

	INSERT INTO @SportBetType(SportType,BetType,MinBet,MaxBet,MaxPerMatch,MaxPayoutPerMatch) --15 row
	SELECT SportType, BetType, 5 AS MinBet, 250000 AS MaxBet,500000 AS MaxPerMatch, 4000000 AS MaxPayoutPerMatch
	FROM Dep_ProductSetting a WITH(NOLOCK)
	INNER JOIN Dep_ProductSettingDetail b WITH(NOLOCK) ON a.ProductSettingID = b.ProductSettingID
	WHERE ProductID = 1 AND SettingType = 10 AND SettingStatus = 0

	SET @srecommend = 44521396 --ug396SuperIN

	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend = @srecommend AND roleid=3 
		AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
		AND custid<=@max_custid 
		
	INSERT INTO #tmpSMA(CustID,RoleID)
	SELECT CustID,RoleID
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend = @srecommend AND ci.custid<=@max_custid 
		AND roleid IN(2) 
		AND ci.Enabled=1 AND mrecommend NOT IN (SELECT custid FROM #Dummy)		
		AND ci.recommend in(62325561,47778984) -- 3mplay2, 3mplay
		AND ci.currency = 15 
	UNION ALL
	SELECT DISTINCT mrecommend,3 AS roleid
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend = @srecommend AND ci.custid<=@max_custid 
		AND roleid IN(2) AND ci.Enabled=1 
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)		
		AND ci.recommend in(62325561,47778984) -- 3mplay2, 3mplay
		AND ci.currency = 15 
	UNION ALL
	SELECT @srecommend as CustID, 4 AS RoleID

	INSERT INTO #CustList(custid)	
	SELECT ci.CustID
	FROM custInfo ci WITH(NOLOCK)
		LEFT JOIN Dep_CustSettingMode m WITH(NOLOCK) ON ci.custid = m.CustID
	WHERE ci.srecommend = @srecommend AND ci.custid<=@max_custid 
		AND roleid = 1 AND ci.Enabled=1	AND mrecommend NOT IN (SELECT custid FROM #Dummy)
		AND ISNULL(m.IsGroupedBetLimit,0) = 0
		AND ci.recommend in(62325561,47778984) -- 3mplay2, 3mplay
		AND ci.currency = 15 
	
	--SMA
	IF @target = 'DBCUST' 
	BEGIN
		UPDATE main
		SET main.MinBet= tmp.MinBet,
			main.MaxBet= CASE WHEN (main.SportType NOT IN (1,99) OR ( main.BetType <> 9 AND main.SportType IN (1,99))) 
							  THEN  tmp.MaxBet ELSE main.MaxBet END ,
			main.MaxPerMatch= CASE WHEN (main.SportType NOT IN (1,99) OR ( main.BetType <> 9 AND main.SportType IN (1,99))) 
							  THEN tmp.MaxPerMatch  ELSE main.MaxPerMatch END,
			main.MaxPayoutPerMatch= CASE WHEN (main.SportType NOT IN (1,99) OR ( main.BetType <> 9 AND main.SportType IN (1,99))) 
							  THEN tmp.MaxPayoutPerMatch   ELSE main.MaxPayoutPerMatch END
		FROM dbo.Dep_CustBetSettingGame_Agent main WITH(ROWLOCK)
			INNER JOIN #tmpSMA a ON main.CustID = a.CustID
			INNER JOIN @SportBetType tmp	ON tmp.SportType = main.sporttype AND tmp.BetType = main.bettype

		UPDATE main
		SET main.MinBet= tmp.MinBet,
			main.MaxBet= CASE WHEN (main.SportType NOT IN (1,99) OR ( main.BetType <> 9 AND main.SportType IN (1,99))) 
							  THEN  tmp.MaxBet ELSE main.MaxBet END ,
			main.MaxPerMatch= CASE WHEN (main.SportType NOT IN (1,99) OR ( main.BetType <> 9 AND main.SportType IN (1,99))) 
							  THEN tmp.MaxPerMatch  ELSE main.MaxPerMatch END,
			main.MaxPayoutPerMatch= CASE WHEN (main.SportType NOT IN (1,99) OR ( main.BetType <> 9 AND main.SportType IN (1,99))) 
							  THEN tmp.MaxPayoutPerMatch   ELSE main.MaxPayoutPerMatch END
		FROM dbo.Dep_CustBetSettingGameGroup_Member main WITH(ROWLOCK)
			INNER JOIN #tmpSMA a ON main.AgentID = a.CustID AND a.RoleID = 2
			INNER JOIN @SportBetType tmp	ON tmp.SportType = main.sporttype AND tmp.BetType = main.bettype
	END

	DECLARE @batch SMALLINT = 300
	DECLARE @Member_cnt INT, @index INT = 0
	DECLARE @startRun DATETIME, @endRun DATETIME, @duration	INT, @msgtmp nvarchar(200)
	SET @Member_cnt = (SELECT COUNT(*) FROM #CustList )
	DECLARE @msg nvarchar(200) = 'Currently at order %d '
	DECLARE @msg_total nvarchar(200) = 'Total of Member: %d.'
	RAISERROR (@msg_total, 0, 1, @Member_cnt) WITH NOWAIT

	WHILE (1 = 1)
	BEGIN
		SELECT @CustIDs = ''
		SELECT @startRun = GETDATE()

		UPDATE TOP (@batch) a
		SET a.isfinished = 1
		OUTPUT INSERTED.CustID INTO #CustListTemp(CustID)	
		FROM #CustList a	
		WHERE isfinished = 0 

		IF @@ROWCOUNT = 0 BREAK

		SET @CustIDs = (SELECT STRING_AGG(CONVERT(VARCHAR(MAX),custid),',')  FROM #CustListTemp)
		SET @index = @index + @batch

		EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @CustIDs = @CustIDs, @target = @target

		SELECT @endRun = GETDATE()
			, @duration = DATEDIFF(MILLISECOND, @startRun, @endRun)
		SELECT @msgtmp = 'Detail ' +  @msg  + ' Duration '+ CAST(@duration AS VARCHAR(20))
		RAISERROR (@msgtmp, 0, 1,@index) WITH NOWAIT

		TRUNCATE TABLE #CustListTemp
	END
	
	DROP TABLE #Dummy	
	DROP TABLE #tmpSMA	
	DROP TABLE #CustList  
	DROP TABLE #CustListTemp 
GO
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

