--PhoneBetting
CREATE TABLE #PhoneBetting(mrecommend INT, recommend INT)

--115 rows affected
INSERT INTO #PhoneBetting(mrecommend,recommend)	
SELECT DISTINCT mrecommend,recommend
FROM dbo.PhoneBettingCustomerList p WITH(NOLOCK)
	INNER JOIN customer c WITH(NOLOCK) ON p.username = c.username
	
-- get dummy super list
SELECT DISTINCT srecommend custid 
INTO #dummySuper
FROM CustDirectAccount da WITH (NOLOCK)
     INNER JOIN customer ci WITH(NOLOCK) ON da.CustID = ci.custid	 
WHERE  ci.roleid IN (1, 2, 3) 	
	AND ci.site IN ('BEST-ODDS','INDO','IBCIndo','611111','733333','755555','222223','7aa666','KORIBC','722222','XYZBet','76666B')				
	AND srecommend NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	
--Get supers normal
SELECT DISTINCT ci.custid AS Super
FROM customer ci WITH (NOLOCK) 
	INNER JOIN custinfo cu with (nolock) on cu.custid=ci.custid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site	
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid		
WHERE ci.roleid = 4 
	AND ci.site IN ('BEST-ODDS','INDO','IBCIndo','611111','733333','755555','222223','7aa666','KORIBC','722222','XYZBet','76666B')	
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND ci.custid NOT IN (SELECT custid FROM #dummySuper)
	AND cu.Enabled = 1
	AND s.islicensee = 0	
	AND cs.IsInternal=0
	AND ci.custid>=100
	AND ci.username not like '3rdSuper%'   
--Direct masters exclude who has  phone betting	members

	SELECT DISTINCT ci.custid As DirectMaster
	FROM customer ci with(nolock)
		INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid				
	WHERE EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		AND ci.roleid=3 
		AND ci.site IN ('BEST-ODDS','INDO','IBCIndo','611111','733333','755555','222223','7aa666','KORIBC','722222','XYZBet','76666B')		
		AND c.Enabled=1				
		AND c.custid NOT IN (SELECT mrecommend FROM #PhoneBetting)		
	
--Direct agents exclude who has  phone betting	members
	SELECT DISTINCT ci.custid AS DirectAgent
	FROM customer ci WITH(NOLOCK)
		INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid				
	WHERE  EXISTS (SELECT custid FROM dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		AND ci.roleid = 2 
		AND ci.site IN ('BEST-ODDS','INDO','IBCIndo','611111','733333','755555','222223','7aa666','KORIBC','722222','XYZBet','76666B')		
		AND c.Enabled=1		
		AND c.custid NOT IN (SELECT recommend FROM #PhoneBetting)

		DROP TABLE #PhoneBetting
		DROP TABLE #dummySuper
