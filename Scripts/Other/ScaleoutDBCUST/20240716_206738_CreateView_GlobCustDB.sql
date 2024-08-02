/*<info serverAlias="DBGLOB-GLOBCUSTDB" executers="" viewers="" isFunction="0"></info>*/
USE [GlobCustDB]
GO

CREATE VIEW [dbo].[Site]
AS
SELECT [siteid], [site], [type], [spreada], [spreadb], [spreadc], [spreadd], [spreade], [spreadf], [ServerID], [isLicensee], [isActive], [isDeposit], [SpecialGroup], [BlockNewCust], [UnblockTime], [IsChinaView], [RepUpdateTime], [SiteDBGroupID], [SiteLabel], [SpecialPlatfrom], [CustDBGroupID]
FROM CUSTDB.dbo.Site

GO

CREATE VIEW [dbo].[SiteDBConfig]
AS
SELECT [SiteDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP], [AWSProxyDomain], [AWSProxyPort], [GroupType], [RepUpdateTime], [FQDN]
FROM CUSTDB.dbo.SiteDBConfig
GO

