/*<info serverAlias="DBGLOB-GlobCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250612@Dave	
	Task: Update AGIP 
	DB: DBGLOB-GlobCustDB
	
	Revisions:
		- 20250612@Dave: Update AGIP 	
*/

/*************************************
	FOR Only KL Simple DB
**************************************/

/*SiteDBConfig*/
UPDATE SiteDBConfig
SET AGIP = '10.147.33.13', RepUpdateTime = dbo.f_GetDateTime2()
WHERE SiteDBGroupID = 0; /*DBTRANS*/

UPDATE SiteDBConfig
SET AGIP = '10.147.33.15', RepUpdateTime = dbo.f_GetDateTime2()
WHERE SiteDBGroupID = 1;/*DBSite01*/

UPDATE SiteDBConfig
SET AGIP = '10.147.33.16', RepUpdateTime = dbo.f_GetDateTime2()
WHERE SiteDBGroupID = 2;/*DBSite02*/

UPDATE SiteDBConfig
SET AGIP = '10.147.33.17', RepUpdateTime = dbo.f_GetDateTime2()
WHERE SiteDBGroupID = 3;/*DBSite03*/

/*CustDBSiteConfig*/

UPDATE CustDBSiteConfig
SET AGIP = '10.147.33.12', RepUpdateTime = dbo.f_GetDateTime2()
WHERE CustDBGroupID = 0; /*DBCUST*/

UPDATE CustDBSiteConfig
SET AGIP = '10.147.33.15', RepUpdateTime = dbo.f_GetDateTime2()
WHERE CustDBGroupID = 1; /*DBSite01*/

UPDATE CustDBSiteConfig
SET AGIP = '10.147.33.16', RepUpdateTime = dbo.f_GetDateTime2()
WHERE CustDBGroupID = 2; /*DBSite02*/

UPDATE CustDBSiteConfig, RepUpdateTime = dbo.f_GetDateTime2()
SET AGIP = '10.147.33.17'
WHERE CustDBGroupID = 3; /*DBSite03*/