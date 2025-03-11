/*<info serverAlias="IRS_DBTP-bodb02"></info>*/
/*
	Created: 20250221@Virgil	
	Task: Customer Setting - Apply In-house replication for profile setting tables
	DB: DBCustRepl-ReplCustDB
	
	Revisions:
		- 20241230@Virgil: Created [RedmineID: #214117]

	Table Related:
		CategoryConfig
*/
DROP PROCEDURE [dbo].[Repl_PutCategoryConfig_Dist];

DROP TYPE [dbo].[TVP_ReplCategoryConfig];
