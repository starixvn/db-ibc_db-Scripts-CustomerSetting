/*<info serverAlias="DBCustRepl-ReplCustDB"></info>*/
/*
	Created: 20250217@Virgil	
	Task: Customer Setting - Apply In-house replication for profile setting tables
	DB: DBCustRepl-ReplCustDB
	
	Revisions:
		- 20241230@Virgil: Add column IsDeleted to dbo.PlayCurrencySetting [RedmineID: #214117]

	Table Related: 
		PlayCurrencySetting
*/

-----------------[PlayCurrencySetting]--------------------
ALTER TABLE [dbo].[PlayCurrencySetting]
ADD [isDeleted] [BIT] NULL