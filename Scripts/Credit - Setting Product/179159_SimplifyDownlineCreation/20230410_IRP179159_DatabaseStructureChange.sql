/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230410@Johnson
	Task: database structure change
	DB: DBCUST/CustDB
*/

CREATE TABLE [dbo].[CustPTTemplate](
	[TemplateID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[custid] [int] NOT NULL,
	[TemplateName] [nvarchar](50) NOT NULL,
	[IsDefault] [bit] NULL
 CONSTRAINT [PK_CustPTTemplate] PRIMARY KEY CLUSTERED 
(
	[TemplateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

CREATE NONCLUSTERED INDEX [IX_custid_templateName] ON [dbo].[CustPTTemplate]
(
	[custid] ASC,
	[TemplateName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO

CREATE TABLE [dbo].[CustPTTemplateDetail](
	[TemplateID] [int] NOT NULL,
	[GroupID] [tinyint] NOT NULL,
	[SubGroupID] [tinyint] NOT NULL,
	[PT] [smallmoney] NOT NULL,
 CONSTRAINT [PK_CustPTTemplateDetail] PRIMARY KEY CLUSTERED 
(
	[TemplateID] ASC,
	[GroupID] ASC,
	[SubGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO


--ALTER TABLE ProductSettingType ALTER COLUMN SettingNameDetail VARCHAR(200)
--GO


---------------------------------------------------------------------
--funtion f_LiteMode_CustSetting_ProductSettingDetailSel need to add replication
ALTER FUNCTION	dbo.f_LiteMode_CustSetting_ProductSettingDetailSel(@SettingType TINYINT = NULL, @CreationStatus TINYINT = 0, @siteid SMALLINT=0, @currency SMALLINT=0)  
RETURNS TABLE
AS
/*
	Created: 20230523@Johnson
	DB: DBCust/CustDB
	Task: Get product setting detail for LiteMode
	Original: f_CustSetting_ProductSettingDetailSel
	
	Revision:
		- 20230523@Johnson: Init function [RedmineID: #179159]

	Param's Explanation:
	SELECT * FROM dbo.f_LiteMode_CustSetting_ProductSettingDetailSel(NULL,3)
*/
RETURN
	SELECT SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel,DisplayOrder
				,SettingStatus,IntervalValue,RealProductId,MaxChoice,ProductSettingID,Parent_ProductSettingID,Child_DisplayOrder,GroupID,GroupType,SubType,CreationStatus
	FROM dbo.ProductSettingProfile WITH(NOLOCK)
	WHERE CreationStatus <= CASE WHEN @CreationStatus = 1 THEN 1
								WHEN @CreationStatus = 0 THEN 0
								ELSE NULL END 
		AND CreationStatus <> 2
		AND (@SettingType IS NULL OR SettingType = @SettingType)
		AND MarketType = 0
	UNION
	SELECT SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel,DisplayOrder
				,SettingStatus,IntervalValue,RealProductId,MaxChoice,p.ProductSettingID,Parent_ProductSettingID,Child_DisplayOrder,GroupID,GroupType,SubType,CreationStatus
	FROM dbo.ProductSettingProfile p WITH(NOLOCK)
		INNER JOIN ProductProfileSiteCurrency s WITH(NOLOCK) ON p.ProductSettingID = s.ProductSettingID
	WHERE CreationStatus <= CASE WHEN @CreationStatus = 1 THEN 1
								WHEN @CreationStatus = 0 THEN 0
								ELSE NULL END 
		AND CreationStatus <> 2
		AND (@SettingType IS NULL OR SettingType = @SettingType)
		AND MarketType = 1
		AND s.SiteID = @SiteID
		AND 1 = CASE WHEN s.currency = @currency OR s.currency = 0 THEN 1 ELSE 0 END	
	UNION
	SELECT SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel,DisplayOrder
				,SettingStatus,IntervalValue,RealProductId,MaxChoice,ProductSettingID,Parent_ProductSettingID,Child_DisplayOrder,GroupID,GroupType,SubType,CreationStatus
	FROM dbo.ProductSettingProfile_UAT WITH(NOLOCK)
	WHERE @CreationStatus = 3
		AND CreationStatus <> 2
		AND (@SettingType IS NULL OR SettingType = @SettingType)
		AND MarketType = 0
	UNION 
	SELECT SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel,DisplayOrder
				,SettingStatus,IntervalValue,RealProductId,MaxChoice,p.ProductSettingID,Parent_ProductSettingID,Child_DisplayOrder,GroupID,GroupType,SubType,CreationStatus
	FROM dbo.ProductSettingProfile_UAT p WITH(NOLOCK)
		INNER JOIN ProductProfileSiteCurrency_UAT s WITH(NOLOCK) ON p.ProductSettingID = s.ProductSettingID
	WHERE @CreationStatus = 3
		AND CreationStatus <> 2
		AND (@SettingType IS NULL OR SettingType = @SettingType)
		AND MarketType = 1
		AND s.SiteID = @SiteID
		AND 1 = CASE WHEN s.currency = @currency OR s.currency = 0 THEN 1 ELSE 0 END
		
GO
-----------------------------------------------------------------

/*
CREATE TABLE [dbo].ProductProfileSiteCurrency(
	[SiteID] [int] NOT NULL,
	[Currency] [int] NOT NULL,
	[ProductSettingID] [int] NOT NULL,
CONSTRAINT [PK_ProductProfileSiteCurrency] PRIMARY KEY CLUSTERED 
(	
	[SiteID] ASC,
	[Currency] ASC,
	[ProductSettingID] ASC	
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO


CREATE TABLE [dbo].ProductProfileSiteCurrency_UAT(
	[SiteID] [int] NOT NULL,
	[Currency] [int] NOT NULL,
	[ProductSettingID] [int] NOT NULL,
CONSTRAINT [PK_ProductProfileSiteCurrency_UAT] PRIMARY KEY CLUSTERED 
(	
	[SiteID] ASC,
	[Currency] ASC,
	[ProductSettingID] ASC	
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO
	
CREATE TABLE [dbo].ProductSettingProfile(
	[ProductSettingID] [int] NOT NULL,
	[SettingType] [smallint] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[ProductID] [tinyint] NOT NULL,
	[MaxPT] [smallmoney] NULL,
	[MaxDiscount] [decimal](9, 8) NULL,
	[IsSync] [bit] NULL,
	[IsHidden] [bit] NULL,
	[IsDisabled] [bit] NULL,
	[SettingLevel] [tinyint] NULL,
	[DisplayOrder] [tinyint] NOT NULL,
	[SettingStatus] [tinyint] NULL,
	[IntervalValue] [decimal](19, 8) NULL,
	[RealProductId] [tinyint] NOT NULL,
	[MaxChoice] [tinyint] NULL,	
	[Parent_ProductSettingID] [int] NULL,
	[Child_DisplayOrder] [int] NULL,
	[SubType] [tinyint] NULL,
	[GroupID] [tinyint] NULL,
	[GroupType] [tinyint] NULL,
	[GroupTypeOrder] [tinyint] NULL,
	[SubGroupID] [tinyint] NULL,
	[SubGroupOrder] [tinyint] NULL,
	[CreationStatus] [tinyint] NULL,
	[DisplayType] [tinyint] NULL,
	[MarketType] [tinyint] NULL,
 CONSTRAINT [PK_ProductSettingProfile] PRIMARY KEY CLUSTERED 
(	
	[ProductSettingID] ASC,
	[SettingType] ASC,
	[SportType] ASC,
	[BetType] ASC,
	[IsLive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA],
) ON [DATA]

GO

ALTER TABLE [dbo].[ProductSettingProfile] ADD  CONSTRAINT [DF_ProductSettingProfile_MaxPT]  DEFAULT ((90)) FOR [MaxPT]
GO

ALTER TABLE [dbo].[ProductSettingProfile] ADD  CONSTRAINT [DF_ProductSettingProfile_MaxDiscount]  DEFAULT ((0.01)) FOR [MaxDiscount]
GO

ALTER TABLE [dbo].[ProductSettingProfile] ADD  CONSTRAINT [DF_ProductSettingProfile_IsSync]  DEFAULT ((0)) FOR [IsSync]
GO

ALTER TABLE [dbo].[ProductSettingProfile] ADD  CONSTRAINT [DF_ProductSettingProfile_IsHidden]  DEFAULT ((1)) FOR [IsHidden]
GO

ALTER TABLE [dbo].[ProductSettingProfile] ADD  CONSTRAINT [DF_ProductSettingProfile_IsDisabled]  DEFAULT ((0)) FOR [IsDisabled]
GO

ALTER TABLE [dbo].[ProductSettingProfile] ADD  CONSTRAINT [DF_ProductSettingProfile_DisplayOrder]  DEFAULT ((0)) FOR [DisplayOrder]
GO

ALTER TABLE [dbo].[ProductSettingProfile] ADD  CONSTRAINT [DF_ProductSettingProfile_SettingStatus]  DEFAULT ((0)) FOR [SettingStatus]
GO

ALTER TABLE [dbo].[ProductSettingProfile] ADD  CONSTRAINT [DF_ProductSettingProfile_CreationStatus]  DEFAULT ((0)) FOR [CreationStatus]
GO

----------------------------------------------

CREATE TABLE [dbo].ProductSettingProfile_UAT(
	[ProductSettingID] [int] NOT NULL,
	[SettingType] [smallint] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[ProductID] [tinyint] NOT NULL,
	[MaxPT] [smallmoney] NULL,
	[MaxDiscount] [decimal](9, 8) NULL,
	[IsSync] [bit] NULL,
	[IsHidden] [bit] NULL,
	[IsDisabled] [bit] NULL,
	[SettingLevel] [tinyint] NULL,
	[DisplayOrder] [tinyint] NOT NULL,
	[SettingStatus] [tinyint] NULL,
	[IntervalValue] [decimal](19, 8) NULL,
	[RealProductId] [tinyint] NOT NULL,
	[MaxChoice] [tinyint] NULL,	
	[Parent_ProductSettingID] [int] NULL,
	[Child_DisplayOrder] [int] NULL,
	[SubType] [tinyint] NULL,
	[GroupID] [tinyint] NULL,
	[GroupType] [tinyint] NULL,
	[GroupTypeOrder] [tinyint] NULL,
	[SubGroupID] [tinyint] NULL,
	[SubGroupOrder] [tinyint] NULL,
	[CreationStatus] [tinyint] NULL,
	[DisplayType] [tinyint] NULL,
	[MarketType] [tinyint] NULL,
 CONSTRAINT [PK_ProductSettingProfile_UAT] PRIMARY KEY CLUSTERED 
(	
	[ProductSettingID] ASC,
	[SettingType] ASC,
	[SportType] ASC,
	[BetType] ASC,
	[IsLive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA],
) ON [DATA]

GO

ALTER TABLE [dbo].[ProductSettingProfile_UAT] ADD  CONSTRAINT [DF_ProductSettingProfile_UAT_MaxPT]  DEFAULT ((90)) FOR [MaxPT]
GO

ALTER TABLE [dbo].[ProductSettingProfile_UAT] ADD  CONSTRAINT [DF_ProductSettingProfile_UAT_MaxDiscount]  DEFAULT ((0.01)) FOR [MaxDiscount]
GO

ALTER TABLE [dbo].[ProductSettingProfile_UAT] ADD  CONSTRAINT [DF_ProductSettingProfile_UAT_IsSync]  DEFAULT ((0)) FOR [IsSync]
GO

ALTER TABLE [dbo].[ProductSettingProfile_UAT] ADD  CONSTRAINT [DF_ProductSettingProfile_UAT_IsHidden]  DEFAULT ((1)) FOR [IsHidden]
GO

ALTER TABLE [dbo].[ProductSettingProfile_UAT] ADD  CONSTRAINT [DF_ProductSettingProfile_UAT_IsDisabled]  DEFAULT ((0)) FOR [IsDisabled]
GO

ALTER TABLE [dbo].[ProductSettingProfile_UAT] ADD  CONSTRAINT [DF_ProductSettingProfile_UAT_DisplayOrder]  DEFAULT ((0)) FOR [DisplayOrder]
GO

ALTER TABLE [dbo].[ProductSettingProfile_UAT] ADD  CONSTRAINT [DF_ProductSettingProfile_UAT_SettingStatus]  DEFAULT ((0)) FOR [SettingStatus]
GO

ALTER TABLE [dbo].[ProductSettingProfile_UAT] ADD  CONSTRAINT [DF_ProductSettingProfile_UAT_CreationStatus]  DEFAULT ((0)) FOR [CreationStatus]
GO
*/


