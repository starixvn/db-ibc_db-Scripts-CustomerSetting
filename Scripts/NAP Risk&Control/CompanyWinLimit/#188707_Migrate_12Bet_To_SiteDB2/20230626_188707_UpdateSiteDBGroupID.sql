/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230626@Eden
	Task: Update data SiteDBGroupID of tables: Site, Dep_CustSuper - 12bet [#RedmineID:#188707]
	DB: DBCust/CustDB
*/
USE CustDB
GO

UPDATE s
SET s.SiteDBGroupID = 2
FROM Site s WITH (ROWLOCK)
WHERE site IN ('12bet')

UPDATE cs
SET cs.SiteDBGroupID = 2
FROM Dep_CustSuper cs WITH (ROWLOCK)
WHERE site IN ('12bet')
