/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20241219@Virgil
	Task: Sitebuilder - New field for White label licensee [RedmineID: #215391]
	DB:	DBCUST-CustDB
*/

USE CustDB
GO

ALTER TABLE dbo.Site
ADD SiteType TINYINT;

ALTER TABLE dbo.Site
ADD CONSTRAINT [DF_Site_SiteType] DEFAULT ((0)) FOR [SiteType];


GO

