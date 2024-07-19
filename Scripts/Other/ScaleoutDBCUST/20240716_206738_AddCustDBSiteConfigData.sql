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
	INSERT INTO CustDBSiteConfig ([CustDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP], [AWSProxyDomain], [AWSProxyPort])
	SELECT 0, 'DBCUST', 'DBCUST', '10.18.200.54', NULL, NULL
	UNION ALL 
	SELECT [SiteDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP], [AWSProxyDomain], [AWSProxyPort]
	FROM CustDB.dbo.SiteDBConfig (NOLOCK)
	WHERE SiteDBGroupID <> 0

--SIT
IF @@SERVERNAME = 'SITDBCUST'
INSERT INTO CustDBSiteConfig ([SiteDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP])
SELECT 0, 'DBTXN', 'SITDBTRANS', '172.16.40.17'
UNION ALL 
SELECT 1, 'DBSite01', 'SITDBGRP01L', '172.16.40.28'
UNION ALL 
SELECT 2, 'DBSite02', 'SITDBGRP02L', '172.16.40.48'

--PRO
IF @@SERVERNAME = 'DBCUST'
INSERT INTO CustDBSiteConfig ([SiteDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP])
SELECT 0, 'DBTXN', 'DBTRANS', '10.40.40.17'
UNION ALL 
SELECT 1, 'DBSite01', 'DBGRP01L', '10.40.40.108'

UPDATE s
SET s.SiteDBGroupID = 1
FROM Site s WITH (ROWLOCK)
WHERE site IN ('sampleSite','athena000')

UPDATE cs
SET cs.SiteDBGroupID = 1
FROM Dep_CustSuper cs WITH (ROWLOCK)
WHERE site IN ('sampleSite','athena000')

SELECT * FROM SiteDBConfig





