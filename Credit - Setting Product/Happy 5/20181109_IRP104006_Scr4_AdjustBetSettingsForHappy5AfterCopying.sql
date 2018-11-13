/*
	Created: Johnson
	Date: 2018-11-09
	Task: adjust bet settings of Happy 5 after copying data
	DB: DBCUST/CUSTDB
*/

CREATE TABLE #supers (custid INT)

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4 
	AND ci.currency <> 20
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
GO
	
SELECT cs1.custid, cs1.sporttype, cs1.bettype, cs2.minbet,cs2.maxbet
INTO #tmpSetting
FROM custinfo ci WITH(NOLOCK) 
	INNER JOIN dbo.custsetting3rd cs1 WITH(NOLOCK) ON ci.custid = cs1.custid
	INNER JOIN dbo.custsetting3rd cs2 WITH(NOLOCK) ON cs1.custid = cs2.custid
													AND cs1.sporttype = 164 AND cs1.bettype = 8101
													AND cs2.sporttype = 161 AND cs2.bettype = 81
WHERE ci.srecommend IN (SELECT custid FROM #supers)
	AND (
		cs1.minbet <> cs2.minbet
		OR cs1.maxbet <> cs2.maxbet
		)
		
UPDATE cs
SET	cs1.minbet = t.minbet,
	cs1.maxbet = t.maxbet
FROM dbo.custsetting3rd cs WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #tmpSetting t ON cs.custid = t.custid 
								AND cs.sporttype = t.sporttype
								AND cs.bettype = t.bettype
GO

SELECT custid
INTO #tblCust
FROM CustInfo ci WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers)
	AND enabled = 1
	AND maxpermatch164 <> maxpermatch161
	
UPDATE ci
SET maxpermatch164 = maxpermatch161
FROM CustInfo ci WITH(UPDLOCK,ROWLOCK)
WHERE custid IN (SELECT custid FROM #tblCust)
	