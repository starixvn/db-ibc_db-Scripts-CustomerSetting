/*<info serverAlias="DBCUST-GlobCustDB"></info>*/
/*
	Created: Elodie
	Date: 20240717
	Task: Create table CustDBSiteConfig [RedmineID:#206738]
	DB: DBCUST/GlobCustDB
*/
USE GlobCustDB
GO
DELETE FROM CustDBSiteConfig

GO
--Local
IF @@SERVERNAME = 'TESTDBCUST'
	INSERT INTO CustDBSiteConfig ([CustDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP], [AWSProxyDomain], [AWSProxyPort], [FQDN])
	SELECT 0, 'DBCUST', 'DBCUST', '10.18.200.54', NULL, NULL, NULL
	UNION ALL 
	SELECT [CustDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP], [AWSProxyDomain], [AWSProxyPort], [FQDN]
	FROM CustDB.dbo.SiteDBConfig (NOLOCK)
	WHERE SiteDBGroupID <> 0

--SIT
IF @@SERVERNAME = 'SITDBCUST'
	INSERT INTO CustDBSiteConfig ([CustDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP], [AWSProxyDomain], [AWSProxyPort], [FQDN])
	SELECT 0, 'DBCUST', 'DBCUST', '172.16.40.21', NULL, NULL, 'sitdbcust.nebula.sit'
	UNION ALL 
	SELECT [CustDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP], [AWSProxyDomain], [AWSProxyPort], [FQDN]
	FROM CustDB.dbo.SiteDBConfig (NOLOCK)
	WHERE SiteDBGroupID <> 0

--PRO
IF @@SERVERNAME = 'DBCUST'
	INSERT INTO CustDBSiteConfig ([CustDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP], [AWSProxyDomain], [AWSProxyPort], [FQDN])
	SELECT 0, 'DBCUST', 'DBCUST', '10.40.40.191', NULL, NULL, ''
	UNION ALL 
	SELECT [CustDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP], [AWSProxyDomain], [AWSProxyPort], [FQDN]
	FROM CustDB.dbo.SiteDBConfig (NOLOCK)
	WHERE SiteDBGroupID <> 0







