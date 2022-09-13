/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Elodie
	Date: 20220922
	Task: Update data table Site, Dep_CustSuper [RedmineID:#158293]
	DB: DBCust/CustDB
*/
USE CustDB
GO
DELETE FROM SiteDBConfig

GO
--Local
IF @@SERVERNAME = 'TESTDBCUST'
	INSERT INTO SiteDBConfig ([SiteDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP])
	SELECT 0, 'DBTXN', 'DBTRANS', '10.18.200.55'
	UNION ALL 
	SELECT 1, 'DBSite01', 'DBGRP01L', '10.18.200.58\testsitedb'

--SIT
IF @@SERVERNAME = 'SITDBCUST'
	INSERT INTO SiteDBConfig ([SiteDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP])
	SELECT 0, 'DBTXN', 'SITDBTRANS', '172.16.40.17'
	UNION ALL 
	SELECT 1, 'DBSite01', 'SITDBGRP01L', '172.16.40.28'
	UNION ALL 
	SELECT 2, 'DBSite02', 'SITDBGRP02L', '172.16.40.48'

--PRO
IF @@SERVERNAME = 'DBCUST'
	INSERT INTO SiteDBConfig ([SiteDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP])
	SELECT 0, 'DBTXN', 'DBTRANS', '10.40.40.17'
	UNION ALL 
	SELECT 1, 'DBSite01', 'DBGRP01L', '10.40.40.108'
	UNION ALL 
	SELECT 1, 'DBSite02', 'DBGRP02L', '10.40.40.143'

UPDATE s
SET s.SiteDBGroupID = 1
FROM Site s WITH (ROWLOCK)
WHERE site IN ('Heaven','Bobo88','khmerA2')

UPDATE cs
SET cs.SiteDBGroupID = 1
FROM Dep_CustSuper cs WITH (ROWLOCK)
WHERE site IN ('Heaven','Bobo88','khmerA2')







