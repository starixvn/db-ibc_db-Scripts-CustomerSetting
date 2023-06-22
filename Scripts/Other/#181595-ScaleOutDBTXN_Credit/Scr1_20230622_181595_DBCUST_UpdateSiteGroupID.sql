/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230622@Eden
	Task: Update data table Site, CustSuper [RedmineID:#181595]
	DB: DBCust/CustDB
*/
USE CustDB
GO

UPDATE s
SET s.SiteDBGroupID = 3
FROM Site s WITH (ROWLOCK)
WHERE s.isLicensee = 0
	AND s.SiteDBGroupID <> 3
	AND s.SiteLabel IN ('Nova88','789y','IBC')

UPDATE cs
SET cs.SiteDBGroupID = 3
FROM CustSuper cs WITH (ROWLOCK)
	INNER JOIN customer ci WITH(NOLOCK) 
		ON ci.custid = cs.custid
	INNER JOIN Site s WITH(NOLOCK) 
		ON ci.site = s.site
WHERE s.isLicensee = 0
	AND s.SiteDBGroupID <> 3
	AND cs.custid NOT IN ( SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.SiteLabel IN ('Nova88','789y','IBC')






