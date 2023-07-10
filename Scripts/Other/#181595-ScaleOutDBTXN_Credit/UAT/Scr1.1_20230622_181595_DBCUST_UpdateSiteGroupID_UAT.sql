/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230622@Eden
	Task: Update data table Site, CustSuper - 222227 [RedmineID:#181595]
	DB: DBCust/CustDB
*/
USE CustDB
GO

UPDATE s
SET s.SiteDBGroupID = 3,
	s.RepUpdateTime = Sysdatetime()
FROM Site s WITH (ROWLOCK)
WHERE s.site = '222227'

UPDATE cs
SET cs.SiteDBGroupID = 3
FROM CustSuper cs WITH (NOLOCK)
	INNER JOIN customer ci WITH(NOLOCK) 
		ON ci.custid = cs.custid
WHERE ci.site = '222227'

/*
SELECT *
FROM Site s WITH (NOLOCK)
WHERE s.site = '222227'

SELECT cs.*
FROM CustSuper cs WITH (NOLOCK)
	INNER JOIN customer ci WITH(NOLOCK) 
		ON ci.custid = cs.custid
WHERE ci.site = '222227'
*/






