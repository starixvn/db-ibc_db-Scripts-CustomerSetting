/*<info serverAlias="IRS_DBAGE-bodb02,IRS_DBBOF-bodb02,IRS_DBACC-bodb02,IRS_DBBAH-bodb02,IRS_DBSIG-CustDB,IRS_DBCTG-CustDB,IRS_DBTP-bodb02,DBCustRepl-ReplCustDB,DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241225@Virgil	
	Task: Customer Setting - Apply In-house replication for profile setting tables
	DB: IRS_DBAGE-bodb02,IRS_DBBOF-bodb02,IRS_DBACC-bodb02,IRS_DBBAH-bodb02,IRS_DBSIG-CustDB,IRS_DBCTG-CustDB,IRS_DBTP-bodb02,DBCustRepl-ReplCustDB
	
	Revisions:
		- 20241225@Virgil: Created [RedmineID: #214117]

	Tables Related:
		ProductProfileSiteCurrency
		ProductProfileSiteCurrency_UAT
		ProductSettingProfile
		ProductSettingProfile_UAT
		ProductStatusProfile
		ProductStatusSiteCurrency
		SportNonOfferedSiteCurrency
*/
CREATE TYPE [dbo].[TVP_ReplProductProfileSiteCurrency] AS TABLE (
	[SiteID] [INT] NOT NULL
	,[Currency] [INT] NOT NULL
	,[ProductSettingID] [INT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplProductProfileSiteCurrency] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplProductProfileSiteCurrency_UAT] AS TABLE (
	[SiteID] [INT] NOT NULL
	,[Currency] [INT] NOT NULL
	,[ProductSettingID] [INT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplProductProfileSiteCurrency_UAT] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplProductSettingProfile] AS TABLE (
	[ProductSettingID] [INT] NOT NULL
	,[SettingType] [SMALLINT] NOT NULL
	,[SportType] [SMALLINT] NOT NULL
	,[BetType] [SMALLINT] NOT NULL
	,[IsLive] [BIT] NOT NULL
	,[ProductID] [TINYINT] NOT NULL
	,[MaxPT] [SMALLMONEY] NULL
	,[MaxDiscount] [DECIMAL](9,8) NULL
	,[IsSync] [BIT] NULL
	,[IsHidden] [BIT] NULL
	,[IsDisabled] [BIT] NULL
	,[SettingLevel] [TINYINT] NULL
	,[DisplayOrder] [TINYINT] NOT NULL
	,[SettingStatus] [TINYINT] NULL
	,[IntervalValue] [DECIMAL](19,8) NULL
	,[RealProductId] [TINYINT] NOT NULL
	,[MaxChoice] [TINYINT] NULL
	,[Parent_ProductSettingID] [INT] NULL
	,[Child_DisplayOrder] [INT] NULL
	,[SubType] [TINYINT] NULL
	,[GroupID] [TINYINT] NULL
	,[GroupType] [TINYINT] NULL
	,[GroupTypeOrder] [TINYINT] NULL
	,[SubGroupID] [TINYINT] NULL
	,[SubGroupOrder] [TINYINT] NULL
	,[CreationStatus] [TINYINT] NULL
	,[DisplayType] [TINYINT] NULL
	,[MarketType] [TINYINT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplProductSettingProfile] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplProductSettingProfile_UAT] AS TABLE (
	[ProductSettingID] [INT] NOT NULL
	,[SettingType] [SMALLINT] NOT NULL
	,[SportType] [SMALLINT] NOT NULL
	,[BetType] [SMALLINT] NOT NULL
	,[IsLive] [BIT] NOT NULL
	,[ProductID] [TINYINT] NOT NULL
	,[MaxPT] [SMALLMONEY] NULL
	,[MaxDiscount] [DECIMAL](9,8) NULL
	,[IsSync] [BIT] NULL
	,[IsHidden] [BIT] NULL
	,[IsDisabled] [BIT] NULL
	,[SettingLevel] [TINYINT] NULL
	,[DisplayOrder] [TINYINT] NOT NULL
	,[SettingStatus] [TINYINT] NULL
	,[IntervalValue] [DECIMAL](19,8) NULL
	,[RealProductId] [TINYINT] NOT NULL
	,[MaxChoice] [TINYINT] NULL
	,[Parent_ProductSettingID] [INT] NULL
	,[Child_DisplayOrder] [INT] NULL
	,[SubType] [TINYINT] NULL
	,[GroupID] [TINYINT] NULL
	,[GroupType] [TINYINT] NULL
	,[GroupTypeOrder] [TINYINT] NULL
	,[SubGroupID] [TINYINT] NULL
	,[SubGroupOrder] [TINYINT] NULL
	,[CreationStatus] [TINYINT] NULL
	,[DisplayType] [TINYINT] NULL
	,[MarketType] [TINYINT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplProductSettingProfile_UAT] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplProductStatusProfile] AS TABLE (
	[Sporttype] [SMALLINT] NOT NULL
	,[Bettype] [SMALLINT] NOT NULL
	,[bitmapOrder] [TINYINT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplProductStatusProfile] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplProductStatusSiteCurrency] AS TABLE (
	[SportType] [SMALLINT] NOT NULL
	,[BetType] [SMALLINT] NOT NULL
	,[Currency] [INT] NOT NULL
	,[SiteID] [INT] NOT NULL
	,[IsHidden] [BIT] NOT NULL
	,[IsDisabled] [BIT] NOT NULL
	,[HasSynced] [BIT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplProductStatusSiteCurrency] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplSportNonOfferedSiteCurrency] AS TABLE (
	[SportType] [SMALLINT] NOT NULL
	,[BetType] [INT] NOT NULL
	,[Currency] [INT] NOT NULL
	,[SiteID] [INT] NOT NULL
	,[RealProductID] [TINYINT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplSportNonOfferedSiteCurrency] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/




