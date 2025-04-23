/*<info serverAlias="DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250411@Winfred	
	Task: In-House
	DB: ReplCustDB
	
	Revisions:
		- 20250411@Winfred: [NAP CM] Customer Class - Add Peak Hour Spread on rule setting [186118]

	Example:			
*/
--===================================================================================
ALTER TABLE dbo.CustomerClassSpreadClass_UAT ADD [ID] [INT] NULL
GO
/***************************************************************************/
ALTER TABLE dbo.CustomerClassSpreadDetail_UAT ADD [ID] [INT] NULL
GO



