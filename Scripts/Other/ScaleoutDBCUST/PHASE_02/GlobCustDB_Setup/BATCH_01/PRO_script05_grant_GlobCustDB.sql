/*<info serverAlias="DBGLOB-GlobCustDB" executers="" viewers="" isFunction="0"></info>*/
/*
	Created: DaveTruong
	Date: 20250120
	Task: Grant on GlobCustDB [RedmineID:#216870]
	DB: DBGLOB/GlobCustDB
*/
USE GlobCustDB;
GO
/*Site*/
GRANT SELECT ON dbo.Site TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*SiteDBConfig*/
GRANT SELECT ON dbo.SiteDBConfig TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;