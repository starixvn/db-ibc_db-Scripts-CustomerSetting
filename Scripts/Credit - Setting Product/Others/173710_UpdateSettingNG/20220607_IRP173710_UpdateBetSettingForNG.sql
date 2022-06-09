/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20220530@Johnson
	Task:  update bet settings for Number Game/Happy 5 for credit customers
	DB: DBCUST/CustDB
*/
-- BEGIN STEP 1: Deploy this SP at DBCUST.CustDB
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
	@srecommend INT,
	@currency INT,
	@target VARCHAR(20)	
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN		
	IF dbo.f_CheckRepTable('CustBetSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting_Member') = 0 RETURN
	
	CREATE TABLE #tblCust (custid INT, sporttype INT PRIMARY KEY(custid,sporttype))	
	DECLARE @tmpSetting TABLE(Sporttype INT, currency INT, MinBet MONEY, MaxBet MONEY, MaxPerMatch MONEY, MaxPerNumber MONEY)
	
	INSERT INTO @tmpSetting(Sporttype , currency, MinBet, MaxBet, MaxPerMatch, MaxPerNumber)
	SELECT 	161	,	47	,	10	,	5000	,	50000	,	25000	--	DDD
	UNION ALL SELECT 	161	,	33	,	10	,	5000	,	50000	,	25000	--	IDD
	UNION ALL SELECT 	161	,	34	,	10	,	5000	,	50000	,	25000	--	IDR
	UNION ALL SELECT 	161	,	15	,	10	,	5000	,	50000	,	25000	--	IN
	UNION ALL SELECT 	161	,	22	,	10	,	5000	,	50000	,	25000	--	IND
	UNION ALL SELECT 	161	,	5	,	11	,	1500	,	15000	,	7500	--	HK$
	UNION ALL SELECT 	161	,	67	,	5	,	1500	,	15000	,	7500	--	HKK
	UNION ALL SELECT 	161	,	10	,	60	,	15000	,	150000	,	75000	--	INR1
	UNION ALL SELECT 	161	,	69	,	2	,	1000	,	10000	,	5000	--	MMK
	UNION ALL SELECT 	161	,	2	,	5	,	1500	,	15000	,	7500	--	RM
	UNION ALL SELECT 	161	,	13	,	11	,	1500	,	15000	,	7500	--	RMB
	UNION ALL SELECT 	161	,	43	,	60	,	15000	,	150000	,	75000	--	THB
	UNION ALL SELECT 	161	,	64	,	2	,	1000	,	10000	,	5000	--	UT
	UNION ALL SELECT 	161	,	45	,	2751	,	500000	,	5000000	,	2500000	--	Won
	UNION ALL SELECT 	161	,	16	,	2	,	1000	,	10000	,	5000	--	Yen
	UNION ALL SELECT 	161	,	6	,	2	,	1000	,	10000	,	5000	--	EURO
	UNION ALL SELECT 	161	,	12	,	1	,	500	,	5000	,	2500	--	GBP
	UNION ALL SELECT 	161	,	35	,	2	,	1000	,	10000	,	5000	--	$US
	UNION ALL SELECT 	161	,	3	,	2	,	1000	,	10000	,	5000	--	US$
	
	UNION ALL SELECT 	164	,	45	,	2751	,	500000	,	2000000	,	0	--	Won
	UNION ALL SELECT 	164	,	43	,	60	,	10000	,	40000	,	0	--	THB
	UNION ALL SELECT 	164	,	10	,	60	,	10000	,	40000	,	0	--	INR1
	UNION ALL SELECT 	164	,	47	,	10	,	5000	,	20000	,	0	--	DDD
	UNION ALL SELECT 	164	,	33	,	10	,	5000	,	20000	,	0	--	IDD
	UNION ALL SELECT 	164	,	34	,	10	,	5000	,	20000	,	0	--	IDR
	UNION ALL SELECT 	164	,	15	,	10	,	5000	,	20000	,	0	--	IN
	UNION ALL SELECT 	164	,	22	,	10	,	5000	,	20000	,	0	--	IND
	UNION ALL SELECT 	164	,	67	,	5	,	1000	,	4000	,	0	--	HKK
	UNION ALL SELECT 	164	,	2	,	5	,	1000	,	4000	,	0	--	RM
	UNION ALL SELECT 	164	,	64	,	2	,	1000	,	4000	,	0	--	UT
	UNION ALL SELECT 	164	,	16	,	2	,	1000	,	4000	,	0	--	Yen
	UNION ALL SELECT 	164	,	5	,	11	,	1000	,	4000	,	0	--	HK$
	UNION ALL SELECT 	164	,	69	,	2	,	1000	,	4000	,	0	--	MMK
	UNION ALL SELECT 	164	,	13	,	11	,	1000	,	4000	,	0	--	RMB
	UNION ALL SELECT 	164	,	6	,	2	,	1000	,	4000	,	0	--	EURO
	UNION ALL SELECT 	164	,	12	,	1	,	500	,	2000	,	0	--	GBP
	UNION ALL SELECT 	164	,	35	,	2	,	1000	,	4000	,	0	--	$US
	UNION ALL SELECT 	164	,	3	,	2	,	1000	,	4000	,	0	--	US$
	
	DELETE @tmpSetting WHERE currency <> @currency
	
	INSERT INTO #tblCust(custid, sporttype)
	SELECT cs.custid, cs.sporttype 
	FROM CustBetSetting_Agent cs WITH(NOLOCK)
		INNER JOIN custinfo ci WITH(NOLOCK) ON cs.custid = ci.custid
		INNER JOIN @tmpSetting t ON cs.sporttype = t.sporttype AND t.currency = ci.currency
	WHERE cs.sporttype IN (161,164)
		AND ci.srecommend = @srecommend
		AND ci.roleid IN (2,3,4)
		AND ci.enabled = 1
		AND ((cs.MinBet < t.MinBet OR cs.MaxBet > t.MaxBet OR cs.MaxPerMatch > t.MaxPerMatch)
			OR (cs.sporttype = 161 AND cs.MaxPerNumber > t.MaxPerNumber)
			)
		AND cs.MaxBet >= 1 AND cs.MaxPerMatch >= 1 
		AND 1 = CASE WHEN cs.sporttype = 161 AND cs.MaxPerNumber < 1 THEN 0 ELSE 1 END
	
	DECLARE @MinBet MONEY,
			@MaxBet MONEY,
			@MaxPerMatch MONEY,
			@MaxPerNumber MONEY,
			@MaxBet2 MONEY,
			@MaxPerMatch2 MONEY,
			@MaxPerNumber2 MONEY
			
	UPDATE cs
	SET @minbet = CASE WHEN cs.MinBet < t.MinBet THEN t.minbet 
						WHEN cs.MinBet > t.MaxBet THEN t.maxbet 
						ELSE cs.minbet END,
		@maxbet = CASE WHEN cs.MaxBet > t.MaxBet THEN t.MaxBet ELSE cs.maxbet END,
		@maxpermatch = CASE WHEN cs.MaxPerMatch > t.MaxPerMatch THEN t.MaxPerMatch ELSE cs.maxpermatch END,
		@MaxPerNumber = CASE WHEN cs.sporttype = 161 AND cs.MaxPerNumber > t.MaxPerNumber THEN t.MaxPerNumber ELSE cs.MaxPerNumber END,
		@maxbet2 = CASE WHEN @maxbet < @minbet THEN @minbet ELSE @maxbet END,
		@MaxPerNumber2 = CASE WHEN cs.sporttype = 161 AND @MaxPerNumber < @maxbet2 THEN @maxbet2 ELSE @MaxPerNumber END,
		@maxpermatch2 = CASE WHEN cs.sporttype = 161 AND @maxpermatch < @MaxPerNumber2 THEN @MaxPerNumber2
							WHEN cs.sporttype = 164 AND @maxpermatch < @MaxBet2 THEN @MaxBet2
							ELSE @maxpermatch END,							
		cs.minbet = @minbet,
		cs.maxbet = @maxbet2,
		cs.maxpermatch = @maxpermatch2,
		cs.MaxPerNumber = @MaxPerNumber2
	FROM CustBetSetting_Agent cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tblCust c WITH(NOLOCK) ON cs.custid = c.custid AND cs.sporttype = c.sporttype
		INNER JOIN @tmpSetting t ON cs.sporttype = t.sporttype
		
	DELETE #tblCust
	
	INSERT INTO #tblCust(custid, sporttype)
	SELECT cs.custid, cs.sporttype 
	FROM CustBetSetting_Member cs WITH(NOLOCK)
		INNER JOIN custinfo ci WITH(NOLOCK) ON cs.custid = ci.custid
		INNER JOIN @tmpSetting t ON cs.sporttype = t.sporttype AND t.currency = ci.currency
	WHERE cs.sporttype IN (161,164)
		AND ci.srecommend = @srecommend
		AND ci.roleid IN (1)
		AND ci.enabled = 1
		AND ((cs.MinBet < t.MinBet OR cs.MaxBet > t.MaxBet OR cs.MaxPerMatch > t.MaxPerMatch)
			OR (cs.sporttype = 161 AND cs.MaxPerNumber > t.MaxPerNumber)
			)
		AND cs.MaxBet >= 1 AND cs.MaxPerMatch >= 1 
		AND 1 = CASE WHEN cs.sporttype = 161 AND cs.MaxPerNumber < 1 THEN 0 ELSE 1 END
		
	UPDATE cs
	SET @minbet = CASE WHEN cs.MinBet < t.MinBet THEN t.minbet 
						WHEN cs.MinBet > t.MaxBet THEN t.maxbet 
						ELSE cs.minbet END,
		@maxbet = CASE WHEN cs.MaxBet > t.MaxBet THEN t.MaxBet ELSE cs.maxbet END,
		@maxpermatch = CASE WHEN cs.MaxPerMatch > t.MaxPerMatch THEN t.MaxPerMatch ELSE cs.maxpermatch END,
		@MaxPerNumber = CASE WHEN cs.sporttype = 161 AND cs.MaxPerNumber > t.MaxPerNumber THEN t.MaxPerNumber ELSE cs.MaxPerNumber END,
		
		@maxbet2 = CASE WHEN @maxbet < @minbet THEN @minbet ELSE @maxbet END,
		@MaxPerNumber2 = CASE WHEN cs.sporttype = 161 AND @MaxPerNumber < @maxbet2 THEN @maxbet2 ELSE @MaxPerNumber END,
		@maxpermatch2 = CASE WHEN cs.sporttype = 161 AND @maxpermatch < @MaxPerNumber2 THEN @MaxPerNumber2
							WHEN cs.sporttype = 164 AND @maxpermatch < @MaxBet2 THEN @MaxBet2
							ELSE @maxpermatch END,							
		cs.minbet = @minbet,
		cs.maxbet = @maxbet2,
		cs.maxpermatch = @maxpermatch2,
		cs.MaxPerNumber = @MaxPerNumber2						
	FROM CustBetSetting_Member cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tblCust c WITH(NOLOCK) ON cs.custid = c.custid AND cs.sporttype = c.sporttype
		INNER JOIN @tmpSetting t ON cs.sporttype = t.sporttype
	
	DROP TABLE #tblCust	
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

