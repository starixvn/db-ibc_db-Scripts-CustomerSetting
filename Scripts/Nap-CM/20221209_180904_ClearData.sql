/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20221209@Winfred
	DB: DBCUST/CustDB
	Task:  [NAP CM] Build Customer Class Management basketball
	Revisions:
		- 20221209@Winfred: [NAP CM] Build Customer Class Management [RedmineID: #180904] 
*/
-- Clear data
--===================================================================================
DBCC CHECKIDENT ('CustomerClassRule', RESEED, 0)
TRUNCATE TABLE [dbo].[CustomerClassRule]
TRUNCATE TABLE [dbo].[CustomerClassRuleLeagueGroup]
DBCC CHECKIDENT ('CustomerClassPolicyManagement', RESEED, 0)
TRUNCATE TABLE [dbo].[CustomerClassPolicyManagement]
TRUNCATE TABLE [dbo].[CustomerClassPolicyRule]
TRUNCATE TABLE [dbo].[CustomerClassSiteManagement]