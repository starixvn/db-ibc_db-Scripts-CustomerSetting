/*<info serverAlias="DBGLOB-GlobCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250707@Dave	
	Task: Update AGIP 
	DB: DBGLOB-GlobCustDB
	
	Revisions:
		- 20250707@Dave: Update AGIP 	
*/

/*************************************
	FOR Only KL PRO DB
**************************************/

/*SiteDBConfig*/
UPDATE SiteDBConfig
SET AGIP = 'dbtrans.dp.gamora.prod,7104', RepUpdateTime = dbo.f_GetDateTime2()
WHERE SiteDBGroupID = 0; /*DBTRANS*/

UPDATE SiteDBConfig
SET AGIP = 'dbtrans.dp.gamora.prod,7104', RepUpdateTime = dbo.f_GetDateTime2()
WHERE SiteDBGroupID = 1;/*DBSite01*/

UPDATE SiteDBConfig
SET AGIP = 'dbtrans.dp.gamora.prod,7104', RepUpdateTime = dbo.f_GetDateTime2()
WHERE SiteDBGroupID = 2;/*DBSite02*/

UPDATE SiteDBConfig
SET AGIP = 'dbtrans.dp.gamora.prod,7104', RepUpdateTime = dbo.f_GetDateTime2()
WHERE SiteDBGroupID = 3;/*DBSite03*/

/*CustDBSiteConfig*/

UPDATE CustDBSiteConfig
SET AGIP = 'dbcust.dp.gamora.prod,7105', RepUpdateTime = dbo.f_GetDateTime2()
WHERE CustDBGroupID = 0; /*DBCUST*/

UPDATE CustDBSiteConfig
SET AGIP = 'dbcust.dp.gamora.prod,7105', RepUpdateTime = dbo.f_GetDateTime2()
WHERE CustDBGroupID = 1; /*DBSite01*/

UPDATE CustDBSiteConfig
SET AGIP = 'dbcust.dp.gamora.prod,7105', RepUpdateTime = dbo.f_GetDateTime2()
WHERE CustDBGroupID = 2; /*DBSite02*/

UPDATE CustDBSiteConfig
SET AGIP = 'dbcust.dp.gamora.prod,7105', RepUpdateTime = dbo.f_GetDateTime2()
WHERE CustDBGroupID = 3; /*DBSite03*/