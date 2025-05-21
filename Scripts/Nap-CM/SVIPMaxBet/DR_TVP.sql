/*<info serverAlias="DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250313@Winfred	
	Task: In-House
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250313@Winfred:  [NAP CM] Customer - Increase Bet Limit Created [RedmineID: #218073]

	Example:			
*/
CREATE TYPE [dbo].[TVP_ReplSVIPMaxBetPlayer] AS TABLE (
	[SiteID] [INT] NOT NULL
	,[custid] [INT] NOT NULL
	,[SportType] [SMALLINT] NOT NULL
	,[Bettype] [SMALLINT] NOT NULL
	,[Multiplier] [DECIMAL](9,2) NULL
	,[Note] [NVARCHAR](1000) NULL
	,[IsTest] [TINYINT] NOT NULL
	,[LastModifiedUser] [INT] NULL
	,[LastModifiedTime] [DATETIME] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplSVIPMaxBetPlayer] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplSVIPMaxBetHistory] AS TABLE (
	[ID] [INT] NOT NULL
	,[SiteID] [INT] NOT NULL
	,[custid] [INT] NOT NULL
	,[SportType] [SMALLINT] NOT NULL
	,[Bettype] [SMALLINT] NOT NULL
	,[Multiplier] [DECIMAL](9,2) NULL
	,[IsTest] [TINYINT] NOT NULL
	,[Action] [VARCHAR](10) NULL
	,[LastModifiedUser] [INT] NULL
	,[LastModifiedTime] [DATETIME] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplSVIPMaxBetHistory] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/




