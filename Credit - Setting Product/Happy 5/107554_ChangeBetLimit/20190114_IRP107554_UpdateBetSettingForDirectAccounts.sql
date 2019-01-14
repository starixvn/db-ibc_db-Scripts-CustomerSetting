/*
	Created: Johnson
	Date: 2019-01-14
	Task: Adjust bet setting for Happy 5 for direct accounts
	DB: DBCUST/CUSTDB
*/

CREATE TABLE #supers (custid INT, currency INT, code VARCHAR(20), MinBet MONEY, MaxBet Money, MaxPerMatch MONEY, isfinished BIT DEFAULT(0))

DECLARE @max_custid INT, @srecommend INT
SELECT  @max_custid= xxx ---input maxcustid

INSERT INTO #supers(custid,currency, code)
SELECT ci.custid, ci.currency,e.code
FROM customer ci WITH (NOLOCK) 
	INNER JOIN dbo.exchange e WITH(NOLOCK) ON ci.currency = e.exchangeid
	INNER JOIN dbo.site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN dbo.custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))
	AND ci.custid NOT IN (SELECT custid 
							FROM custinfo (NOLOCK)
							WHERE custid IN (SELECT custid 
											FROM dbo.custaccount WITH (NOLOCK)
											WHERE groupid IN (60,515))--ETUS,ZU01 headline								
						)
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

CREATE TABLE #DirectAccounts (custID INT, roleid TINYINT, srecommend INT, mrecommend INT, recommend INT)

--3k customers affected
INSERT INTO #DirectAccounts
SELECT ci.custid, ci.roleid, ci.srecommend, ci.mrecommend, ci.recommend
FROM CustDirectAccount ca WITH(NOLOCK)
	INNER JOIN custinfo ci WITH(NOLOCK) ON ca.custid = ci.custid
	INNER JOIN customer c WITH (NOLOCK) ON ca.custid = c.custid
WHERE ci.srecommend IN (SELECT custid FROM #supers)
	AND ci.roleid IN (2,3)	
	AND ci.Enabled = 1
	AND ci.maxpermatch164 NOT IN (0, 0.1)
	AND c.site NOT IN ('KORIBC','INDO')
	--Direct accounts under group headlines ETUS, ZU01
	AND ci.custid NOT IN (1283	,--	etus
						3472	,--	ETCASINO
						5106	,--	VT1US
						7714	,--	etrmb
						525344	,--	ET1RMB
						2440619	,--	SELLUSD
						11771775	,--	THA1US
						12055986	,--	D-THAUS
						15546129	,--	ETprovision
						22392814	,--	AEK
						24336740	--	MEK
						)

INSERT INTO #DirectAccounts
SELECT ci.custid, ci.roleid, ci.srecommend, ci.mrecommend, ci.recommend
FROM CustDirectAccount ca WITH(NOLOCK)
	INNER JOIN custinfo ci WITH(NOLOCK) ON ca.custid = ci.custid
	INNER JOIN customer c WITH (NOLOCK) ON ci.recommend = c.custid
WHERE ci.srecommend IN (SELECT custid FROM #supers)
	AND ci.roleid = 1
	AND ci.Enabled = 1
	AND ci.maxpermatch164 NOT IN (0, 0.1)
	AND c.site NOT IN ('KORIBC','INDO')
	--Direct accounts under group headlines ETUS, ZU01
	AND ci.custid NOT IN (1283	,--	etus
						3472	,--	ETCASINO
						5106	,--	VT1US
						7714	,--	etrmb
						525344	,--	ET1RMB
						2440619	,--	SELLUSD
						11771775	,--	THA1US
						12055986	,--	D-THAUS
						15546129	,--	ETprovision
						22392814	,--	AEK
						24336740	--	MEK
						)
						
--Adjust bet settings by global settings 
UPDATE ci
SET ci.maxpermatch164 = s.maxpermatch
FROM custInfo ci WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #supers s ON ci.srecommend = s.custid
WHERE ci.custid IN (
		--direct accounts	
		SELECT custid FROM #DirectAccounts
		--dummy masters
		UNION SELECT mrecommend FROM #DirectAccounts WHERE roleid IN (1,2)
		--dummy agents				
		UNION SELECT recommend FROM #DirectAccounts WHERE roleid = 1
	)
					
UPDATE cs
SET cs.minbet = s.minbet,
	cs.maxbet = s.maxbet
FROM custInfo ci WITH(NOLOCK)	
	INNER JOIN #supers s ON ci.srecommend = s.custid
	INNER JOIN custsetting3rd cs WITH(UPDLOCK,ROWLOCK) ON cs.custid = ci.custid	
														AND cs.sporttype = 164
														AND cs.bettype = 8101
WHERE ci.custid IN (
		--direct accounts	
		SELECT custid FROM #DirectAccounts
		--dummy masters
		UNION SELECT mrecommend FROM #DirectAccounts WHERE roleid IN (1,2)
		--dummy agents				
		UNION SELECT recommend FROM #DirectAccounts WHERE roleid = 1
	)
					
			
	