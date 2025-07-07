/*<info serverAlias="DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250714@Johnson	
	Task: In-House
	DB: DBCustRepl-ReplCustDB
	
	Revisions:
		- 20250714@Johnson: Created [RedmineID: #232347]

	Example:			
*/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CashPromotion')
BEGIN
	CREATE TABLE [dbo].[CashPromotion]
	(
		[PromotionID] [INT] IDENTITY(1,1) NOT NULL
		,[SiteDBGroupID] [SMALLINT] NOT NULL
		,[AgentID] [INT] NOT NULL
		,[Type] [TINYINT] NOT NULL
		,[FromDate] [DATE] NOT NULL
		,[ToDate] [DATE] NOT NULL
		,[Enabled] [BIT] NOT NULL
		,[IsSoftDeleted] [BIT] NOT NULL
		,[ModifiedDate] [DATETIME] NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_CashPromotion] PRIMARY KEY CLUSTERED ([PromotionID],[SiteDBGroupID]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[CashPromotion] ADD CONSTRAINT [DF_CashPromotion_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[CashPromotion] ADD CONSTRAINT [DF_CashPromotion_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
	
	CREATE NONCLUSTERED INDEX [IX_CashPromotion_RepUpdateTime] ON [dbo].[CashPromotion] 
	(
	  [RepUpdateTime] ASC
	)ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CashPromotion exists!!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CashPromotionDetail')
BEGIN
	CREATE TABLE [dbo].[CashPromotionDetail]
	(
		[PromotionID] [INT] NOT NULL
		,[SiteDBGroupID] [SMALLINT] NOT NULL
		,[ProductCategoryID] [TINYINT] NOT NULL
		,[ProductList] [VARCHAR](MAX) NOT NULL
		,[Percentage] [SMALLMONEY] NULL
		,[MaxPayout] [MONEY] NULL
		,[MinValue] [MONEY] NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_CashPromotionDetail] PRIMARY KEY CLUSTERED ([PromotionID],[SiteDBGroupID],[ProductCategoryID]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[CashPromotionDetail] ADD CONSTRAINT [DF_CashPromotionDetail_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[CashPromotionDetail] ADD CONSTRAINT [DF_CashPromotionDetail_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
	
	CREATE NONCLUSTERED INDEX [IX_CashPromotionDetail_RepUpdateTime] ON [dbo].[CashPromotionDetail] 
	(
	  [RepUpdateTime] ASC
	)ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CashPromotionDetail exists!!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CashPromotionLanguage')
BEGIN
	CREATE TABLE [dbo].[CashPromotionLanguage]
	(
		[PromotionID] [INT] NOT NULL
		,[SiteDBGroupID] [SMALLINT] NOT NULL
		,[LanguageCode] [VARCHAR](10) NOT NULL
		,[Title] [NVARCHAR](200) NULL
		,[Content] [NVARCHAR](MAX) NULL
		,[Banner] [VARCHAR](1000) NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_CashPromotionLanguage] PRIMARY KEY CLUSTERED ([PromotionID],[SiteDBGroupID],[LanguageCode]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[CashPromotionLanguage] ADD CONSTRAINT [DF_CashPromotionLanguage_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[CashPromotionLanguage] ADD CONSTRAINT [DF_CashPromotionLanguage_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
	
	CREATE NONCLUSTERED INDEX [IX_CashPromotionLanguage_RepUpdateTime] ON [dbo].[CashPromotionLanguage] 
	(
	  [RepUpdateTime] ASC
	)ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CashPromotionLanguage exists!!!'
END
GO
/***************************************************************************/




