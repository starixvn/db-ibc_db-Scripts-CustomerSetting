/*<info serverAlias="DBCTG-bodb02"></info>*/
/*
	Created: 20230622@Eden
	Task: delete data for balance game tables after migrate Credit data to SITEDB3 - IBC [#RedmineID:#181595]
	DB: DBCTG/bodb02 
*/
CREATE TABLE #Supers (custid int PRIMARY KEY)

INSERT INTO #Supers(custid)
SELECT DISTINCT ci.Custid
FROM custdb.dbo.customer ci WITH(NOLOCK) 
	INNER JOIN custdb.dbo.Site s WITH(NOLOCK) 
		ON ci.site = s.site
WHERE s.isLicensee = 0
	AND ci.roleid = 4
	AND ci.custid NOT IN ( SELECT custid FROM custdb.dbo.Dep_CustSuper WITH(NOLOCK))
	AND s.SiteLabel IN ('IBC')

DELETE c
FROM dbo.Winlimit_CreditGame c WITH(ROWLOCK,UPDLOCK)
	INNER JOIN custdb.dbo.custinfo ci WITH(NOLOCK) ON c.CustId = ci.custid
WHERE ci.srecommend IN (SELECT custid FROM #Supers)

DELETE c
FROM dbo.Winlimit_DebitGame c WITH(ROWLOCK,UPDLOCK)
	INNER JOIN custdb.dbo.custinfo ci WITH(NOLOCK) ON c.CustId = ci.custid
WHERE ci.srecommend IN (SELECT custid FROM #Supers)

DELETE c
FROM dbo.BalanceCreditGame c WITH(ROWLOCK,UPDLOCK)
	INNER JOIN custdb.dbo.custinfo ci WITH(NOLOCK) ON c.CustId = ci.custid
WHERE ci.srecommend IN (SELECT custid FROM #Supers)

DELETE c
FROM dbo.BalanceDebitGame c WITH(ROWLOCK,UPDLOCK)
	INNER JOIN custdb.dbo.custinfo ci WITH(NOLOCK) ON c.CustId = ci.custid
WHERE ci.srecommend IN (SELECT custid FROM #Supers)

--DELETE c
--FROM dbo.Task_Cust_CheckBalance_Exception c WITH(ROWLOCK,UPDLOCK)
--	INNER JOIN custdb.dbo.custinfo ci WITH(NOLOCK) ON c.CustId = ci.custid
--WHERE ci.srecommend IN (SELECT custid FROM #Supers)

DROP TABLE #Supers
	
/*
SELECT COUNT(1)
FROM dbo.Winlimit_CreditGame c WITH(NOLOCK)
	INNER JOIN custdb.dbo.custinfo ci WITH(NOLOCK) ON c.CustId = ci.custid
WHERE ci.srecommend NOT IN (SELECT custid FROM custdb.dbo.Dep_custsuper WITH(NOLOCK))

SELECT COUNT(1)
FROM dbo.Winlimit_DebitGame c WITH(NOLOCK)
	INNER JOIN custdb.dbo.custinfo ci WITH(NOLOCK) ON c.CustId = ci.custid
WHERE ci.srecommend NOT IN (SELECT custid FROM custdb.dbo.Dep_custsuper WITH(NOLOCK))

SELECT COUNT(1)
FROM dbo.BalanceCreditGame c WITH(ROWLOCK,UPDLOCK)
	INNER JOIN custdb.dbo.custinfo ci WITH(NOLOCK) ON c.CustId = ci.custid
WHERE ci.srecommend IN (SELECT custid FROM #Supers)

SELECT COUNT(1)
FROM dbo.BalanceDebitGame c WITH(ROWLOCK,UPDLOCK)
	INNER JOIN custdb.dbo.custinfo ci WITH(NOLOCK) ON c.CustId = ci.custid
WHERE ci.srecommend IN (SELECT custid FROM #Supers)

SELECT COUNT(1)
FROM dbo.Task_Cust_CheckBalance_Exception c WITH(ROWLOCK,UPDLOCK)
	INNER JOIN custdb.dbo.custinfo ci WITH(NOLOCK) ON c.CustId = ci.custid
WHERE ci.srecommend NOT IN (SELECT custid FROM custdb.dbo.Dep_custsuper WITH(NOLOCK))

*/