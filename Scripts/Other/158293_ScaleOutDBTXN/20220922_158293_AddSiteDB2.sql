/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Elodie
	Date: 20220922
	Task: Update data table Site, Dep_CustSuper [RedmineID:#158293]
	DB: DBCust/CustDB
*/
USE CustDB
GO

--UPDATE s
--SET s.SiteDBGroupID = 1
--FROM Site s WITH (ROWLOCK)
--WHERE site IN ('Heaven','Bobo88','khmerA2')

--UPDATE cs
--SET cs.SiteDBGroupID = 1
--FROM Dep_CustSuper cs WITH (ROWLOCK)
--WHERE site IN ('Heaven','Bobo88','khmerA2')

GO
--SIT
IF @@SERVERNAME = 'SITDBCUST'
	INSERT INTO SiteDBConfig ([SiteDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP])
	SELECT 2, 'DBSite02', 'SITDBGRP02L', '172.16.40.48'

--PRO
IF @@SERVERNAME = 'DBCUST'
	INSERT INTO SiteDBConfig ([SiteDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP])
	SELECT 2, 'DBSite02', 'DBGRP02L', '10.40.40.143'









