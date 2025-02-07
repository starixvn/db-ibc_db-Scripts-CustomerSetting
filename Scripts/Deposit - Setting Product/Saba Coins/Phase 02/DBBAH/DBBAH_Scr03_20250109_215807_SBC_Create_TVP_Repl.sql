/*<info serverAlias="IRS_DBBAH-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250109@Tacy	
	Task: In-House
	DB: IRS_DBBAH-bodb02
	
	Revisions:
		- 20241220@Tacy: Created [RedmineID: #215807]

	Example:			
*/
CREATE TYPE [dbo].[TVP_ReplDep_CustSabaInfo] AS TABLE (
	[CustID] [INT] NOT NULL
	,[CustType] [TINYINT] NOT NULL
	,[SabaID] [BIGINT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT] NOT NULL
	,[_FetchedTime] [DATETIME2](7) NULL
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplDep_CustSabaInfo] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/




