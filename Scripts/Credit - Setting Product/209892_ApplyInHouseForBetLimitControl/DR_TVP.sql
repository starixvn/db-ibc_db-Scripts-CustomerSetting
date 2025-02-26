/*<info serverAlias="DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20240913@Johnson	
	Task: In-House
	DB: DBCUST-CustDB
	
	Revisions:
		- 20240913@Johnson: Created [RedmineID: #209892]

	Example:			
*/
CREATE TYPE [dbo].[TVP_ReplBetLimitControlCustSetting] AS TABLE (
	[CustID] [INT] NOT NULL
	,[BetLimitTypeID] [INT] NOT NULL
	,[MaxBet] [MONEY] NULL
	,[MaxPerMatch] [MONEY] NULL
	,[Mode] [TINYINT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplBetLimitControlCustSetting] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplBetLimitControlDefaultSetting] AS TABLE (
	[CustID] [INT] NOT NULL
	,[BetLimitTypeID] [INT] NOT NULL
	,[MaxBet] [MONEY] NULL
	,[MaxPerMatch] [MONEY] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplBetLimitControlDefaultSetting] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplBetLimitControlProduct] AS TABLE (
	[ProductID] [TINYINT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplBetLimitControlProduct] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplBetLimitControlType] AS TABLE (
	[BetLimitTypeID] [INT] NOT NULL
	,[BetLimitType] [VARCHAR](50) NOT NULL
	,[BeginTime] [TIME] NULL
	,[EndTime] [TIME] NULL
	,[LiveIndicator] [TINYINT] NOT NULL
	,[RestrictVIP] [BIT] NOT NULL
	,[ExcludedLeagueGroupList] [VARCHAR](4000) NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplBetLimitControlType] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplBetLimitControlTypeDetails] AS TABLE (
	[ID] [INT] NOT NULL
	,[BetLimitTypeID] [INT] NOT NULL
	,[ProductID] [TINYINT] NOT NULL
	,[Sporttype] [SMALLINT] NOT NULL
	,[Bettype] [SMALLINT] NOT NULL
	,[LeagueGroupID] [INT] NOT NULL
	,[LeagueID] [INT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplBetLimitControlTypeDetails] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplBetRestriction_Currency] AS TABLE (
	[ExchangeID] [INT] NOT NULL
	,[Type] [TINYINT] NOT NULL
	,[SportType] [SMALLINT] NOT NULL
	,[LiveBetAccept] [SMALLINT] NULL
	,[SeizeBetTicket] [TINYINT] NULL
	,[FollowAccount] [INT] NULL
	,[AccumulateBalance] [BIT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplBetRestriction_Currency] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplBetRestriction_Customer] AS TABLE (
	[CustID] [INT] NOT NULL
	,[SportType] [SMALLINT] NOT NULL
	,[LiveBetAccept] [SMALLINT] NULL
	,[SeizeBetTicket] [TINYINT] NULL
	,[MaxBet] [MONEY] NULL
	,[MaxPerMatch] [MONEY] NULL
	,[FollowAccount] [INT] NULL
	,[LeagueGroupID] [VARCHAR](4000) NULL
	,[AccumulateBalance] [BIT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplBetRestriction_Customer] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplBetRestriction_Setting] AS TABLE (
	[SettingID] [SMALLINT] NOT NULL
	,[SportType] [SMALLINT] NOT NULL
	,[RestrictionLevel] [VARCHAR](30) NOT NULL
	,[IsLicensee] [BIT] NOT NULL
	,[BackEndStatus] [TINYINT] NOT NULL
	,[LiveBetAcceptStatus] [BIT] NOT NULL
	,[SeizeBetTicketStatus] [BIT] NOT NULL
	,[BetLimitStatus] [BIT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplBetRestriction_Setting] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplBetRestriction_Site] AS TABLE (
	[SiteID] [INT] NOT NULL
	,[SportType] [SMALLINT] NOT NULL
	,[LiveBetAccept] [SMALLINT] NULL
	,[SeizeBetTicket] [TINYINT] NULL
	,[FollowAccount] [INT] NULL
	,[AccumulateBalance] [BIT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplBetRestriction_Site] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/




