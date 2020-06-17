/*
	Created: 20200617@Elodie
	Task: update MaxPT
	DB: DBCUST/CUSTDB
*/

DECLARE @tmpSite TABLE (site VARCHAR(30), currencyName VARCHAR(10), currency TINYINT)
CREATE TABLE #tblSMA(CustID INT, roleid TINYINT)

INSERT INTO @tmpSite(site,currencyName)
SELECT 'BEST-ODDS','EURO'
UNION SELECT 'BEST-ODDS','GBP'
UNION SELECT 'BEST-ODDS','HK$'
UNION SELECT 'BEST-ODDS','HKK'
UNION SELECT 'BEST-ODDS','RMB'
UNION SELECT 'BEST-ODDS','SD$'
UNION SELECT 'BEST-ODDS','US$'
UNION SELECT 'BEST-ODDS','YNG'
UNION SELECT '611111','RMB'
UNION SELECT '611111','HK$'
UNION SELECT 'KORIBC','Won'
UNION SELECT 'XYZBet','EURO'
UNION SELECT 'XYZBet','HK$'
UNION SELECT 'XYZBet','GBP'
UNION SELECT 'XYZBet','RMB'
UNION SELECT 'BEST-ODDS','RM'
UNION SELECT '733333','RM'
UNION SELECT '222223','RM'
UNION SELECT '722222','RM'
UNION SELECT 'XYZBet','RM'

UPDATE t
SET t.currency = e.exchangeid
FROM @tmpSite t
	INNER JOIN exchange e (NOLOCK) ON t.currencyName = e.currency

SELECT ci.custid, ci.username 
INTO #WrongDirectMaster
FROM dbo.CustDirectAccount ca WITH (NOLOCK)
	INNER JOIN dbo.vw_customer ci WITH (NOLOCK) ON ci.custid = ca.CustID
	INNER JOIN @tmpSite t ON ci.site = t.site AND ci.currency = t.currency
WHERE ci.srecommend NOT IN (SELECT custid FROM dbo.Acc_CustDirect cd WITH (NOLOCK))
	AND ci.roleid = 3					
	AND srecommend NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	
SELECT ci.custid, ci.username 
INTO #WrongDirectAgent
FROM dbo.CustDirectAccount ca WITH (NOLOCK)
	INNER JOIN dbo.vw_customer ci WITH (NOLOCK) ON ci.custid = ca.CustID
	INNER JOIN @tmpSite t ON ci.site = t.site AND ci.currency = t.currency
WHERE ci.mrecommend NOT IN (SELECT custid FROM dbo.Acc_CustDirect cd WITH (NOLOCK))
	AND ci.roleid = 2					
	AND srecommend NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	
SELECT ci.custid, ci.username 
INTO #WrongDirectMember
FROM dbo.CustDirectAccount ca WITH (NOLOCK)
	INNER JOIN dbo.vw_customer ci WITH (NOLOCK) ON ci.custid = ca.CustID
	INNER JOIN dbo.vw_customer agent WITH (NOLOCK) ON agent.custid = ci.recommend
	INNER JOIN @tmpSite t ON agent.site = t.site AND ci.currency = t.currency
WHERE ci.recommend NOT IN (SELECT custid FROM dbo.Acc_CustDirect cd WITH (NOLOCK))
	AND ci.roleid = 1					
	AND ci.srecommend NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	
-- get dummy super list
SELECT DISTINCT srecommend custid 
INTO #dummySuper
FROM CustDirectAccount da WITH (NOLOCK)
     INNER JOIN vw_customer ci WITH(NOLOCK) ON da.CustID = ci.custid
	 INNER JOIN @tmpSite t ON ci.site = t.site AND ci.currency = t.currency
WHERE  ci.roleid IN (2, 3) 	
	AND ci.custid NOT IN (SELECT custid FROM #WrongDirectMaster
						UNION  SELECT custid FROM #WrongDirectAgent )						
	AND srecommend NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
UNION
SELECT DISTINCT ci.srecommend
FROM CustDirectAccount da WITH (NOLOCK)
    INNER JOIN vw_customer ci WITH(NOLOCK) ON da.CustID = ci.custid    
	INNER JOIN dbo.vw_customer agent WITH (NOLOCK) ON agent.custid = ci.recommend
	INNER JOIN @tmpSite t ON agent.site = t.site AND ci.currency = t.currency
WHERE ci.roleid IN (1) 	
	AND ci.custid NOT IN (SELECT custid FROM #WrongDirectMember)
	AND ci.srecommend NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))

--PhoneBetting
CREATE TABLE #PhoneBetting(mrecommend INT, recommend INT)

--8069 rows affected
INSERT INTO #PhoneBetting(mrecommend,recommend)	
SELECT DISTINCT mrecommend,recommend
FROM dbo.PhoneBettingCustomerList p WITH(NOLOCK)
	INNER JOIN vw_Customer c WITH(NOLOCK) ON p.username = c.username
	
