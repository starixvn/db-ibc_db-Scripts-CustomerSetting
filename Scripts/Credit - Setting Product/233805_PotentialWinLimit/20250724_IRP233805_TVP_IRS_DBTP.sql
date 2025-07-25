/*<info serverAlias="IRS_DBTP-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250724@Johnson	
	Task: In-House
	DB: IRS_DBTP-bodb02
	
	Revisions:
		- 20250724@Johnson: Created [RedmineID: #233805]

	Example:			
*/
DROP PROC Repl_PutCustPotentialWinLimit_Dist
GO

DROP TYPE [TVP_ReplCustPotentialWinLimit]
GO

CREATE TYPE [dbo].[TVP_ReplCustPotentialWinLimit] AS TABLE (
	[CustID] [INT] NOT NULL
	,[Sporttype] [SMALLINT] NOT NULL
	,[Bettype] [INT] NOT NULL
	,[PotentialWinLimit] [MONEY] NULL
	,[IsAutoReset] [BIT] NULL
	,[OfferOption] [TINYINT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustPotentialWinLimit] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/


