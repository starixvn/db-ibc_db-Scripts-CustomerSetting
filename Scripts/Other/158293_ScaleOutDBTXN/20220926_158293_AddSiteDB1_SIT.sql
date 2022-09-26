/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Elodie
	Date: 20220926
	Task: Update data table Site, Dep_CustSuper [RedmineID:#178145]
	DB: DBCust/CustDB
*/
USE CustDB
GO

IF @@SERVERNAME <> 'SITDBCUST'
	RETURN

UPDATE s
SET s.SiteDBGroupID = 1
FROM Site s WITH (ROWLOCK)
WHERE site IN ('Bobo88')

UPDATE cs
SET cs.SiteDBGroupID = 1
FROM Dep_CustSuper cs WITH (ROWLOCK)
WHERE site IN ('Bobo88')









