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
--Local
IF @@SERVERNAME = 'TESTDBCUST'
	INSERT INTO SiteDBConfig ([SiteDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP])
	SELECT 3, 'DBSite03', 'DBGRP03L', '10.18.200.16'

--SIT
IF @@SERVERNAME = 'SITDBCUST'
INSERT INTO SiteDBConfig ([SiteDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP], AWSProxyDomain, AWSProxyPort )
SELECT 3, 'DBSite03', 'SITDBGRP03L', '172.16.40.30','172.16.40.30',1433

--PRO
--IF @@SERVERNAME = 'DBCUST'
--INSERT INTO SiteDBConfig ([SiteDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP], AWSProxyDomain, AWSProxyPort)
--SELECT 3, 'DBSite03', 'DBGRP03L', '','',0

--UPDATE s
--SET s.SiteDBGroupID = 3
--FROM Site s WITH (ROWLOCK)
--WHERE isLicensee = 0

--UPDATE cs
--SET cs.SiteDBGroupID = 3
--FROM CustSuper cs WITH (ROWLOCK)
--WHERE cs.custid NOT IN (SELECT custID FROM dep_custsuper WITH(NOLOCK))

SELECT * FROM SiteDBConfig WITH(NOLOCK)





