/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Elodie
	Date: 20221108
	Task: Update data table Site, Dep_CustSuper [RedmineID:#180033]
	DB: DBCust/CustDB
*/
USE CustDB
GO

UPDATE s
SET s.SiteDBGroupID = 0
FROM Site s WITH (ROWLOCK)
WHERE site IN ('Betway')


UPDATE cs
SET cs.SiteDBGroupID = 0
FROM Dep_CustSuper cs WITH (ROWLOCK)
WHERE site IN ('Betway')









