/*
	Created: Eden
	Date: 2019/07/16
	Task: delete existing settings new keno games of real customers 
	DB: DBCUST/CUSTDB
*/	
CREATE TABLE #Supers(CustID INT, isfinished BIT DEFAULT(0))
						
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
	AND ci.currency <> 20 -- Exclude UUS
	AND c.username NOT LIKE '3rdSuper%'
			
SELECT DISTINCT ci.custid
INTO #tblCust
FROM dbo.CustGameType cg WITH(NOLOCK)
	INNER JOIN dbo.CustInfo ci WITH(NOLOCK) ON cg.custid = ci.custid
WHERE ci.srecommend IN (SELECT custid FROM #Supers)
	AND cg.GameTypeID IN (25,26)	
	
DELETE 	dbo.CustGameType WITH(UPDLOCK,ROWLOCK)
WHERE custid IN (SELECT custid FROM #tblCust)
	AND GameTypeID IN (25,26)