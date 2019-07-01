/*
	Created: 20190701@Johnson
	Task: update reject = 1 for customer has wrong setting
	DB: DB05/DBTP/DB04x...bodb02
*/

CREATE TABLE #Supers(CustID INT)

INSERT INTO #Supers(custid)
SELECT ci.custid 
FROM dbo.customer c WITH (Nolock) 
	INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
	INNER JOIN DBCUST.CUSTDB.dbo.site s WITH(NOLOCK) ON c.site = s.site
WHERE ci.roleid = 4
	AND ci.custid NOT IN (SELECT custid FROM DBCUST.CUSTDB.dbo.Dep_CustSuper WITH(NOLOCK))	
	AND ci.custid NOT IN (SELECT custid FROM DBCUST.CUSTDB.dbo.CustSuper WITH(NOLOCK) WHERE isInternal = 1)
	AND ci.Enabled = 1
	AND s.islicensee = 0
	AND c.username NOT LIKE '3rdSuper%'
	
SELECT ci.custid
INTO #tblCust
FROM dbo.custinfo ci WITH(NOLOCK)
	INNER JOIN DBCUST.CustDB.dbo.Custinfo c2 WITH(NOLOCK) ON ci.custid = c2.custid 
WHERE ci.srecommend IN (SELECT custid FROM #supers)
	AND ci.reject <> c2.reject
	

DECLARE @tmpCust TABLE (custid INT)
DECLARE @rowcount INT 

WHILE (1=1)
BEGIN
	DELETE @tmpCust
	
	DELETE TOP(5000) t
	OUTPUT DELETED.custid INTO @tmpCust
	FROM #tblCust t
	
	SELECT @rowcount = @@rowcount
	
	UPDATE ci
	SET ci.reject = c2.reject
	FROM custinfo ci WITH(UPDLOCK,ROWLOCK)
		INNER JOIN DBCUST.CustDB.dbo.Custinfo c2 WITH(NOLOCK) ON ci.custid = c2.custid 
	WHERE ci.custid IN (SELECT custid FROM @tmpCust)
		AND ci.reject <> c2.reject
	
	IF @rowcount < 5000
		BREAK;
END	

