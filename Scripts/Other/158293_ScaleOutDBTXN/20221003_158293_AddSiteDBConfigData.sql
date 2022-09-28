/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Elodie
	Date: 20221003
	Task: Add SiteDBConfig data [RedmineID:#158293]
	DB: DBCust/CustDB
*/
USE CustDB
GO
--SIT
IF @@SERVERNAME = 'SITDBCUST'
	INSERT INTO SiteDBConfig ([SiteDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP])
	SELECT 2, 'DBSite02', 'SITDBGRP02L', '172.16.40.48'

--PRO
IF @@SERVERNAME = 'DBCUST'
	INSERT INTO SiteDBConfig ([SiteDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP])
	SELECT 2, 'DBSite02', 'DBGRP02L', '10.40.40.143'









