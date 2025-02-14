/*<info serverAlias="IRS_DBTP-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250305@Johnson	
	Task: In-House
	DB: IRS_DBTP-bodb02
	
	Revisions:
		- 20250305@Johnson: Created [RedmineID: #216870]

	Example:			
*/
CREATE TYPE [dbo].[TVP_ReplWinlimit_ProductGlobalSetting] AS TABLE (
	[ProductID] [INT] NOT NULL
	,[BetTypeID] [SMALLINT] NOT NULL
	,[GroupID] [INT] NOT NULL
	,[GroupName] [VARCHAR](200) NULL
	,[Level1] [MONEY] NULL
	,[Level2] [MONEY] NULL
	,[Level3] [MONEY] NULL
	,[Level101] [MONEY] NULL
	,[Level102] [MONEY] NULL
	,[blockedTransferLvl3] [BIT] NULL
	,[Currency] [INT] NOT NULL
	,[IsDeposit] [BIT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplWinlimit_ProductGlobalSetting] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplWinlimit_Group] AS TABLE (
	[GroupID] [INT] NOT NULL
	,[GroupName] [VARCHAR](200) NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplWinlimit_Group] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/




