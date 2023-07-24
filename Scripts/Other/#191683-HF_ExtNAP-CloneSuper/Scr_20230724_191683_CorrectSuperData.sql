/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*	
	Created: 20230724@Eden
	Task: Correct data CustSuper.MaxMember = 20000 for 789y supers [#191683]
	DB: DBCUST/CUSTDB 
*/
USE CustDB
GO

CREATE TABLE #TempSuper (CustID INT PRIMARY KEY)
INSERT INTO #TempSuper(CustID)
SELECT custid
FROM dblog.bodb_CustomerLog.dbo.UserLog_RunSP WITH(NOLOCK) 
WHERE ActionID = 95009
	AND logdate >= '04/11/2023'
UNION
SELECT custid
FROM dblog.bodb_CustomerLog_Archive.dbo.UserLog_RunSP WITH(NOLOCK) 
WHERE ActionID = 95009
	AND logdate >= '04/11/2023'

--SELECT t.*,cs.custid,cs.MaxMember,s.site
--FROM #TempSuper t
--	INNER JOIN CustSuper cs WITH(NOLOCK)
--		ON t.CustID = cs.custid
--	INNER JOIN Customer c WITH(NOLOCK)
--		ON c.custid = cs.custid
--	INNER JOIN site s WITH(NOLOCK)
--		On s.site = c.site
--WHERE s.SiteLabel = '789y'

UPDATE cs
SET cs.MaxMember = 20000
FROM #TempSuper t
	INNER JOIN CustSuper cs WITH(ROWLOCK,UPDLOCK)
		ON t.CustID = cs.custid
	INNER JOIN Customer c WITH(NOLOCK)
		ON c.custid = cs.custid
	INNER JOIN site s WITH(NOLOCK)
		On s.site = c.site
WHERE s.SiteLabel = '789y'

DROP TABLE #TempSuper


