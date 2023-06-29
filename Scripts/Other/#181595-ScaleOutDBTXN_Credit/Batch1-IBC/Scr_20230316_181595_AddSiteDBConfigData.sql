/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20230316
	Task: Insert data SiteDBConfig - SiteDB03 [RedmineID:#182138]
	DB: DBCust/CustDB
*/
USE CustDB
GO
DELETE FROM SiteDBConfig WITH(ROWLOCK) WHERE SiteDBGroupID = 3

GO

--PRO
--IF @@SERVERNAME = 'DBCUST'
--INSERT INTO SiteDBConfig ([SiteDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP], AWSProxyDomain, AWSProxyPort)
--SELECT 3, 'DBSite03', 'DBGRP03L', '','',0

SELECT * FROM SiteDBConfig WITH(NOLOCK)





