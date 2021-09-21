/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Johnson
	Date: 20210917
	Task: Funky Game - initial settings for newly customers
	DB: DBCust/CustDB
*/


CREATE TABLE #supers (custid int, StakeLevelList VARCHAR(10))

DECLARE @max_custid INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid,StakeLevelList)
SELECT ci.custid,CAST(l.StakeLevelID as VARCHAR(10))
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	INNER JOIN StakeLevel l WITH(NOLOCK) ON ci.currency = l.ExchangeID AND l.GameTypeID = 5500
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.currency IN (13	,--	RMB
						6	,--	EURO
						5	,--	HK$
						67	,--	HKK
						47	,--	DDD
						15	,--	IN
						22	,--	IND
						33	,--	IDD
						34	,--	IDR
						45	,--	Won
						69	,--	MMK
						2	,--	RM
						43	,--	THB
						16	,--	Yen
						64	,--	UT
						3	,--	US$
						35	,--	$US
						72	--	YNG
						)
		
CREATE TABLE #tblCust (custid INT PRIMARY KEY, StakeLevelList VARCHAR(10), roleid TINYINT)
DECLARE @tmpCust TABLE (custid INT PRIMARY KEY, StakeLevelList VARCHAR(10))

INSERT INTO #tblCust(custid, roleid, StakeLevelList)
SELECT ci.custid, ci.roleid, StakeLevelList
FROM custinfo ci WITH(NOLOCK)
	INNER JOIN #supers s ON ci.srecommend = s.custid
WHERE ci.custid > @maxcustid
	AND enabled = 1
	
WHILE (1=1)
BEGIN
	DELETE TOP (500) t
	OUTPUT DELETED.custid, DELETED.StakeLevelList INTO @tmpCust(custid, StakeLevelList)
	FROM #tblCust t
	WHERE roleid > 1 
	
	IF @@ROWCOUNT = 0
	BREAK;
	
	INSERT INTO CustStakeLevel_Agent(custid,SportType,BetType,StakeLevelList)
	SELECT t.custid, 224, 5500, t.StakeLevelList
	FROM @tmpCust t
		LEFT JOIN CustStakeLevel_Agent cs WITH(NOLOCK) ON t.custid = cs.custid 
														AND cs.sporttype = 224 
														AND bettype = 5500
	WHERE cs.custid IS NULL
	
	DELETE @tmpCust
	
	WAITFOR DELAY '0:0:1'
END

WHILE (1=1)
BEGIN
	DELETE TOP (500) t
	OUTPUT DELETED.custid, DELETED.StakeLevelList INTO @tmpCust(custid,StakeLevelList)
	FROM #tblCust t
	WHERE roleid = 1 
	
	IF @@ROWCOUNT = 0
	BREAK;
	
	INSERT INTO CustStakeLevel_Member(custid,SportType,BetType,StakeLevelList)
	SELECT t.custid, 224, 5500, t.StakeLevelList
	FROM @tmpCust t
		LEFT JOIN CustStakeLevel_Member cs WITH(NOLOCK) ON t.custid = cs.custid 
														AND cs.sporttype = 224 
														AND bettype = 5500
	WHERE cs.custid IS NULL
	
	DELETE @tmpCust
	
	WAITFOR DELAY '0:0:1'
END