/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20220725@Johnson
	Task:  update bet settings for Number Game/Happy 5 for supers [redmine: #174379]
	DB: DBCUST/CustDB
*/

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

		
CREATE TABLE #Supers(CustID INT, currency INT)
	
INSERT INTO #Supers(custid,currency)
SELECT ci.custid , ci.currency
FROM customer ci WITH(NOLOCK) 
	INNER JOIN custinfo c WITH(NOLOCK) ON ci.custid = c.custid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site		
WHERE ci.roleid = 4
	AND s.isLicensee = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))	
	AND NOT EXISTS (SELECT 1 FROM CustSuper s WITH(NOLOCK) WHERE ci.custid = s.custid AND isInternal = 1)					
	AND c.enabled = 1
	AND ci.currency IN (2,5,6,10,12,13,15,16,22,33,34,43,45,47,64,67,69,3,35)
	AND ci.username NOT LIKE '3rdSuper%'   

--update settings for supers only	
UPDATE cs
SET cs.MinBet = CASE WHEN cs.MinBet <> t.MinBet THEN t.MinBet ELSE cs.MinBet END,
	cs.MaxBet = CASE WHEN cs.MaxBet <> t.MaxBet THEN t.MaxBet ELSE cs.MaxBet END,
	cs.MaxPerMatch = CASE WHEN cs.MaxPerMatch <> t.MaxPerMatch THEN t.MaxPerMatch ELSE cs.MaxPerMatch END,
	cs.MaxPerNumber = CASE WHEN cs.sporttype = 161 AND cs.MaxPerNumber <> t.MaxPerNumber THEN t.MaxPerNumber ELSE cs.MaxPerNumber END
FROM CustBetSetting_Agent cs WITH(ROWLOCK)
	INNER JOIN #supers ci ON cs.custid = ci.custid
	INNER JOIN @tmpSetting t ON cs.sporttype = t.sporttype AND t.currency = ci.currency
WHERE cs.sporttype IN (161,164)	
	AND ((cs.MinBet <> t.MinBet OR cs.MaxBet <> t.MaxBet OR cs.MaxPerMatch <> t.MaxPerMatch)
		OR (cs.sporttype = 161 AND cs.MaxPerNumber <> t.MaxPerNumber)
		)
	AND cs.MaxBet >= 1 AND cs.MaxPerMatch >= 1 
	AND 1 = CASE WHEN cs.sporttype = 161 AND cs.MaxPerNumber < 1 THEN 0 ELSE 1 END
	