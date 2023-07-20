/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230410@Johnson
	Task: database structure change
	DB: DBCUST/CustDB
*/

ALTER TABLE ProductSettingType ALTER COLUMN SettingNameDetail VARCHAR(200)
GO
/*
ALTER TABLE ProductSettingDetail ADD GroupID TINYINT, GroupType	TINYINT, GroupTypeOrder	TINYINT, SubGroupID	TINYINT,SubGroupOrder	TINYINT,CreationStatus	TINYINT, DisplayType	TINYINT

ALTER TABLE ProductSettingDetail_UAT ADD GroupID TINYINT, GroupType	TINYINT, GroupTypeOrder	TINYINT, SubGroupID	TINYINT,SubGroupOrder	TINYINT,CreationStatus	TINYINT, DisplayType	TINYINT
GO
*/
CREATE TABLE [dbo].ProductProfileSiteCurrency(
	[SiteID] [smallint] NOT NULL,
	[Currency] [smallint] NOT NULL,
	[ProductSettingID] [int] NOT NULL,
CONSTRAINT [PK_ProductProfileSiteCurrency] PRIMARY KEY CLUSTERED 
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

