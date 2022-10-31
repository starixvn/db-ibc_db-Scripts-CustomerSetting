/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Elodie
	Date: 20220610
	Task: Update data table Site, Dep_CustSuper [RedmineID:#178142]
	DB: DBCust/CustDB
*/
USE CustDB
GO

UPDATE s
SET s.SiteDBGroupID = 2
FROM Site s WITH (ROWLOCK)
WHERE site IN ('9Club','X2Dynamic','OneSports','Macaubet')

UPDATE cs
SET cs.SiteDBGroupID = 2
FROM Dep_CustSuper cs WITH (ROWLOCK)
WHERE site IN ('9Club','X2Dynamic','OneSports','Macaubet')







