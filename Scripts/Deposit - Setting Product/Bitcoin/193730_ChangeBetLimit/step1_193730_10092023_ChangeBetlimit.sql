/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20230910
	Task: Bitcoin - Change Bet Limit RedmineID:#193730
	DB: DBCUST/CustDB
	Step 1 : Bitcoin - Change Bet Limit 
	
*/
-- BEGIN STEP 1.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@CustIDs VARCHAR(MAX)= ''
 	,@RoleID INT = 0
	,@MinBet  MONEY
	,@MaxBet  MONEY
	,@MaxPerMatch	MONEY
	,@IsMinBet	BIT
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
	CREATE TABLE #History_BetLimitTbl (CustID INT, SportType SMALLINT, BetType SMALLINT, MaxBet	MONEY
		, MaxPerMatch MONEY, UpdateTime DATETIME)
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
				UPDATE dca 
				SET dca.MinBet= CASE WHEN @IsMinBet = 1 
										THEN @MinBet 
										ELSE (CASE WHEN dca.MinBet > @MaxBet THEN @MaxBet ELSE dca.MinBet END) END,
					dca.MaxBet= CASE WHEN dca.MaxBet > @MaxBet THEN @MaxBet ELSE dca.MaxBet END, 
					dca.MaxPerMatch= CASE WHEN dca.MaxPerMatch > @MaxPerMatch THEN @MaxPerMatch ELSE dca.MaxPerMatch END
				FROM Dep_CustBetSetting_Agent dca WITH (ROWLOCK, UPDLOCK)
					INNER JOIN #CustListTemp c ON dca.CustID = c.CustID AND dca.SportType = @SportType 
								AND dca.BetType = @BetType
				
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
				UPDATE dca 
				SET dca.MinBet= CASE WHEN @IsMinBet = 1 
										THEN @MinBet 
										ELSE (CASE WHEN dca.MinBet > @MaxBet THEN @MaxBet ELSE dca.MinBet END) END,
					dca.MaxBet= CASE WHEN dca.MaxBet > @MaxBet THEN @MaxBet ELSE dca.MaxBet END, 
					dca.MaxPerMatch= CASE WHEN dca.MaxPerMatch > @MaxPerMatch THEN @MaxPerMatch ELSE dca.MaxPerMatch END
				OUTPUT deleted.CustID, deleted.SportType, deleted.BetType, deleted.MaxBet, deleted.MaxPerMatch, GETDATE()
				INTO #History_BetLimitTbl(CustID, SportType, BetType, MaxBet, MaxPerMatch, UpdateTime)
				FROM Dep_CustBetSetting_Member dca WITH (ROWLOCK, UPDLOCK)
					INNER JOIN #CustListTemp c ON dca.CustID = c.CustID AND dca.SportType = @SportType 
								AND dca.BetType = @BetType
				
				DELETE cs FROM #History_BetLimitTbl cs WHERE cs.MaxBet <= @MaxBet AND cs.MaxPerMatch <= @MaxPerMatch				
				IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE') 
				BEGIN
					INSERT INTO Dep_CustMaxBetSetting_History (CustID, SportType, BetType, OldMaxBet, OldMaxPerMatch, OldStakeLevelList, UpdateTime)
					SELECT CustID, SportType, BetType, MaxBet, MaxPerMatch, NULL, UpdateTime
					FROM #History_BetLimitTbl
				END

				TRUNCATE TABLE #CustListTemp
				TRUNCATE TABLE #History_BetLimitTbl
			END 	
		END

	DROP TABLE #CustList
	DROP TABLE #CustListTemp
	DROP TABLE #History_BetLimitTbl
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
CREATE TABLE #tmpBetLimit	(Currency INT, MinBet MONEY, MaxBet MONEY, MaxPerMatch MONEY, IsMinBet BIT)

INSERT INTO #tmpBetLimit(Currency, MinBet, MaxBet, MaxPerMatch, IsMinBet)
SELECT 2  AS Currency ,5 AS MinBet,500 AS MaxBet,500 AS MaxPerMatch, 0 As IsUpdMinBet		UNION ALL   -- RM
SELECT 4  AS Currency ,50 AS MinBet,5000 AS MaxBet,5000 AS MaxPerMatch, 1 As IsUpdMinBet	UNION ALL   -- TB
SELECT 5  AS Currency ,10 AS MinBet,1000 AS MaxBet,1000 AS MaxPerMatch, 0 As IsUpdMinBet	UNION ALL   -- HK$
SELECT 13 AS Currency ,10 AS MinBet,1000 AS MaxBet,1000 AS MaxPerMatch, 0 As IsUpdMinBet	UNION ALL   -- RMB
SELECT 15 AS Currency ,10 AS MinBet,2500 AS MaxBet,2500 AS MaxPerMatch, 0 As IsUpdMinBet	UNION ALL   -- IN
SELECT 51 AS Currency ,25 AS MinBet,5000 AS MaxBet,5000 AS MaxPerMatch, 0 As IsUpdMinBet	UNION ALL   -- INH
SELECT 61 AS Currency ,50 AS MinBet,15000 AS MaxBet,15000 AS MaxPerMatch, 1 As IsUpdMinBet	UNION ALL   -- INR
SELECT 66 AS Currency ,10 AS MinBet,1000 AS MaxBet,1000 AS MaxPerMatch, 0 As IsUpdMinBet				-- YUN

DECLARE @batch SMALLINT = 20000
DECLARE @CustIDs VARCHAR(MAX) 
DECLARE @max_custid INT, @srecommend INT, @currency INT , @Role SMALLINT = 0 , @MinBet  MONEY ,@MaxBet  MONEY ,@MaxPerMatch	MONEY, @IsMinBet	BIT
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
	AND ci.currency in (2,4,5,13,15,51,61,66) -- RM, TB, HK$, RMB, IN, INH, INR, YUN			  
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
			)
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
		EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @CustIDs = @CustIDs, @RoleID = @Role, @MinBet = @MinBet, @MaxBet = @MaxBet, @MaxPerMatch = @MaxPerMatch, @IsMinBet = @IsMinBet,@target = @target

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
		
		SELECT @MinBet = MinBet, @MaxBet = MaxBet, @MaxPerMatch = MaxPerMatch, @IsMinBet = IsMinBet FROM #tmpBetLimit WHERE Currency = @currency
	   END
END	

DROP TABLE #supers	
DROP TABLE #Dummy
DROP TABLE #tmpCust
DROP TABLE #tmpCustTemp
DROP TABLE #tmpSMA
DROP TABLE #tmpSMATemp
DROP TABLE #tmpBetLimit
GO
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

