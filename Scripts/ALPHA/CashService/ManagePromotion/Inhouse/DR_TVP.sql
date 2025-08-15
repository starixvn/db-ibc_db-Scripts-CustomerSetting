/*<info serverAlias="DBCUST-AgencyCashService" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250714@Johnson	
	Task: In-House
	DB: DBCUST-AgencyCashService
	
	Revisions:
		- 20250714@Johnson: Created [RedmineID: #232347]

	Example:			
*/
CREATE TYPE [dbo].[TVP_ReplCashPromotion] AS TABLE (
	[PromotionID] [INT] NOT NULL
	,[SiteDBGroupID] [SMALLINT] NOT NULL
	,[AgentID] [INT] NOT NULL
	,[Type] [TINYINT] NOT NULL
	,[FromDate] [DATE] NOT NULL
	,[ToDate] [DATE] NOT NULL
	,[Enabled] [BIT] NOT NULL
	,[IsSoftDeleted] [BIT] NOT NULL
	,[ModifiedDate] [DATETIME] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCashPromotion] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplCashPromotionDetail] AS TABLE (
	[PromotionID] [INT] NOT NULL
	,[SiteDBGroupID] [SMALLINT] NOT NULL
	,[ProductCategoryID] [TINYINT] NOT NULL
	,[ProductList] [VARCHAR](MAX) NOT NULL
	,[Percentage] [SMALLMONEY] NULL
	,[MaxPayout] [MONEY] NULL
	,[MinValue] [MONEY] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCashPromotionDetail] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplCashPromotionLanguage] AS TABLE (
	[PromotionID] [INT] NOT NULL
	,[SiteDBGroupID] [SMALLINT] NOT NULL
	,[LanguageCode] [VARCHAR](10) NOT NULL
	,[Title] [NVARCHAR](200) NULL
	,[Content] [NVARCHAR](MAX) NULL
	,[Banner] [VARCHAR](1000) NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCashPromotionLanguage] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/




