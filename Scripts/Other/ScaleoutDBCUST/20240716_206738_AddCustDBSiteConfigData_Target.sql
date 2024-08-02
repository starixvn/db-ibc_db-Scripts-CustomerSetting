/*<info serverAlias="DBAGE-bodb02,DBACC-bodb02"></info>*/
/*
	Created: Elodie
	Date: 20240717
	Task: Create table CustDBSiteConfig [RedmineID:#206738]
	DB: DBAGE-bodb02,DBACC-bodb02
*/
USE bodb02
GO
DELETE FROM CustDBSiteConfig

GO
--Local
IF @@SERVERNAME = 'TESTDB053' OR @@SERVERNAME = 'TESTDB061'
	INSERT INTO CustDBSiteConfig ([CustDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP], [AWSProxyDomain], [AWSProxyPort], [FQDN])
	SELECT 0, 'DBCUST', 'DBCUST', '10.18.200.54', NULL, NULL, NULL
	UNION ALL 
	SELECT [SiteDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP], [AWSProxyDomain], [AWSProxyPort], [FQDN]
	FROM dbo.SiteDBConfig (NOLOCK)
	WHERE SiteDBGroupID <> 0

----SIT
--IF @@SERVERNAME = 'SITDBCUST'
--	INSERT INTO CustDBSiteConfig ([CustDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP], [AWSProxyDomain], [AWSProxyPort], [FQDN])
--	SELECT 0, 'DBCUST', 'DBCUST', '172.16.40.21', NULL, NULL, 'sitdbcust.nebula.sit'
--	UNION ALL 
--	SELECT [SiteDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP], [AWSProxyDomain], [AWSProxyPort], [FQDN]
--	FROM dbo.SiteDBConfig (NOLOCK)
--	WHERE SiteDBGroupID <> 0

----PRO
--IF @@SERVERNAME = 'DBCUST'
--	INSERT INTO CustDBSiteConfig ([CustDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP], [AWSProxyDomain], [AWSProxyPort], [FQDN])
--	SELECT 0, 'DBCUST', 'DBCUST', '10.40.40.191', NULL, NULL, ''
--	UNION ALL 
--	SELECT [SiteDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP], [AWSProxyDomain], [AWSProxyPort], [FQDN]
--	FROM dbo.SiteDBConfig (NOLOCK)
--	WHERE SiteDBGroupID <> 0

SELECT * FROM CustDBSiteConfig


--EXEC Acc_ServerDBConfigSelByCust @username = 'supertest1'