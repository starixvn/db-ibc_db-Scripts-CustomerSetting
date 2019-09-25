
/*
	Created: Winnie
	Date: 20190913
	Task: Delete redundant BMAIO settings 
	DB: DBCust/CustDB
*/
DECLARE @maxcustID INT = xxx

CREATE TABLE #supers (custid int)

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'	
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.currency<>20

DELETE cs
FROM [dbo].CustSetting cs WITH(UPDLOCK,ROWLOCK)
	INNER JOIN custInfo c WITH(NOLOCK) ON cs.custid=c.custid
WHERE cs.CustID > @maxcustID
	AND cs.Bettype = 9999
	AND cs.Sporttype = 99	
	AND c.srecommend IN (SELECT custid FROM #supers)
	
DELETE cs
FROM [dbo].custoverride cs WITH(UPDLOCK,ROWLOCK)
	INNER JOIN custInfo c WITH(NOLOCK) ON cs.custid=c.custid
WHERE cs.CustID > @maxcustID
	AND cs.Bettype = 9999
	AND cs.Sporttype = 99 	
	AND c.srecommend IN (SELECT custid FROM #supers)