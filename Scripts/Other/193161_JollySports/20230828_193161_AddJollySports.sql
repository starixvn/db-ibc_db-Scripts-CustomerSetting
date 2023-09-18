/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20230828
	Task:  Deposit - Support Jolly Sports RedmineID:#193161
	DB: DBCust/CustDB and all replicated server of table Site
*/

USE CustDB
GO

ALTER TABLE dbo.Site ADD SpecialPlatfrom TINYINT NULL CONSTRAINT [DF_Site_SpecialPlatform]  DEFAULT ((0))
GO