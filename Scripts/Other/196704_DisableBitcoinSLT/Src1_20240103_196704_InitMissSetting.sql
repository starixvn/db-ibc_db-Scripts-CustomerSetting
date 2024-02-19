/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240103@Winfred
	Task: Sitebuilder - Bitcoin/SLT - Enhance the settings when creating a new licensee [#196704]
	DB: DBCUST/CustDB and all subscriber of CustDB_custseting Pub

	Step 1 : Initial setting miss Betlimit
*/
------------------------------------------------------
-- BEGIN STEP 1.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@CustIDs VARCHAR(MAX)= ''
 	,@RoleID INT = 0
	,@MinBet  MONEY
	,@MaxBet  MONEY
	,@MaxPerMatch	MONEY
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB-60\DEVDBCUST','TESTDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB-60\DEVDBCUST','TESTDBCUST')) RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('custInfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_custsuper') = 0 RETURN	
	
	CREATE TABLE #CustList (CustID INT PRIMARY KEY,isfinished BIT DEFAULT(0))
	CREATE TABLE #CustListTemp (CustID INT PRIMARY KEY)
	DECLARE @batch SMALLINT = 5000, @Sporttype INT = 175, @Bettype INT = 7901 
	
	INSERT INTO #CustList(custid)	
	SELECT VALUE AS RuleID 
	FROM STRING_SPLIT(@CustIDs,',') WHERE VALUE <> ''

	IF @RoleID <>1
		BEGIN
			WHILE(1 =1)
			BEGIN
			
				UPDATE TOP (@batch) c WITH (ROWLOCK)
				SET c.isfinished = 1
				OUTPUT DELETED.CustID INTO #CustListTemp(CustID)
				FROM #CustList c 
				WHERE isfinished = 0
			
				IF @@ROWCOUNT = 0 BREAK
				-------------------------------------Betlimit Setting----------------------------------------------	
				INSERT INTO Dep_CustBetSetting_Agent(
					 CustID
					,SportType
					,BetType
					,MinBet
					,MaxBet
					,MaxPerMatch
				)
				SELECT t.CustID,@SportType,@BetType,@MinBet,@MaxBet,@MaxPerMatch
				FROM #CustListTemp t
				WHERE NOT EXISTS (SELECT TOP 1 1 FROM Dep_CustBetSetting_Agent WITH (NOLOCK) 
					  WHERE CustId=t.CustID AND SportType = @SportType AND BetType = @BetType)
								
				TRUNCATE TABLE #CustListTemp
			END
		END	
	
		IF @RoleID  = 1
		BEGIN
			WHILE(1 = 1)
			BEGIN
			
				UPDATE TOP (@batch) c WITH (ROWLOCK)
				SET c.isfinished = 1
				OUTPUT DELETED.CustID INTO #CustListTemp(CustID)
				FROM #CustList c 
				WHERE isfinished = 0
			
				IF @@ROWCOUNT = 0 BREAK
				-------------------------------------Betlimit Setting----------------------------------------------
				INSERT INTO Dep_CustBetSetting_Member(
					 CustID
					,SportType
					,BetType
					,MinBet
					,MaxBet
					,MaxPerMatch
				)
				SELECT t.CustID,@SportType,@BetType,@MinBet,@MaxBet,@MaxPerMatch
				FROM #CustListTemp t
				WHERE NOT EXISTS (SELECT TOP 1 1 FROM Dep_CustBetSetting_Member WITH (NOLOCK) 
					  WHERE CustId=t.CustID AND SportType = @SportType AND BetType = @BetType)
				
				TRUNCATE TABLE #CustListTemp
			END 	
		END

	DROP TABLE #CustList
	DROP TABLE #CustListTemp
END
GO
-- BEGIN STEP 1: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----		
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;
CREATE TABLE #supers		(CustID INT PRIMARY KEY, Currency INT, isfinished BIT DEFAULT(0))
CREATE TABLE #Dummy			(CustID INT PRIMARY KEY)	
CREATE TABLE #tmpCust		(CustID INT,srecommend INT,isfinished BIT DEFAULT(0), PRIMARY KEY CLUSTERED (srecommend,isfinished,CustID))
CREATE TABLE #tmpSMA		(CustID INT,srecommend INT,RoleID INT,isfinished BIT DEFAULT(0), PRIMARY KEY CLUSTERED (srecommend,isfinished,CustID))
							
CREATE TABLE #tmpCustTemp	(CustID INT PRIMARY KEY)
CREATE TABLE #tmpSMATemp	(CustID INT PRIMARY KEY)

DECLARE @batch SMALLINT = 20000
DECLARE @CustIDs VARCHAR(MAX) 
DECLARE @max_custid INT, @srecommend INT, @currency INT , @Role SMALLINT = 0 , 
		@MinBet  MONEY ,@MaxBet  MONEY ,@MaxPerMatch	MONEY
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

INSERT INTO #supers(custid,Currency)
SELECT ci.custid ,ci.currency
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND ci.custid in ( 88806986,88807001,91143469,94403570,90780173,92131963,91749085,97369913,91607721,92643270,92643349,92643311,92643389,92643200,92643234,92643161,98280850,93082198,100288828,93773878,87336302,87336317,81770426,81770453,81770440,81770480,81770413,86572218,81770400,86572203,81770466,91749679,91218158,91218122,90083405,90083420,103544696,90303510,90303468,90303495,90303481,90303454,84914296,84914309,92267919,97048484,89323941,87065410,91144515,91144528,90075568,94935760,92081162,92081149,95541843,91141721,92133948,92002197,92002164,92002126,92002274,92063609,92002231,92270911,92270877,84858564,91048094,98457072,90835476,98203829,98203867,89595430,88720248,87336492,87336505,105235573,93605710,95930150,97852534,89311296,94167509,89656967,91071766,97698777,91071724,91805745,91805814,91805780,91805634,91805882,91805709,91805917,91805673,92579714,91805848,92579699,92076091,92076125,98208177,92641939,92641868,92641904,88130172,88130136,88129698,88129732,88129913,88129879,88129179,88129144,83464105,83464171,83464138,83463906,83464205,83464005,83464240,83463939,83463972,83464038,83463872,83464072,88131866,88131831,87654243,87654277,88129527,88129560,88129341,88129374,87654092,87654056,89119235,89119222,90320847,90320888,85780955,85780972,90006333,91805033,91805071,90778746,90778708,91807158,92705963,83979426,83979466,89592342,89592414,89592379,89592450,89592308,81721484,81721467,88115690,88801460,82980831,82980818,92576534,105235381,86501833,92759268,96007232,93076149,85790814,86343967,79692808,80876260,85863366,83199185,83199219,84711318,84711332,89806752,89806789,97369423 )	
ORDER BY ci.custid 

INSERT INTO #Dummy(CustID)
SELECT CustID FROM Customer WITH(NOLOCK) 
WHERE srecommend IN (SELECT CustID FROM #supers) AND roleid=3 
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
	AND custid<=@max_custid 

INSERT INTO #tmpCust(CustID,srecommend)
SELECT CustID, srecommend
FROM custInfo ci WITH(NOLOCK)
WHERE ci.srecommend IN (SELECT CustID FROM #supers) AND ci.custid<=@max_custid 
	AND roleid = 1 AND ci.Enabled=1	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

INSERT INTO #tmpSMA(CustID,RoleID,srecommend)
SELECT CustID,RoleID,srecommend
FROM custInfo ci WITH(NOLOCK)
WHERE ci.srecommend IN (SELECT CustID FROM #supers) AND ci.custid<=@max_custid 
	AND roleid IN(2,3,4) AND ci.Enabled=1 AND mrecommend NOT IN (SELECT custid FROM #Dummy)		

DECLARE @super_cnt INT, @index INT = 0 , @DoneSM BIT, @DoneAgent BIT
DECLARE @startRun DATETIME, @endRun DATETIME, @duration	INT, @msgtmp nvarchar(200), @indexDetail INT = 0
SET @super_cnt = (SELECT COUNT(*) FROM #supers )
DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d. '
DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

SELECT @srecommend = 0 ,@DoneSM = 0 , @DoneAgent = 0

WHILE (1 = 1)
BEGIN
	SELECT @CustIDs = ''
	SELECT @startRun = GETDATE()
	IF EXISTS(SELECT TOP 1 1 
				FROM #tmpSMA
				WHERE isfinished = 0 AND srecommend = @srecommend
				UNION ALL
				SELECT TOP 1 1 
				FROM #tmpCust
				WHERE isfinished = 0 AND srecommend = @srecommend
			) AND @MinBet IS NOT NULL AND  @MaxBet IS NOT NULL AND  @MaxPerMatch IS NOT NULL 
	BEGIN
		 UPDATE TOP (@batch) a
		SET a.isfinished = 1
		OUTPUT INSERTED.CustID INTO #tmpSMATemp(CustID)	
		FROM #tmpSMA a	
		WHERE isfinished = 0 AND RoleID <>  2 AND srecommend = @srecommend
		
		IF @@ROWCOUNT = 0 SET @DoneSM = 1
		IF @DoneSM = 0
		BEGIN
		  SET @CustIDs = @CustIDs + (SELECT STRING_AGG(CONVERT(VARCHAR(MAX),custid),',')  FROM #tmpSMATemp)
		END
		ELSE
		BEGIN
			UPDATE TOP (@batch) a
			SET a.isfinished = 1
			OUTPUT INSERTED.CustID INTO #tmpSMATemp(CustID)	
			FROM #tmpSMA a	
			WHERE isfinished = 0 AND RoleID = 2 AND srecommend = @srecommend
			
			IF @@ROWCOUNT = 0 SET @DoneAgent = 1
			IF @DoneAgent = 0
			BEGIN
				SET @CustIDs = @CustIDs + (SELECT STRING_AGG(CONVERT(VARCHAR(MAX),custid),',')  FROM #tmpSMATemp)
				SELECT @Role = 2
			END
			ELSE
			BEGIN
				UPDATE TOP (@batch) a
				SET a.isfinished = 1
				OUTPUT INSERTED.CustID INTO #tmpCustTemp(CustID)	
				FROM #tmpCust a	
				WHERE isfinished = 0 AND srecommend = @srecommend
				IF @@ROWCOUNT = 0 BREAK
				SET @CustIDs = @CustIDs + (SELECT STRING_AGG(CONVERT(VARCHAR(MAX),custid),',')  FROM #tmpCustTemp)
				SELECT @Role = 1
			END
		END
		SET @indexDetail = @indexDetail + @batch
		EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @CustIDs = @CustIDs, @RoleID = @Role, @MinBet = @MinBet, @MaxBet = @MaxBet, @MaxPerMatch = @MaxPerMatch, @target = @target

		SELECT @endRun = GETDATE()
			, @duration = DATEDIFF(MILLISECOND, @startRun, @endRun)
		SELECT @msgtmp = 'Detail ' +  @msg  + ' Duration '+ CAST(@duration AS VARCHAR(20))
		RAISERROR (@msgtmp, 0, 1,@indexDetail, @srecommend) WITH NOWAIT

		TRUNCATE TABLE #tmpCustTemp
		TRUNCATE TABLE #tmpSMATemp
		WAITFOR DELAY '00:00:00.050'	
	END
	ELSE
	BEGIN
		SET @MinBet = NULL
		SET @MaxBet = NULL
		SET @MaxPerMatch = NULL

		UPDATE TOP (1) #supers
		SET isfinished = 1
			,@srecommend = custid
			,@currency = currency
			,@DoneSM = 0
			,@DoneAgent = 0	
			,@Role  = 0	
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK
		SET @index = @index + 1
		SET @indexDetail = 0
		RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
		
		SELECT @MinBet = MinBet, @MaxBet = MaxBet, @MaxPerMatch = MaxPerMatch 
		FROM Dep_ProductBetSetting WITH (NOLOCK) 
		WHERE Currency = @currency AND Sporttype = 175 AND Bettype = 7901

	   END
END	

DROP TABLE #supers	
DROP TABLE #Dummy
DROP TABLE #tmpCust
DROP TABLE #tmpCustTemp
DROP TABLE #tmpSMA
DROP TABLE #tmpSMATemp
GO
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

