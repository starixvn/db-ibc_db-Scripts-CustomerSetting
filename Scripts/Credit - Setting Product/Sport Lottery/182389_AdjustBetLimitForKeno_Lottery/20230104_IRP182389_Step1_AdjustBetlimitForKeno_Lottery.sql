/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20230104@Johnson
	Task:  RNG Keno/RNG Lottery/Table Game/Sports Lottery - Adjust bet limit for Credit market [redmine: #182389]
	DB: DBCUST/CustDB
*/
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@srecommend INT,
	@MaxCustID INT,
	@MinBet	MONEY,
	@MaxBet MONEY,	
	@MPM 	MONEY,	
	@target VARCHAR(20)	
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustGameType') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN

	CREATE TABLE #tblCust (custid INT PRIMARY KEY, roleid TINYINT, isFinished BIT DEFAULT(0))
	DECLARE @tmpCustHistory TABLE(custid INT, sporttype SMALLINT, bettype SMALLINT, MaxBet MONEY, MPM MONEY PRIMARY KEY(custid,sporttype,bettype))
	DECLARE @tmpCust TABLE(custid INT PRIMARY KEY)
	DECLARE @tmpGameType TABLE (GameTypeID INT, Bettype SMALLINT)	
	DECLARE @NewMinBet MONEY,@NewMaxBet MONEY,@NewMPM MONEY
	
	INSERT INTO #tblCust(custid,roleid)
	SELECT custid,roleid
	FROM custinfo c WITH(NOLOCK)
	WHERE c.srecommend = @srecommend		
		AND c.enabled = 1
		AND custid <= @MaxCustID
	
	INSERT INTO @tmpGameType(GameTypeID,Bettype)
	SELECT 	1	,	1501
	UNION SELECT 	15	,	1515
	UNION SELECT 	16	,	1516
	UNION SELECT 	17	,	1517
	UNION SELECT 	19	,	1519
	UNION SELECT 	20	,	1520
	UNION SELECT 	21	,	1521
	UNION SELECT 	22	,	1522
	UNION SELECT 	24	,	1524
	UNION SELECT 	25	,	1525
	UNION SELECT 	26	,	1526
	UNION SELECT 	27	,	1527
	UNION SELECT 	28	,	1528
	UNION SELECT 	29	,	1529
	UNION SELECT 	30	,	1530
	UNION SELECT 	31	,	1531
	
	WHILE(1=1)
	BEGIN
		UPDATE TOP (300) t
		SET isFinished = 1
		OUTPUT DELETED.custid INTO @tmpCust(custid)
		FROM #tblCust t
		WHERE isFinished = 0
			AND roleid > 1
		
		IF @@ROWCOUNT = 0
			BREAK;
			
		UPDATE cs
		SET @NewMinBet = CASE WHEN cs.MinBet < @MinBet THEN @MinBet ELSE cs.MinBet END,
			@NewMaxBet = CASE WHEN cs.MaxBet > @MaxBet THEN @MaxBet ELSE cs.MaxBet END,
			@NewMPM = CASE WHEN cs.MaxPerGameType > @MPM THEN @MPM ELSE cs.MaxPerGameType END,
			@NewMaxBet = CASE WHEN @NewMPM < @NewMaxBet THEN @NewMPM ELSE @NewMaxBet END,	
			@NewMinBet = CASE WHEN @NewMaxBet < @NewMinBet THEN @NewMaxBet ELSE @NewMinBet END,					
			cs.MinBet = @NewMinBet,
			cs.MaxBet = @NewMaxBet,
			cs.MaxPerGameType = @NewMPM
		FROM CustGameType cs WITH(UPDLOCK,ROWLOCK)			
		WHERE cs.custid IN (SELECT custid FROM @tmpCust)
			AND cs.GameTypeID BETWEEN 1 AND 31
			AND cs.MaxBet >= 1 AND cs.MaxPerGameType >= 1
			AND (cs.MaxBet > @MaxBet OR cs.MaxPerGameType > @MPM OR cs.MinBet < @MinBet)
		
		UPDATE cs
		SET @NewMinBet = CASE WHEN cs.MinBet < @MinBet THEN @MinBet ELSE cs.MinBet END,
			@NewMaxBet = CASE WHEN cs.MaxBet > @MaxBet THEN @MaxBet ELSE cs.MaxBet END,
			@NewMPM = CASE WHEN cs.MaxPerMatch > @MPM THEN @MPM ELSE cs.MaxPerMatch END,
			@NewMaxBet = CASE WHEN @NewMPM < @NewMaxBet THEN @NewMPM ELSE @NewMaxBet END,	
			@NewMinBet = CASE WHEN @NewMaxBet < @NewMinBet THEN @NewMaxBet ELSE @NewMinBet END,	
			cs.MinBet = @NewMinBet,
			cs.MaxBet = @NewMaxBet,
			cs.MaxPerMatch = @NewMPM
		FROM CustBetSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)			
		WHERE cs.custid IN (SELECT custid FROM @tmpCust)
			AND cs.SportType in (169,220,222)
			AND cs.MaxBet >= 1 AND cs.MaxPerMatch >= 1
			AND (cs.MaxBet > @MaxBet OR cs.MaxPerMatch > @MPM OR cs.MinBet < @MinBet)
					
		DELETE @tmpCust			
	END	
	
	WHILE(1=1)
	BEGIN
		UPDATE TOP (300) t
		SET isFinished = 1
		OUTPUT DELETED.custid INTO @tmpCust(custid)
		FROM #tblCust t
		WHERE isFinished = 0
			AND roleid = 1
		
		IF @@ROWCOUNT = 0
			BREAK;
		
		--RnG Keno
		UPDATE cs
		SET @NewMinBet = CASE WHEN cs.MinBet < @MinBet THEN @MinBet ELSE cs.MinBet END,
			@NewMaxBet = CASE WHEN cs.MaxBet > @MaxBet THEN @MaxBet ELSE cs.MaxBet END,
			@NewMPM = CASE WHEN cs.MaxPerGameType > @MPM THEN @MPM ELSE cs.MaxPerGameType END,
			@NewMaxBet = CASE WHEN @NewMPM < @NewMaxBet THEN @NewMPM ELSE @NewMaxBet END,	
			@NewMinBet = CASE WHEN @NewMaxBet < @NewMinBet THEN @NewMaxBet ELSE @NewMinBet END,	
			cs.MinBet = @NewMinBet,
			cs.MaxBet = @NewMaxBet,
			cs.MaxPerGameType = @NewMPM
		OUTPUT DELETED.custid, 202, DELETED.GameTypeID, DELETED.MaxBet, DELETED.MaxPerGameType
		INTO @tmpCustHistory(custid,sporttype,bettype,maxbet,MPM)
		FROM CustGameType cs WITH(UPDLOCK,ROWLOCK)			
		WHERE cs.custid IN (SELECT custid FROM @tmpCust)
			AND cs.GameTypeID BETWEEN 1 AND 31
			AND cs.MaxBet >= 1 AND cs.MaxPerGameType >= 1
			AND (cs.MaxBet > @MaxBet OR cs.MaxPerGameType > @MPM OR cs.MinBet < @MinBet)
		
		DELETE @tmpCustHistory 
		WHERE MaxBet = @MaxBet AND MPM = @MPM
		
		IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE') 
		BEGIN
			INSERT INTO CustMaxBetSetting_History 
				(CustID, SportType, BetType, OldMaxBet, OldMaxPerMatch, OldStakeLevelList, UpdateTime)
			SELECT CustID, SportType, g.BetType, MaxBet, MPM, NULL StakeLevelList, GETDATE() as UpdateTime
			FROM @tmpCustHistory c
				INNER JOIN @tmpGameType g ON c.Bettype = g.GameTypeID
		END
		
		DELETE @tmpCustHistory
		
		--Lottery
		UPDATE cs
		SET @NewMinBet = CASE WHEN cs.MinBet < @MinBet THEN @MinBet ELSE cs.MinBet END,
			@NewMaxBet = CASE WHEN cs.MaxBet > @MaxBet THEN @MaxBet ELSE cs.MaxBet END,
			@NewMPM = CASE WHEN cs.MaxPerMatch > @MPM THEN @MPM ELSE cs.MaxPerMatch END,
			@NewMaxBet = CASE WHEN @NewMPM < @NewMaxBet THEN @NewMPM ELSE @NewMaxBet END,	
			@NewMinBet = CASE WHEN @NewMaxBet < @NewMinBet THEN @NewMaxBet ELSE @NewMinBet END,	
			cs.MinBet = @NewMinBet,
			cs.MaxBet = @NewMaxBet,
			cs.MaxPerMatch = @NewMPM
		OUTPUT DELETED.custid, DELETED.sporttype, DELETED.bettype, DELETED.MaxBet, DELETED.MaxPerMatch
		INTO @tmpCustHistory(custid,sporttype,bettype,maxbet,MPM)
		FROM CustBetSetting3rd_Member cs WITH(UPDLOCK,ROWLOCK)			
		WHERE cs.custid IN (SELECT custid FROM @tmpCust)
			AND cs.SportType in (169,220,222)
			AND cs.MaxBet >= 1 AND cs.MaxPerMatch >= 1
			AND (cs.MaxBet > @MaxBet OR cs.MaxPerMatch > @MPM OR cs.MinBet < @MinBet)
		
		DELETE @tmpCustHistory 
		WHERE MaxBet = @MaxBet AND MPM = @MPM
		
		IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE') 
		BEGIN
			INSERT INTO CustMaxBetSetting_History 
				(CustID, SportType, BetType, OldMaxBet, OldMaxPerMatch, OldStakeLevelList, UpdateTime)
			SELECT CustID, SportType, BetType, MaxBet, MPM, NULL StakeLevelList, GETDATE() as UpdateTime
			FROM @tmpCustHistory c				
		END
		
		DELETE @tmpCustHistory
		
		DELETE @tmpCust			
	END	
