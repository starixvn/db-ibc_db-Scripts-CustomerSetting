/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: 20241219@Virgil
	Task: Sitebuilder - New field for White label licensee [RedmineID: #215391]
	DB:	DBGLOB-GlobCustDB
*/
USE [GlobCustDB]
GO

ALTER VIEW [dbo].[Site]
AS
SELECT [siteid], [site], [type], [spreada], [spreadb], [spreadc], [spreadd], [spreade], [spreadf], [ServerID], [isLicensee], [isActive], [isDeposit], [SpecialGroup], [BlockNewCust], [UnblockTime], [IsChinaView], [RepUpdateTime], [SiteDBGroupID], [SiteLabel], [SpecialPlatfrom], [CustDBGroupID], [SiteType]
FROM CUSTDB.dbo.Site


GO


