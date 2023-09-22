/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230727@Helios
	Task: Create New Table Product Profile  [#189389]
	DB: DBCust/CustDB and all replicated server of pub: CustDB_Customer_Info, CustDB_DBTrans_CustInfo
*/


/****** Object:  Table [dbo].[ProductProfileSiteCurrency]    Script Date: 07/27/2023 1:25:21 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].ProductProfileSiteCurrency(
	[SiteID]					[INT]		NOT NULL,
	[Currency]					[INT]		NOT NULL,
	[ProductSettingID]			[INT]		NOT NULL,
CONSTRAINT [PK_ProductProfileSiteCurrency] PRIMARY KEY CLUSTERED 
(	
	[SiteID] ASC,
	[Currency] ASC,
	[ProductSettingID] ASC	
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO


CREATE TABLE [dbo].ProductProfileSiteCurrency_UAT(
	[SiteID]					[INT]		NOT NULL,
	[Currency]					[INT]		NOT NULL,
	[ProductSettingID]			[INT]		NOT NULL,
CONSTRAINT [PK_ProductProfileSiteCurrency_UAT] PRIMARY KEY CLUSTERED 
(	
	[SiteID] ASC,
	[Currency] ASC,
	[ProductSettingID] ASC	
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO
	
CREATE TABLE [dbo].ProductSettingProfile(
	[ProductSettingID]			[int]				NOT NULL,
	[SettingType]				[smallint]			NOT NULL,
	[SportType]					[smallint]			NOT NULL,
	[BetType]					[smallint]			NOT NULL,
	[IsLive]					[bit]				NOT NULL,
	[ProductID]					[tinyint]			NOT NULL,
	[MaxPT]						[smallmoney]		NULL,
	[MaxDiscount]				[decimal](9, 8)		NULL,
	[IsSync]					[bit]				NULL,
	[IsHidden]					[bit]				NULL,
	[IsDisabled]				[bit]				NULL,
	[SettingLevel]				[tinyint]			NULL,
	[DisplayOrder]				[tinyint]			NOT NULL,
	[SettingStatus]				[tinyint]			NULL,
	[IntervalValue]				[decimal](19, 8)	NULL,
	[RealProductId]				[tinyint]			NOT NULL,
	[MaxChoice]					[tinyint]			NULL,	
	[Parent_ProductSettingID]	[int]				NULL,
	[Child_DisplayOrder]		[int]				NULL,
	[SubType]					[tinyint]			NULL,
	[GroupID]					[tinyint]			NULL,
	[GroupType]					[tinyint]			NULL,
	[GroupTypeOrder]			[tinyint]			NULL,
	[SubGroupID]				[tinyint]			NULL,
	[SubGroupOrder]				[tinyint]			NULL,
	[CreationStatus]			[tinyint]			NULL,
	[DisplayType]				[tinyint]			NULL,
	[MarketType]				[tinyint]			NULL,
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
	[ProductSettingID]			[int]				NOT NULL,
	[SettingType]				[smallint]			NOT NULL,
	[SportType]					[smallint]			NOT NULL,
	[BetType]					[smallint]			NOT NULL,
	[IsLive]					[bit]				NOT NULL,
	[ProductID]					[tinyint]			NOT NULL,
	[MaxPT]						[smallmoney]		NULL,
	[MaxDiscount]				[decimal](9, 8)		NULL,
	[IsSync]					[bit]				NULL,
	[IsHidden]					[bit]				NULL,
	[IsDisabled]				[bit]				NULL,
	[SettingLevel]				[tinyint]			NULL,
	[DisplayOrder]				[tinyint]			NOT NULL,
	[SettingStatus]				[tinyint]			NULL,
	[IntervalValue]				[decimal](19, 8)	NULL,
	[RealProductId]				[tinyint]			NOT NULL,
	[MaxChoice]					[tinyint]			NULL,	
	[Parent_ProductSettingID]	[int]				NULL,
	[Child_DisplayOrder]		[int]				NULL,
	[SubType]					[tinyint]			NULL,
	[GroupID]					[tinyint]			NULL,
	[GroupType]					[tinyint]			NULL,
	[GroupTypeOrder]			[tinyint]			NULL,
	[SubGroupID]				[tinyint]			NULL,
	[SubGroupOrder]				[tinyint]			NULL,
	[CreationStatus]			[tinyint]			NULL,
	[DisplayType]				[tinyint]			NULL,
	[MarketType]				[tinyint]			NULL,
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