DECLARE @srecommend INT,		
		@currency INT,		
		@super_cnt INT, 
		@index INT = 0
		
CREATE TABLE #Supers(CustID INT, currency INT, isfinished BIT DEFAULT(0))

INSERT INTO #Supers(custid,currency)
SELECT ci.custid , ci.currency
FROM customer ci WITH(NOLOCK) 
	INNER JOIN custinfo c WITH(NOLOCK) ON ci.custid = c.custid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site		
WHERE ci.roleid = 4
	AND s.isLicensee = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND ci.custid NOT IN (SELECT DISTINCT srecommend 
						FROM customer WITH(NOLOCK)
						WHERE username IN (SELECT username 
											FROM PhoneBettingCustomerList WITH(NOLOCK)
										)
						)
	AND NOT EXISTS (SELECT 1 FROM CustSuper s WITH(NOLOCK) WHERE ci.custid = s.custid AND isInternal = 1)					
	AND c.enabled = 1
	AND ci.currency IN (2,5,6,10,12,13,15,16,22,33,34,43,45,47,64,67,69,3,35)
	AND ci.username NOT LIKE '3rdSuper%'   
	
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
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_CustSetting3rd_19] 
			@srecommend = @srecommend, 
			@currency = @currency,
			@target = @target	
				
	WAITFOR DELAY '00:00:00.280'			
END		
GO	
-- END STEP 2: Run this SP at replicated DB & DBCUST -----
-----------------------------------------------------------------------------------