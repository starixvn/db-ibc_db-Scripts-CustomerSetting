/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221223@Tacy
	Task: Add SiteDBConfig data
		 https://nexdev.net/issues/181596 [RedmineID: #181596]
	Database: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @AGIP VARCHAR(50)

SET @AGIP = '172.16.40.xx'

--SIT
IF @@SERVERNAME = 'SITDBCUST'
	INSERT INTO SiteDBConfig ([SiteDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP])
	SELECT 3, 'DBSite03', 'SITDBGRP03L', @AGIP

--PRO
IF @@SERVERNAME = 'DBCUST'
	INSERT INTO SiteDBConfig ([SiteDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP])
	SELECT 3, 'DBSite03', 'DBGRP03L', @AGIP
