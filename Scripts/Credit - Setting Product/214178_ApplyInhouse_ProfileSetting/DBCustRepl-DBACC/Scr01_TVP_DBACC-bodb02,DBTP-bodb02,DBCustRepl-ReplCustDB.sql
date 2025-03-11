/*<info serverAlias="IRS_DBACC-bodb02,IRS_DBTP-bodb02,DBCustRepl-ReplCustDB,DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241225@Virgil	
	Task: Customer Setting - Apply In-house replication for profile setting tables
	DB: IRS_DBACC-bodb02,IRS_DBTP-bodb02,DBCustRepl-ReplCustDB
	
	Revisions:
		- 20241225@Virgil: Created [RedmineID: #214117]

	Table Related:
		CategoryConfig
		GameGroup
		ProductBetSetting
		StakeLevel
		StakeLevelGroupDetail
		PlayCurrencySetting

*/
CREATE TYPE [dbo].[TVP_ReplCategoryConfig] AS TABLE (
	[CategoryID] [INT] NOT NULL
	,[CategoryName] [VARCHAR](100) NULL
	,[OfferDeposit] [BIT] NULL
	,[CategoryNameCS] [NVARCHAR](100) NULL
	,[CustomerClass] [INT] NULL
	,[HiddenSite] [TINYINT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCategoryConfig] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplGameGroup] AS TABLE (
	[GameGroupID] [INT] NOT NULL
	,[RefSportType] [SMALLINT] NOT NULL
	,[RefBetType] [INT] NOT NULL
	,[GroupName] [NVARCHAR](100) NULL
	,[IsDeposit] [BIT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplGameGroup] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplProductBetSetting] AS TABLE (
	[Sporttype] [SMALLINT] NOT NULL
	,[Bettype] [SMALLINT] NOT NULL
	,[Currency] [TINYINT] NOT NULL
	,[MinBet] [MONEY] NULL
	,[IsDep] [BIT] NULL
	,[MaxBet] [MONEY] NULL
	,[MaxPerMatch] [MONEY] NULL
	,[DefaultMinBet] [MONEY] NULL
	,[DefaultMaxBet] [MONEY] NULL
	,[DefaultMaxPerMatch] [MONEY] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplProductBetSetting] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplStakeLevel] AS TABLE (
	[StakeLevelID] [INT] NOT NULL
	,[GameTypeID] [INT] NULL
	,[MinLabel] [NVARCHAR](50) NULL
	,[MaxLabel] [NVARCHAR](50) NULL
	,[MinStake] [DECIMAL](19,8) NULL
	,[MaxStake] [DECIMAL](19,8) NULL
	,[ExchangeId] [INT] NULL
	,[ResourceId] [VARCHAR](20) NULL
	,[GameGroupID] [INT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplStakeLevel] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplStakeLevelGroupDetail] AS TABLE (
	[StakeLevelID] [INT] NOT NULL
	,[GameTypeID] [INT] NOT NULL
	,[MinLabel] [NVARCHAR](50) NULL
	,[MaxLabel] [NVARCHAR](50) NULL
	,[MinStake] [DECIMAL](19,8) NULL
	,[MaxStake] [DECIMAL](19,8) NULL
	,[ParentTypeID] [INT] NULL
	,[MaxGameStake] [DECIMAL](19,8) NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplStakeLevelGroupDetail] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplPlayCurrencySetting] AS TABLE (
	[ID] [INT] NOT NULL
	,[SiteId] [INT] NULL
	,[SiteName] [NVARCHAR](50) NULL
	,[SportType] [INT] NULL
	,[MemberCurrency] [INT] NULL
	,[PlayCurrency] [INT] NULL
	,[FromDate] [DATE] NULL
	,[ToDate] [DATE] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplPlayCurrencySetting] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/




