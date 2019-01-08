/*
	Created: Johnson
	Date: 2019-01-07
	Task: change bet setting for Happy 5 for supers list request
	DB: DBCUST/CUSTDB
*/


CREATE TABLE #supers (custid INT, currency INT, code VARCHAR(20), MinBet MONEY, MaxBet Money, MaxPerMatch MONEY, isfinished BIT DEFAULT(0))

DECLARE @max_custid INT, @srecommend INT
SELECT  @max_custid= xxx ---input maxcustid

INSERT INTO #supers(custid,currency, code)
SELECT ci.custid, ci.currency,e.code
FROM customer ci WITH (NOLOCK) 
	INNER JOIN exchange e WITH(NOLOCK) ON ci.currency = e.exchangeid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	--dont get site KORIBC, INDO
	AND s.site NOT IN ('KORIBC','INDO')	
	AND ci.custid <= @max_custid
	
SELECT	'IDR'	 code,	18	MinBet,	36000	MaxBet,	360000 MaxPerMatch
INTO #tmpBetSetting
UNION SELECT	'USD'	,	2	,	2700	,	27000
UNION SELECT	'KRW'	,	2751	,	3000000	,	30000000
UNION SELECT	'HKD'	,	13	,	20000	,	200000
UNION SELECT	'THB'	,	60	,	90000	,	900000
UNION SELECT	'MYR'	,	10	,	12000	,	120000
UNION SELECT	'EUR'	,	1	,	2400	,	24000
UNION SELECT	'CNY'	,	11	,	20000	,	200000
UNION SELECT	'MMK'	,	2	,	3600	,	36000
UNION SELECT	'SGD'	,	3	,	4000	,	40000
UNION SELECT	'GBP'	,	2	,	2221	,	22206
UNION SELECT	'CAD'	,	1	,	1714	,	17143
UNION SELECT	'TWD'	,	75	,	89419	,	894188
UNION SELECT	'JPY'	,	265	,	317460	,	3174603
UNION SELECT	'PHP'	,	128	,	153257	,	1532567
UNION SELECT	'NZD'	,	4	,	4254	,	42537
 	

DELETE #Supers
WHERE code NOT IN (SELECT code FROM #tmpBetSetting)

	--exclude supers have maxpermatch = 0
DELETE s
FROM #supers s
	INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON ci.custid = s.custid 												
WHERE ci.maxpermatch164 = 0
	
--remove supers have maxbet = 0
DELETE s
FROM #supers s
	INNER JOIN dbo.custSetting3rd cs WITH(NOLOCK) ON cs.custid = s.custid 
													AND cs.sporttype = 164
													AND cs.bettype = 8101
WHERE cs.maxbet = 0

UPDATE s
SET s.MinBet = t.MinBet,
	s.MaxBet = t.MaxBet,
	s.MaxPerMatch = t.MaxPerMatch
FROM #supers s
	INNER JOIN #tmpBetSetting t ON s.code = t.code
WHERE s.currency <> 50 --exclude CAN currency
	
UPDATE s
SET s.MinBet = 3,
	s.MaxBet = 3901,
	s.MaxPerMatch = 39014
FROM #supers s
WHERE currency = 50--CurrenyName = CAN	

--check setting before update	
SELECT * 
FROM #supers 
WHERE MinBet IS NULL OR MaxBet IS NULL OR MaxPerMatch IS NULL	

--7k rows
SELECT COUNT(1) 
FROM #supers

DECLARE @tmpCust TABLE(CustID INT)
DECLARE @cnt INT = 0 


WHILE (1 = 1)
BEGIN
	DELETE @tmpCust
	
	UPDATE TOP (2000) s	
	SET isfinished = 1
	OUTPUT DELETED.custid INTO @tmpCust
	FROM #supers s
	WHERE isfinished = 0
	
	SELECT @cnt = @@ROWCOUNT
	
	IF @cnt = 0 BREAK
	
	UPDATE ci
	SET MaxPerMatch164 = s.MaxPerMatch
	FROM CustInfo ci WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #supers s ON ci.custid = s.custid
	WHERE s.custid IN (SELECT custid FROM @tmpCust)
	
	UPDATE cs
	SET MinBet = s.MinBet,
		MaxBet = s.MaxBet
	FROM custSetting3rd cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #supers s ON cs.custid = s.custid
								AND cs.sporttype = 164
								AND cs.bettype = 8101
	WHERE s.custid IN (SELECT custid FROM @tmpCust)
END

