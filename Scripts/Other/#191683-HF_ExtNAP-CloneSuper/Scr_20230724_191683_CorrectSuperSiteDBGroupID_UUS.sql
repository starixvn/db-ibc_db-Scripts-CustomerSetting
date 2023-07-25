/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*	
	Created: 20230724@Eden
	Task: Correct data CustSuper.SiteDBGroupID for super 'absupertestshi771' -- test account [#191683]
	DB: DBCUST/CUSTDB 
*/
USE CustDB
GO
/* --Get Super wrong data
CREATE TABLE #TempSuper (CustID INT PRIMARY KEY)

INSERT INTO #TempSuper(CustID)
SELECT custid
FROM dblog.bodb_CustomerLog.dbo.UserLog_RunSP WITH(NOLOCK) 
WHERE ActionID = 95009
	AND logdate >= GETDATE() - 10


SELECT t.*,c.username,c.site,c.currency,c.creatdate,cs.SiteDBGroupID
FROM #TempSuper t
	INNER JOIN CustSuper cs WITH(NOLOCK)
		ON t.CustID = cs.custid
	INNER JOIN Customer c WITH(NOLOCK)
		ON c.custid = cs.custid
	INNER JOIN site s WITH(NOLOCK)
		On s.site = c.site
WHERE s.isLicensee = 0
	AND cs.SiteDBGroupID <> 0

DROP TABLE #TempSuper


SELECT * FROM custinfo (NOLOCK) where custid = 93544820

*/

UPDATE cs
SET cs.SiteDBGroupID = 0
FROM CustSuper cs WITH(ROWLOCK)
WHERE cs.custid = 93544820 --absupertestshi771