END
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
DECLARE @MaxCustID INT = xxx

IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

DECLARE @srecommend INT,		
		@currency INT,
		@MinBet MONEY,	
		@MaxBet MONEY,
		@MPM MONEY,				
		@super_cnt INT, 
		@index INT = 0
		
CREATE TABLE #Supers(CustID INT, currency INT, isfinished BIT DEFAULT(0))
DECLARE @tmpBetSetting TABLE(currency INT, MinBet MONEY, MaxBet MONEY, MPM MONEY)

INSERT INTO @tmpBetSetting(currency,MinBet,MaxBet,MPM)
SELECT 	13	,	10	,	5000	,	20000	--	RMB
UNION SELECT 	6	,	1	,	500	,	2500	--	EURO
UNION SELECT 	12	,	1	,	500	,	2500	--	GBP
UNION SELECT 	5	,	10	,	5000	,	20000	--	HK$
UNION SELECT 	67	,	2	,	2500	,	10000	--	HKK
UNION SELECT 	47	,	18	,	8000	,	40000	--	DDD
UNION SELECT 	22	,	18	,	8000	,	40000	--	IND
UNION SELECT 	33	,	18	,	8000	,	40000	--	IDD
UNION SELECT 	34	,	18	,	8000	,	40000	--	IDR
UNION SELECT 	15	,	18	,	8000	,	40000	--	IN
UNION SELECT 	10	,	20	,	20000	,	100000	--	INR1
UNION SELECT 	45	,	10000	,	800000	,	4000000	--	Won
UNION SELECT 	69	,	2	,	1000	,	5000	--	MMK
UNION SELECT 	2	,	2	,	2500	,	10000	--	RM
UNION SELECT 	43	,	20	,	20000	,	100000	--	THB
UNION SELECT 	35	,	2	,	1000	,	5000	--	$US
UNION SELECT 	3	,	2	,	1000	,	5000	--	US$
UNION SELECT 	16	,	2	,	1000	,	5000	--	Yen
UNION SELECT 	64	,	2	,	1000	,	5000	--	UT

INSERT INTO #Supers(custid,currency)
SELECT ci.custid , ci.currency
FROM customer c WITH(NOLOCK)
	INNER JOIN custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site	
WHERE ci.roleid = 4
	AND ci.Enabled = 1
	AND s.isLicensee = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))	
	AND ci.currency IN (SELECT currency FROM @tmpBetSetting)	 
	
SELECT @super_cnt = @@ROWCOUNT

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@currency = currency
		,@srecommend = custid		
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SELECT @MinBet = MinBet,
		@MaxBet = MaxBet,
		@MPM = MPM
	FROM @tmpBetSetting
	WHERE currency =@currency
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_DynamicCustSetting3rd_09] 
			@srecommend = @srecommend, 
			@MinBet = @MinBet,
			@MaxBet = @MaxBet,
			@MPM = @MPM,			
			@target = @target,
			@MaxCustID = @MaxCustID			
				
	--WAITFOR DELAY '00:00:00.280'			
END		
GO	
-- END STEP 2: Run this SP at replicated DB & DBCUST -----
-----------------------------------------------------------------------------------
	  