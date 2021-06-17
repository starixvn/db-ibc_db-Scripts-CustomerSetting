/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20210617
	Task:  Update FOR new accounts
		for 789y, update setting for Virtual Sports (Inspired VS), Virtual Sports 2 (Betradar VS), Virtual Sports 3 (LeapGaming VS):
		1. If MaxperMatch > 10k --> adjust MaxPerMatch to 10k
		2. If Maxbet > 10k --> adjust Maxbet to 10k 
	RedmineID :[#147941]
	DB: DBCust/CustDB
*/
DECLARE @max_custid INT
SELECT @max_custid = xxx

CREATE TABLE #supers (custid int)

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid 
WHERE c.roleid = 4  
	AND s.islicensee = 0
	AND cs.isinternal = 0
	AND ci.username NOT LIKE '3rdSuper%'
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND ci.Enabled = 1
	AND c.site = '789y'

CREATE TABLE #SMATemp
(
	CustID INT
)
CREATE TABLE #SMATempUpdate
(
	CustID INT
)

CREATE TABLE #Membertemp
(
	CustID INT
)
CREATE TABLE #MembertempUpdate
(
	CustID INT
)

INSERT INTO #SMATemp (CustID)
SELECT custid
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers)
	AND roleid IN (2,3,4) 
	AND Enabled = 1 
	AND custid > @max_custid 

INSERT INTO #Membertemp (CustID)
SELECT custid
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers) 
	AND roleid = 1 
	AND Enabled = 1 
	AND custid > @max_custid 

WHILE 1 = 1
BEGIN
	TRUNCATE TABLE #SMATempUpdate

	DELETE TOP (700) #SMATemp 
	OUTPUT DELETED.CustID
	INTO #SMATempUpdate(CustID)

	IF @@ROWCOUNT=0
		BREAK

	--Agent Level      
	UPDATE bt
	SET bt.MaxPerMatch = CASE WHEN bt.MaxPerMatch > 10000 THEN 10000 ELSE bt.MaxPerMatch END,
		bt.MaxBet = CASE WHEN bt.MaxBet > 10000 THEN 10000 ELSE bt.MaxBet END,
		bt.MinBet = CASE WHEN bt.MinBet > 10000 THEN 10000 ELSE bt.MinBet END
	FROM CustBetSetting3rd_Agent bt WITH(ROWLOCK) 
		INNER JOIN  #SMATempUpdate ci WITH(NOLOCK) ON bt.CustID = ci.CustID
	WHERE bt.sporttype IN(180,181,182,183,184,185,186,190,191,192,193,199,231)
		AND (bt.MaxPerMatch > 10000 OR BT.MaxBet > 10000 OR bt.MinBet > 10000)
END

WHILE 1 = 1
BEGIN
	TRUNCATE TABLE #MembertempUpdate

	DELETE TOP (700) #Membertemp 
	OUTPUT DELETED.CustID
	INTO #MembertempUpdate(CustID)

	IF @@ROWCOUNT=0
		BREAK

	--Member Level      
	UPDATE bt
	SET bt.MaxPerMatch = CASE WHEN bt.MaxPerMatch > 10000 THEN 10000 ELSE bt.MaxPerMatch END,
		bt.MaxBet = CASE WHEN bt.MaxBet > 10000 THEN 10000 ELSE bt.MaxBet END,
		bt.MinBet = CASE WHEN bt.MinBet > 10000 THEN 10000 ELSE bt.MinBet END
	FROM CustBetSetting3rd_Member bt WITH(ROWLOCK) 
		INNER JOIN #MembertempUpdate ci WITH(NOLOCK) ON bt.CustID = ci.CustID
	WHERE bt.sporttype IN(180,181,182,183,184,185,186,190,191,192,193,199,231)
		AND (bt.MaxPerMatch > 10000 OR BT.MaxBet > 10000 OR bt.MinBet > 10000)
END

DROP TABLE #SMATemp
DROP TABLE #SMATempUpdate
DROP TABLE #MembertempUpdate
DROP TABLE #Membertemp
DROP TABLE #supers
