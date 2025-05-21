/*<info serverAlias="IRS_DBTP-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250506@Johnson	
	Task: In-House
	DB: IRS_DBTP-bodb02
	
	Revisions:
		- 20250506@Johnson: Created [RedmineID: #226060]

	Example:			
*/
CREATE TYPE [dbo].[TVP_ReplCustPotentialWinLimit] AS TABLE (
	[CustID] [INT] NOT NULL
	,[Sporttype] [SMALLINT] NOT NULL
	,[Bettype] [INT] NOT NULL
	,[PotentialWinLimit] [MONEY] NULL
	,[IsAutoReset] [BIT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustPotentialWinLimit] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/




