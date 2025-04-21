/*<info serverAlias="DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250415@Winfred	
	Task: In-House
	DB: DBCustRepl-ReplCustDB
	
	Revisions:
		- 20250411@Winfred: [NAP CM] Customer Class - Add Peak Hour Spread on rule setting [186118]

	Example:			
*/
DROP PROCEDURE Repl_PutCustomerClassSpreadClass_Dist
GO
--DROP PROCEDURE Repl_PutCustomerClassSpreadClass_UAT_Dist
--GO
DROP PROCEDURE Repl_PutCustomerClassSpreadDetail_Dist
GO
--DROP PROCEDURE Repl_PutCustomerClassSpreadDetail_UAT_Dist
--GO
DROP TYPE TVP_ReplCustomerClassSpreadClass
GO
--DROP TYPE TVP_ReplCustomerClassSpreadClass_UAT
--GO
DROP TYPE TVP_ReplCustomerClassSpreadDetail
GO
--DROP TYPE TVP_ReplCustomerClassSpreadDetail_UAT
--GO
CREATE TYPE [dbo].[TVP_ReplCustomerClassSpreadClass] AS TABLE (
	[PolicyID] [INT] NOT NULL
	,[CustomerClass] [SMALLINT] NOT NULL
	,[ID] [INT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomerClassSpreadClass] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
--CREATE TYPE [dbo].[TVP_ReplCustomerClassSpreadClass_UAT] AS TABLE (
--	[PolicyID] [INT] NOT NULL
--	,[CustomerClass] [SMALLINT] NOT NULL
--	,[ID] [INT] NULL
--	,[RepUpdateTime] [DATETIME2](7) NOT NULL
--	,[isDeleted] [BIT]
--	,[_FetchedTime] [DATETIME2](7)
--)
--GO
--GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomerClassSpreadClass_UAT] TO [repl_ap] AS [dbo]
--GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplCustomerClassSpreadDetail] AS TABLE (
	[PolicyID] [INT] NOT NULL
	,[SiteID] [INT] NOT NULL
	,[Currency] [INT] NOT NULL
	,[Platform] [TINYINT] NOT NULL
	,[SportType] [SMALLINT] NOT NULL
	,[ID] [INT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomerClassSpreadDetail] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
--CREATE TYPE [dbo].[TVP_ReplCustomerClassSpreadDetail_UAT] AS TABLE (
--	[PolicyID] [INT] NOT NULL
--	,[SiteID] [INT] NOT NULL
--	,[Currency] [INT] NOT NULL
--	,[Platform] [TINYINT] NOT NULL
--	,[SportType] [SMALLINT] NOT NULL
--	,[ID] [INT] NULL
--	,[RepUpdateTime] [DATETIME2](7) NOT NULL
--	,[isDeleted] [BIT]
--	,[_FetchedTime] [DATETIME2](7)
--)
--GO
--GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomerClassSpreadDetail_UAT] TO [repl_ap] AS [dbo]
--GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplCustomerClassSpreadLeagueGroup] AS TABLE (
	[PolicyID] [INT] NOT NULL
	,[LeagueGroupID] [SMALLINT] NOT NULL
	,[ID] [INT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomerClassSpreadLeagueGroup] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
--CREATE TYPE [dbo].[TVP_ReplCustomerClassSpreadLeagueGroup_UAT] AS TABLE (
--	[PolicyID] [INT] NOT NULL
--	,[LeagueGroupID] [SMALLINT] NOT NULL
--	,[ID] [INT] NULL
--	,[RepUpdateTime] [DATETIME2](7) NOT NULL
--	,[isDeleted] [BIT]
--	,[_FetchedTime] [DATETIME2](7)
--)
--GO
--GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomerClassSpreadLeagueGroup_UAT] TO [repl_ap] AS [dbo]
--GO
/***************************************************************************/




