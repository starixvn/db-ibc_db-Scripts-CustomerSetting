/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20230104@Johnson
	Task:  RNG Keno/RNG Lottery/Table Game/Sports Lottery - Adjust bet limit for Credit market [redmine: #182389]
	DB: DBCUST/CustDB
*/
DECLARE @MaxCustID INT = xxx
	
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

CREATE TABLE #tblCust (custid INT PRIMARY KEY, roleid TINYINT, currency INT, isFinished BIT DEFAULT(0))
DECLARE @tmpCustHistory TABLE(custid INT, sporttype SMALLINT, bettype SMALLINT, MaxBet MONEY, MPM MONEY PRIMARY KEY(custid,sporttype,bettype))
DECLARE @tmpCust TABLE(custid INT PRIMARY KEY, currency INT)
DECLARE @tmpGameType TABLE (GameTypeID INT, Bettype SMALLINT)	
DECLARE @NewMinBet MONEY,@NewMaxBet MONEY,@NewMPM MONEY

INSERT INTO #tblCust(custid,roleid,currency)
SELECT custid,roleid,currency
FROM custinfo c WITH(NOLOCK)
WHERE c.srecommend IN (SELECT custid FROM #supers)	
	AND c.enabled = 1
	AND custid > @MaxCustID

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
	OUTPUT DELETED.custid,DELETED.currency INTO @tmpCust(custid,currency)
	FROM #tblCust t
	WHERE isFinished = 0
		AND roleid > 1
	
	IF @@ROWCOUNT = 0
		BREAK;
		
	UPDATE cs
	SET @NewMinBet = CASE WHEN cs.MinBet < s.MinBet THEN s.MinBet ELSE cs.MinBet END,
		@NewMaxBet = CASE WHEN cs.MaxBet > s.MaxBet THEN s.MaxBet ELSE cs.MaxBet END,
		@NewMPM = CASE WHEN cs.MaxPerGameType > s.MPM THEN s.MPM ELSE cs.MaxPerGameType END,
		@NewMaxBet = CASE WHEN @NewMPM < @NewMaxBet THEN @NewMPM ELSE @NewMaxBet END,	
		@NewMinBet = CASE WHEN @NewMaxBet < @NewMinBet THEN @NewMaxBet ELSE @NewMinBet END,	
		cs.MinBet = @NewMinBet,
		cs.MaxBet = @NewMaxBet,
		cs.MaxPerGameType = @NewMPM
	FROM CustGameType cs WITH(UPDLOCK,ROWLOCK)	
		INNER JOIN @tmpCust t ON cs.custid = t.custid
		INNER JOIN @tmpBetSetting s ON t.currency = s.currency
	WHERE cs.GameTypeID BETWEEN 1 AND 31
		AND cs.MaxBet >= 1 AND cs.MaxPerGameType >= 1
		AND (cs.MaxBet > s.MaxBet OR cs.MaxPerGameType > s.MPM OR cs.MinBet < s.MinBet)
	
	UPDATE cs
	SET @NewMinBet = CASE WHEN cs.MinBet < s.MinBet THEN s.MinBet ELSE cs.MinBet END,
		@NewMaxBet = CASE WHEN cs.MaxBet > s.MaxBet THEN s.MaxBet ELSE cs.MaxBet END,
		@NewMPM = CASE WHEN cs.MaxPerMatch > s.MPM THEN s.MPM ELSE cs.MaxPerMatch END,
		@NewMaxBet = CASE WHEN @NewMPM < @NewMaxBet THEN @NewMPM ELSE @NewMaxBet END,	
		@NewMinBet = CASE WHEN @NewMaxBet < @NewMinBet THEN @NewMaxBet ELSE @NewMinBet END,	
		cs.MinBet = @NewMinBet,
		cs.MaxBet = @NewMaxBet,
		cs.MaxPerMatch = @NewMPM
	FROM CustBetSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN @tmpCust t ON cs.custid = t.custid
		INNER JOIN @tmpBetSetting s ON t.currency = s.currency
	WHERE cs.SportType in (169,220,222)
		AND cs.MaxBet >= 1 AND cs.MaxPerMatch >= 1
		AND (cs.MaxBet > s.MaxBet OR cs.MaxPerMatch > s.MPM OR cs.MinBet < s.MinBet)
				
	DELETE @tmpCust			
END	

WHILE(1=1)
BEGIN
	UPDATE TOP (300) t
	SET isFinished = 1
	OUTPUT DELETED.custid,DELETED.currency INTO @tmpCust(custid,currency)
	FROM #tblCust t
	WHERE isFinished = 0
		AND roleid = 1
	
	IF @@ROWCOUNT = 0
		BREAK;
	
	--RnG Keno
	UPDATE cs
	SET @NewMinBet = CASE WHEN cs.MinBet < s.MinBet THEN s.MinBet ELSE cs.MinBet END,
		@NewMaxBet = CASE WHEN cs.MaxBet > s.MaxBet THEN s.MaxBet ELSE cs.MaxBet END,
		@NewMPM = CASE WHEN cs.MaxPerGameType > s.MPM THEN s.MPM ELSE cs.MaxPerGameType END,
		@NewMaxBet = CASE WHEN @NewMPM < @NewMaxBet THEN @NewMPM ELSE @NewMaxBet END,	
		@NewMinBet = CASE WHEN @NewMaxBet < @NewMinBet THEN @NewMaxBet ELSE @NewMinBet END,	
		cs.MinBet = @NewMinBet,
		cs.MaxBet = @NewMaxBet,
		cs.MaxPerGameType = @NewMPM
	OUTPUT DELETED.custid, 202, DELETED.GameTypeID, DELETED.MaxBet, DELETED.MaxPerGameType
	INTO @tmpCustHistory(custid,sporttype,bettype,maxbet,MPM)
	FROM CustGameType cs WITH(UPDLOCK,ROWLOCK)			
		INNER JOIN @tmpCust t ON cs.custid = t.custid
		INNER JOIN @tmpBetSetting s ON t.currency = s.currency
	WHERE cs.GameTypeID BETWEEN 1 AND 31
		AND cs.MaxBet >= 1 AND cs.MaxPerGameType >= 1
		AND (cs.MaxBet > s.MaxBet OR cs.MaxPerGameType > s.MPM OR cs.MinBet < s.MinBet)
	
	DELETE cs
	FROM @tmpCustHistory cs
		INNER JOIN @tmpCust t ON cs.custid = t.custid
		INNER JOIN @tmpBetSetting s ON t.currency = s.currency
	WHERE cs.MaxBet = s.MaxBet AND cs.MPM = s.MPM
		
	INSERT INTO CustMaxBetSetting_History 
		(CustID, SportType, BetType, OldMaxBet, OldMaxPerMatch, OldStakeLevelList, UpdateTime)
	SELECT CustID, SportType, g.BetType, MaxBet, MPM, NULL StakeLevelList, GETDATE() as UpdateTime
	FROM @tmpCustHistory c
		INNER JOIN @tmpGameType g ON c.Bettype = g.GameTypeID
		
	DELETE @tmpCustHistory
	
	--Lottery
	UPDATE cs
	SET @NewMinBet = CASE WHEN cs.MinBet < s.MinBet THEN s.MinBet ELSE cs.MinBet END,
		@NewMaxBet = CASE WHEN cs.MaxBet > s.MaxBet THEN s.MaxBet ELSE cs.MaxBet END,
		@NewMPM = CASE WHEN cs.MaxPerMatch > s.MPM THEN s.MPM ELSE cs.MaxPerMatch END,
		@NewMaxBet = CASE WHEN @NewMPM < @NewMaxBet THEN @NewMPM ELSE @NewMaxBet END,	
		@NewMinBet = CASE WHEN @NewMaxBet < @NewMinBet THEN @NewMaxBet ELSE @NewMinBet END,	
		cs.MinBet = @NewMinBet,
		cs.MaxBet = @NewMaxBet,
		cs.MaxPerMatch = @NewMPM
	OUTPUT DELETED.custid, DELETED.sporttype, DELETED.bettype, DELETED.MaxBet, DELETED.MaxPerMatch
	INTO @tmpCustHistory(custid,sporttype,bettype,maxbet,MPM)
	FROM CustBetSetting3rd_Member cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN @tmpCust t ON cs.custid = t.custid
		INNER JOIN @tmpBetSetting s ON t.currency = s.currency
	WHERE cs.SportType in (169,220,222)
		AND cs.MaxBet >= 1 AND cs.MaxPerMatch >= 1
		AND (cs.MaxBet > s.MaxBet OR cs.MaxPerMatch > s.MPM OR cs.MinBet < s.MinBet)
			
	DELETE cs
	FROM @tmpCustHistory cs
		INNER JOIN @tmpCust t ON cs.custid = t.custid
		INNER JOIN @tmpBetSetting s ON t.currency = s.currency
	WHERE cs.MaxBet = s.MaxBet AND cs.MPM = s.MPM
	
	INSERT INTO CustMaxBetSetting_History 
		(CustID, SportType, BetType, OldMaxBet, OldMaxPerMatch, OldStakeLevelList, UpdateTime)
	SELECT CustID, SportType, BetType, MaxBet, MPM, NULL StakeLevelList, GETDATE() as UpdateTime
	FROM @tmpCustHistory c				
	
	DELETE @tmpCustHistory
	
	DELETE @tmpCust			
END	


DROP TABLE #tblCust
DROP TABLE #supers