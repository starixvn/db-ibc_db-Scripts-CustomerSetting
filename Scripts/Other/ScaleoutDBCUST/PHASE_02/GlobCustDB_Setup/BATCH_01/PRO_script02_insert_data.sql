/*<info serverAlias="DBGLOB-GlobCustDB" executers="" viewers="" isFunction="0"></info>*/
/*
	Created: DaveTruong
	Date: 20250120
	Task: Create table ScaleOut Custsetting on  GlobCustDB [RedmineID:#216870]
	DB: DBGLOB/GlobCustDB
*/
USE GlobCustDB
GO
/*Site*/
SET IDENTITY_INSERT [dbo].[Site] ON; 
INSERT INTO GlobCustDB.[dbo].[Site]( siteid, site, type, spreada, spreadb, spreadc, spreadd, spreade, spreadf, ServerID, isLicensee, isActive, isDeposit, SpecialGroup, BlockNewCust, UnblockTime, IsChinaView, RepUpdateTime, SiteDBGroupID, SiteLabel, SpecialPlatfrom, CustDBGroupID, SiteType)
SELECT  siteid , site , type , spreada , spreadb , spreadc , spreadd , spreade , spreadf , ServerID , isLicensee , isActive , isDeposit , SpecialGroup , BlockNewCust , UnblockTime , IsChinaView , RepUpdateTime , SiteDBGroupID , SiteLabel , SpecialPlatfrom , CustDBGroupID , SiteType 
FROM CustDB.[dbo].[Site] WITH(NOLOCK);
SET IDENTITY_INSERT [dbo].[Site] OFF; 


/*SiteDBConfig*/
INSERT INTO GlobCustDB.[dbo].[SiteDBConfig]( SiteDBGroupID, LinkedServerName, ClientAccessName, AGIP, AWSProxyDomain, AWSProxyPort, RepUpdateTime, FQDN)
SELECT  SiteDBGroupID , LinkedServerName , ClientAccessName , AGIP , AWSProxyDomain , AWSProxyPort , RepUpdateTime , FQDN 
FROM CustDB.[dbo].[SiteDBConfig] WITH(NOLOCK);
