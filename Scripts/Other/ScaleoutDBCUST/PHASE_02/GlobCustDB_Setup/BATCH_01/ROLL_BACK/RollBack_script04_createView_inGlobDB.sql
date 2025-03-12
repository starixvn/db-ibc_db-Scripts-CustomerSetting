/*<info serverAlias="DBGLOB-GlobCustDB" executers="" viewers="" isFunction="0"></info>*/
/*
	Created: DaveTruong
	Date: 20250120
	Task: Create view in GlobCustDB [RedmineID:#217137]
	DB: DBGLOB/GlobCustDB
*/
USE [GlobCustDB]
GO

/****** Object:  View [dbo].[Site]    Script Date: 3/10/2025 4:52:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[Site]
AS
SELECT [siteid], [site], [type], [spreada], [spreadb], [spreadc], [spreadd], [spreade], [spreadf], [ServerID], [isLicensee], [isActive], [isDeposit], [SpecialGroup], [BlockNewCust], [UnblockTime], [IsChinaView], [RepUpdateTime], [SiteDBGroupID], [SiteLabel], [SpecialPlatfrom], [CustDBGroupID], [SiteType]
FROM CUSTDB.dbo.Site



GO



CREATE VIEW [dbo].[SiteDBConfig]
AS
SELECT [SiteDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP], [AWSProxyDomain], [AWSProxyPort], [RepUpdateTime], [FQDN]
FROM CUSTDB.dbo.SiteDBConfig

GO

