/*
	Created: Johnson
	Date: 2019-01-16
	Task: adjust bet setting for Happy 5 for newly customers under 789y
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #supers (custid INT, currency INT, code VARCHAR(20),groupname varchar(20), MinBet MONEY, MaxBet Money, MaxPerMatch MONEY, isfinished BIT DEFAULT(0))

DECLARE @max_custid INT, @max_custid2 INT 
SELECT @max_custid = xx,--old maxcustid
	@max_custid2 =yy --new maxcustid
	
INSERT INTO #supers(custid,currency, code,groupname)
SELECT ci.custid, ci.currency,e.code, isnull(groupname,hl.username) 
FROM customer ci WITH (NOLOCK) 
	INNER JOIN dbo.exchange e WITH(NOLOCK) ON ci.currency = e.exchangeid
	INNER JOIN dbo.site s WITH (NOLOCK) ON ci.site = s.site	
	LEFT JOIN dbo.custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	LEFT JOIN custAccount ca (nolock) on ca.custid = ci.custid												
	LEFT JOIN (SELECT ca1.GroupID, ci1.username from custAccount ca1 (nolock)												
			INNER JOIN custinfo ci1(nolock) on ca1.custid = ci1.custid									
			WHERE ca1.IsGroupHeadLine =1									
		) hl ON ca.groupID = hl.GroupID	
	LEFT JOIN DBAGE.bodb_age.dbo.Acc_custgroup ac WITH(NOLOCK ) on ac.custid = ci.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))
	AND ci.custid  IN (SELECT custid 
						FROM dbo.custaccount WITH (NOLOCK)
						WHERE groupid IN (60,515)--ETUS,ZU01 headline								
						)
	AND ci.custid <= @max_custid					
	AND s.islicensee = 0	
	AND s.site = '789y'
	AND (ac.groupname in ('ACCYEN889') or hl.username = 'zu01')
	
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

CREATE TABLE #tblCust (CustID INT PRIMARY KEY)

INSERT INTO #tblCust(custid)
SELECT custid
FROM dbo.CustInfo WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM #Supers)
	AND custid > @max_custid
	
UPDATE ci
SET ci.maxpermatch164 = s.maxpermatch
FROM custinfo ci WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #supers s ON ci.srecommend = s.custid
WHERE ci.custid IN (select custid FROM #tblCust)	
	AND ci.maxpermatch164 NOT IN (0,0.1)
	AND ci.maxpermatch164 > s.maxpermatch
	
UPDATE cs
SET cs.MinBet = CASE WHEN cs.MinBet < s.minbet THEN s.minbet ELSE cs.MinBet END,
	cs.MaxBet = CASE WHEN cs.Maxbet > s.MaxBet THEN s.MaxBet ELSE cs.MaxBet END
FROM custinfo ci WITH(NOLOCK)
	INNER JOIN #supers s ON ci.srecommend = s.custid
	INNER JOIN custsetting3rd cs WITH(UPDLOCK,ROWLOCK) ON ci.custid = cs.custid
													AND sporttype = 164
													AND bettype = 8101
WHERE ci.custid IN (select custid FROM #tblCust)	
	AND ci.maxpermatch164 NOT IN (0,0.1)
	AND (cs.MinBet < s.Minbet OR cs.MaxBet > s.MaxBet)
	