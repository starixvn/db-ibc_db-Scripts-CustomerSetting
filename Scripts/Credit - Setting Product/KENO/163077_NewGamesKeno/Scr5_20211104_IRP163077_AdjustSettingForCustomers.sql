/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211025@Johnson
	Task: adjust settings for new games keno
	DB: DBCust/CustDB
*/


CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT (0))

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN custInfo C WITH (NOLOCK) ON C.custid = ci.custid	
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid	
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'	
	AND Enabled = 1	
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND ci.currency <> 20
	AND cs.isinternal = 0
	AND s.islicensee = 0
			