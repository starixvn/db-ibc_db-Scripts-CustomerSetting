/*
	Created: 20190710@Johnson
	Task: update suspendinfo for customer has different setting with dbcust
	DB: DB05/DBTP/DB04x...bodb02
*/

CREATE TABLE #Supers(CustID INT)

INSERT INTO #Supers(custid)
SELECT ci.custid 
FROM dbo.customer c WITH (Nolock) 
	INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
	INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
WHERE ci.roleid = 4
	AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))	
	AND ci.custid NOT IN (SELECT custid FROM dbo.CustSuper WITH(NOLOCK) WHERE isInternal = 1)
	AND ci.Enabled = 1
	AND s.islicensee = 0
	AND c.username NOT LIKE '3rdSuper%'
	and c.custid = 1176092
	
SELECT ci.custid
INTO #tblCust
FROM dbo.custinfo ci WITH(NOLOCK)
	INNER JOIN dbo.CustProductStatus cs WITH(NOLOCK) ON ci.custid = cs.custid
	INNER JOIN DBCUST.CustDB.dbo.CustProductStatus cs2 WITH(NOLOCK) ON ci.custid = cs2.custid 
WHERE ci.srecommend IN (SELECT custid FROM #supers)
	AND cs.suspendinfo <> cs2.suspendinfo
	

DECLARE @tmpCust TABLE (custid INT)
DECLARE @rowcount INT 

WHILE (1=1)
BEGIN
	DELETE @tmpCust
	
	DELETE TOP(5000) t
	OUTPUT DELETED.custid INTO @tmpCust
	FROM #tblCust t
	
	SELECT @rowcount = @@rowcount
	
	UPDATE cs
	SET cs.suspendinfo = cs2.suspendinfo
	FROM dbo.CustProductStatus cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN DBCUST.CustDB.dbo.CustProductStatus cs2 WITH(NOLOCK) ON cs.custid = cs2.custid 
	WHERE cs.custid IN (SELECT custid FROM @tmpCust)
		AND cs.suspendinfo <> cs2.suspendinfo
	
	IF @rowcount < 5000
		BREAK;
END	

