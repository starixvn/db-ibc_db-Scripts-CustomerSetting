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
SELECT [SiteDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP], [AWSProxyDomain], [AWSProxyPort], [RepUpdateTime], [FQDN]
FROM CUSTDB.dbo.SiteDBConfig
GO

CREATE VIEW [dbo].[Exchange]
AS
SELECT [currency], [stakerate], [actualrate], [commaxpayout], [creator], [minbet], [minbetlive], [AUDRate], [ZARRate], [GBPRate], [EURORate], [US$Rate], [Code], [Description], [MultipliedBy], [ExVirtualRate], [IsActive], [OfferSite], [ExchangeId], [RepUpdateTime], [CurrencyType], [CreditGroupID], [LicenseeGroupID]
FROM CUSTDB.dbo.Exchange