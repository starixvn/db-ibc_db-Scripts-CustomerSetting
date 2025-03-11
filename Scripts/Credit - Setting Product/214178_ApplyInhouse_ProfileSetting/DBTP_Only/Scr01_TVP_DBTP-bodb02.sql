/*<info serverAlias="IRS_DBTP-bodb02,DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241225@Virgil	
	Task: Customer Setting - Apply In-house replication for profile setting tables
	DB: IRS_DBTP-bodb02
	
	Revisions:
		- 20241225@Virgil: Created [RedmineID: #214117]

	Table Related:
		GameLaunchPerCurrency
		GameLaunchPerSite
		ProductGlobalSetting
		ProductLaunchedSiteCurrency
		ProductSettingSystemDisplay
		ProductSettingUpdateRestriction			
*/
CREATE TYPE [dbo].[TVP_ReplGameLaunchPerCurrency] AS TABLE (
	[SportType] [SMALLINT] NOT NULL
	,[BetType] [INT] NOT NULL
	,[Currency] [INT] NOT NULL
	,[IsLaunched] [BIT] NOT NULL
	,[IsTest] [BIT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplGameLaunchPerCurrency] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplGameLaunchPerSite] AS TABLE (
	[SportType] [SMALLINT] NOT NULL
	,[BetType] [INT] NOT NULL
	,[SiteID] [INT] NOT NULL
	,[IsLaunched] [BIT] NOT NULL
	,[IsTest] [BIT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplGameLaunchPerSite] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplProductGlobalSetting] AS TABLE (
	[Sporttype] [SMALLINT] NOT NULL
	,[Bettype] [SMALLINT] NOT NULL
	,[MaxPositiontaking] [SMALLMONEY] NULL
	,[Maxsdiscount] [DECIMAL](9,8) NULL
	,[IsDep] [BIT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplProductGlobalSetting] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplProductLaunchedSiteCurrency] AS TABLE (
	[SiteID] [INT] NOT NULL
	,[Currency] [INT] NOT NULL
	,[SportType] [SMALLINT] NOT NULL
	,[IsLaunched] [BIT] NOT NULL
	,[IsTest] [TINYINT] NOT NULL
	,[BetType] [SMALLINT] NOT NULL
	,[LaunchedLevel] [TINYINT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplProductLaunchedSiteCurrency] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplProductSettingSystemDisplay] AS TABLE (
	[SystemID] [TINYINT] NOT NULL
	,[ProductID] [TINYINT] NOT NULL
	,[SettingType] [SMALLINT] NOT NULL
	,[DisplayMode] [TINYINT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplProductSettingSystemDisplay] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplProductSettingUpdateRestriction] AS TABLE (
	[SystemID] [TINYINT] NOT NULL
	,[ProductID] [TINYINT] NOT NULL
	,[SettingType] [SMALLINT] NOT NULL
	,[ActorRoleID] [TINYINT] NOT NULL
	,[TargetRoleID] [TINYINT] NOT NULL
	,[ErrCode] [INT] NULL
	,[RestrictionMode] [TINYINT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplProductSettingUpdateRestriction] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/




