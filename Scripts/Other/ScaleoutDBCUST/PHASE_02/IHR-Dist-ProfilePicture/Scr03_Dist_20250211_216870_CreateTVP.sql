/*<info serverAlias="DBCustRepl-ReplCustDB"></info>*/
/*
	Created: 20250211@Tacy	
	Task: Scale Out DBCUST - Setup InHouse replication on Dist
	DB: DBCustRepl-ReplCustDB
	
	Revisions:
		- 20250211@Tacy: Created [RedmineID: #216870]

	Tables:
		ProfilePicture
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--ProfilePicture
CREATE TYPE [dbo].[TVP_RepProfilePicture] AS TABLE(
	[imageid] [int] NOT NULL,
	[image] [varbinary](max) NOT NULL,
	[isdeleted] [bit] NULL,
	[repupdatetime] [datetime2](7) NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].[TVP_RepProfilePicture] TO [repl_ap] AS [dbo]
GO