--Get supers normal/direct masters/direct agents
INSERT INTO #tblSMA(custid, roleid)
SELECT DISTINCT ci.custid, ci.roleid
FROM vw_customer ci WITH (NOLOCK) 
	INNER JOIN custinfo cu with (nolock) on cu.custid=ci.custid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN @tmpSite t ON ci.site = t.site AND ci.currency = t.currency
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid	
	INNER JOIN CustPTSetting3rd_Agent co2 WITH(NOLOCK) ON ci.custid = co2.custid	
WHERE ci.roleid = 4  	
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0	
	AND cs.IsInternal=0
	AND ci.custid>=100
	AND ci.custid not in (select custid from #dummySuper)
	AND ci.username not like '3rdSuper%'
    AND ci.username not IN ( 'STAFF')
    AND ci.username not like 'SuperTest%'
    AND ci.username not like 'STEST%'
    AND ci.username not like 'SIBC%'
    AND ci.username not like '%ACCSuper%'
	AND cu.closed=0 
	AND co2.sporttype IN (43,44) 
	AND co2.SuperPT = 88
--Direct masters exclude who has  phone betting	members
UNION ALL
	SELECT DISTINCT ci.custid, ci.roleid
	FROM vw_customer ci with(nolock)
		INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid		
		INNER JOIN @tmpSite t ON ci.site = t.site AND ci.currency = t.currency
		INNER JOIN CustPTSetting3rd_Agent co2 WITH(NOLOCK) ON ci.custid = co2.custid
	WHERE EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		AND ci.roleid=3 		
		AND ci.srecommend IN (SELECT custid FROM #dummySuper)
		AND c.Enabled=1
		AND c.closed=0 
		AND c.custid NOT IN (SELECT custid from #WrongDirectMaster)
		AND c.custid NOT IN (SELECT mrecommend FROM #PhoneBetting)
		AND co2.sporttype IN (43,44) 
		AND co2.MasterPT = 88
UNION ALL	
--Direct agents exclude who has  phone betting	members
	SELECT DISTINCT ci.custid, ci.roleid
	FROM vw_Customer ci WITH(NOLOCK)
		INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid		
		INNER JOIN @tmpSite t ON ci.site = t.site AND ci.currency = t.currency
		INNER JOIN CustPTSetting3rd_Agent co2 WITH(NOLOCK) ON ci.custid = co2.custid
	WHERE  EXISTS (SELECT custid FROM dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		AND ci.roleid = 2 		
		AND ci.srecommend IN (SELECT custid FROM #dummySuper)
		AND c.Enabled=1
		AND c.closed=0 
		AND c.custid NOT IN (SELECT custid FROM #WrongDirectAgent)
		AND c.custid NOT IN (SELECT recommend FROM #PhoneBetting)
		AND co2.sporttype IN (43,44) 
		AND co2.AgentPT = 88

DELETE #tblSMA WHERE custid IN (726582,13469206)--KAM,JARWRONG

UPDATE cs
SET MaxPT = 90
FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
	INNER JOIN custinfo ci WITH (NOLOCK) ON cs.custid = ci.custid
	INNER JOIN #tblSMA c ON ci.srecommend = c.custid
WHERE sporttype IN (43,44)
	AND MaxPT < 90
	AND c.roleid = 4
	AND ci.roleid IN (4)
		
UPDATE cs
SET MaxPT = 90
FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
	INNER JOIN custinfo ci WITH (NOLOCK) ON cs.custid = ci.custid
	INNER JOIN #tblSMA c ON ci.srecommend = c.custid
WHERE sporttype IN (43,44)
	AND MaxPT < 90
	AND c.roleid = 4
	AND ci.roleid IN (3)

UPDATE cs
SET MaxPT = 90
FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
	INNER JOIN custinfo ci WITH (NOLOCK) ON cs.custid = ci.custid
	INNER JOIN #tblSMA c ON ci.srecommend = c.custid
WHERE sporttype IN (43,44)
	AND MaxPT < 90
	AND c.roleid = 4
	AND ci.roleid IN (2)

UPDATE cs
SET MaxPT = 90
FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
	INNER JOIN custinfo ci WITH (NOLOCK) ON cs.custid = ci.custid
	INNER JOIN #tblSMA c ON ci.mrecommend = c.custid
WHERE sporttype IN (43,44)
	AND MaxPT < 90
	AND c.roleid = 3
	AND ci.roleid IN (2,3)

--UPDATE cs
--SET MaxPT = 90
--FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
--	INNER JOIN custinfo ci WITH (NOLOCK) ON cs.custid = ci.custid
--	INNER JOIN #tblSMA c ON ci.recommend = c.custid
--WHERE sporttype IN (43,44)
--	AND MaxPT < 90
--	AND c.roleid = 2
