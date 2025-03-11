/*<info serverAlias="DBCustRepl-ReplCustDB"></info>*/
/*
	Created: 20241230@Virgil	
	Task: Customer Setting - Apply In-house replication for profile setting tables
	DB: DBCustRepl-ReplCustDB
	
	Revisions:
		- 20241230@Virgil: Created [RedmineID: #214117]

	Table Related: 
		ProductSiteConfig
		ProductProfileSiteCurrency
		ProductProfileSiteCurrency_UAT
		ProductSettingProfile
		ProductSettingProfile_UAT
		ProductStatusProfile
		ProductStatusSiteCurrency
		SportNonOfferedSiteCurrency	
		CategoryConfig
		GameGroup
		ProductBetSetting
		StakeLevel
		StakeLevelGroupDetail
		PlayCurrencySetting
*/

USE [ReplCustDB]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-----------------[ProductSiteConfig]-----------------
CREATE TABLE [dbo].[ProductSiteConfig](
	[SiteID] [int] NOT NULL,
	[ProductID] [tinyint] NOT NULL,
	[RefProductID] [tinyint] NOT NULL,
	[AffectedDate] [date] NOT NULL,
	[Environment] [tinyint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [BIT] NULL
 CONSTRAINT [PK_ProductSiteConfig] PRIMARY KEY CLUSTERED 
(
	[SiteID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[ProductSiteConfig] ADD  CONSTRAINT [DF_ProductSiteConfig_AffectedDate]  DEFAULT (CONVERT([date],getdate())) FOR [AffectedDate]
GO

ALTER TABLE [dbo].[ProductSiteConfig] ADD  CONSTRAINT [DF_ProductSiteConfig_Environment]  DEFAULT ((1)) FOR [Environment]
GO

ALTER TABLE [dbo].[ProductSiteConfig] ADD  CONSTRAINT [DF_ProductSiteConfig_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

-----------------[ProductProfileSiteCurrency]-----------------
CREATE TABLE [dbo].[ProductProfileSiteCurrency](
	[SiteID] [int] NOT NULL,
	[Currency] [int] NOT NULL,
	[ProductSettingID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [BIT] NULL
 CONSTRAINT [PK_ProductProfileSiteCurrency] PRIMARY KEY CLUSTERED 
(
	[SiteID] ASC,
	[Currency] ASC,
	[ProductSettingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[ProductProfileSiteCurrency] ADD  CONSTRAINT [DF_ProductProfileSiteCurrency_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

-----------------[ProductProfileSiteCurrency_UAT]-----------------
CREATE TABLE [dbo].[ProductProfileSiteCurrency_UAT](
	[SiteID] [int] NOT NULL,
	[Currency] [int] NOT NULL,
	[ProductSettingID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [BIT] NULL
 CONSTRAINT [PK_ProductProfileSiteCurrency_UAT] PRIMARY KEY CLUSTERED 
(
	[SiteID] ASC,
	[Currency] ASC,
	[ProductSettingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[ProductProfileSiteCurrency_UAT] ADD  CONSTRAINT [DF_ProductProfileSiteCurrency_UAT_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

-----------------[ProductSettingProfile]-----------------
CREATE TABLE [dbo].[ProductSettingProfile](
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
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [BIT] NULL
 CONSTRAINT [PK_ProductSettingProfile] PRIMARY KEY NONCLUSTERED 
(
	[ProductSettingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
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

ALTER TABLE [dbo].[ProductSettingProfile] ADD  CONSTRAINT [DF_ProductSettingProfile_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

-----------------[ProductSettingProfile_UAT]-----------------
CREATE TABLE [dbo].[ProductSettingProfile_UAT](
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
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [BIT] NULL
 CONSTRAINT [PK_ProductSettingProfile_UAT] PRIMARY KEY NONCLUSTERED 
(
	[ProductSettingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
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

ALTER TABLE [dbo].[ProductSettingProfile_UAT] ADD  CONSTRAINT [DF_ProductSettingProfile_UAT_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

-----------------[ProductStatusProfile]-----------------
CREATE TABLE [dbo].[ProductStatusProfile](
	[Sporttype] [smallint] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[bitmapOrder] [tinyint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [BIT] NULL
 CONSTRAINT [PK_ProductStatusProfile] PRIMARY KEY CLUSTERED 
(
	[Sporttype] ASC,
	[Bettype] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[ProductStatusProfile] ADD  CONSTRAINT [DF_ProductStatusProfile_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

-----------------[ProductStatusSiteCurrency]-----------------
CREATE TABLE [dbo].[ProductStatusSiteCurrency](
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[Currency] [int] NOT NULL,
	[SiteID] [int] NOT NULL,
	[IsHidden] [bit] NOT NULL,
	[IsDisabled] [bit] NOT NULL,
	[HasSynced] [bit] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [BIT] NULL
 CONSTRAINT [PK_ProductStatusSiteCurrency] PRIMARY KEY CLUSTERED 
(
	[SportType] ASC,
	[BetType] ASC,
	[Currency] ASC,
	[SiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[ProductStatusSiteCurrency] ADD  DEFAULT ((1)) FOR [HasSynced]
GO

ALTER TABLE [dbo].[ProductStatusSiteCurrency] ADD  CONSTRAINT [DF_ProductStatusSiteCurrency_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

-----------------[SportNonOfferedSiteCurrency]-----------------
CREATE TABLE [dbo].[SportNonOfferedSiteCurrency](
	[SportType] [smallint] NOT NULL,
	[BetType] [int] NOT NULL,
	[Currency] [int] NOT NULL,
	[SiteID] [int] NOT NULL,
	[RealProductID] [tinyint] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [BIT] NULL
 CONSTRAINT [PK_SportNonOfferedSiteCurrency] PRIMARY KEY CLUSTERED 
(
	[SportType] ASC,
	[BetType] ASC,
	[Currency] ASC,
	[SiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[SportNonOfferedSiteCurrency] ADD  CONSTRAINT [DF_SportNonOfferedSiteCurrency_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

-----------------[CategoryConfig]--------------------
CREATE TABLE [dbo].[CategoryConfig](
	[CategoryID] [int] NOT NULL,
	[CategoryName] [varchar](100) NULL,
	[OfferDeposit] [bit] NULL,
	[CategoryNameCS] [nvarchar](100) NULL,
	[CustomerClass] [int] NULL,
	[HiddenSite] [tinyint] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [BIT] NULL
 CONSTRAINT [PK_CategoryConfig] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[CategoryConfig] ADD CONSTRAINT [DF_CategoryConfig_HiddenSite] DEFAULT ((0)) FOR [HiddenSite]
GO

ALTER TABLE [dbo].[CategoryConfig] ADD CONSTRAINT [DF_CategoryConfig_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

-----------------[GameGroup]--------------------
CREATE TABLE [dbo].[GameGroup](
	[GameGroupID] [int] NOT NULL,
	[RefSportType] [smallint] NOT NULL,
	[RefBetType] [int] NOT NULL,
	[GroupName] [nvarchar](100) NULL,
	[IsDeposit] [bit] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [BIT] NULL
 CONSTRAINT [PK_GameGroup] PRIMARY KEY CLUSTERED 
(
	[GameGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[GameGroup] ADD  CONSTRAINT [DF_GameGroup_RefSportType]  DEFAULT ((0)) FOR [RefSportType]
GO

ALTER TABLE [dbo].[GameGroup] ADD  CONSTRAINT [DF_GameGroup_RefBetType]  DEFAULT ((0)) FOR [RefBetType]
GO

ALTER TABLE [dbo].[GameGroup] ADD  DEFAULT ((0)) FOR [IsDeposit]
GO

ALTER TABLE [dbo].[GameGroup] ADD  CONSTRAINT [DF_GameGroup_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

-----------------[ProductBetSetting]--------------------
CREATE TABLE [dbo].[ProductBetSetting](
	[Sporttype] [smallint] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[Currency] [tinyint] NOT NULL,
	[MinBet] [money] NULL,
	[IsDep] [bit] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[DefaultMinBet] [money] NULL,
	[DefaultMaxBet] [money] NULL,
	[DefaultMaxPerMatch] [money] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [BIT] NULL
 CONSTRAINT [PK_ProductBetSetting] PRIMARY KEY CLUSTERED 
(
	[Sporttype] ASC,
	[Bettype] ASC,
	[Currency] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[ProductBetSetting] ADD  CONSTRAINT [DF_ProductBetSetting_Minbet]  DEFAULT ((0)) FOR [MinBet]
GO

ALTER TABLE [dbo].[ProductBetSetting] ADD  CONSTRAINT [DF_ProductBetSetting_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO


-----------------[StakeLevel]--------------------
CREATE TABLE [dbo].[StakeLevel](
	[StakeLevelID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[GameTypeID] [int] NULL,
	[MinLabel] [nvarchar](50) NULL,
	[MaxLabel] [nvarchar](50) NULL,
	[MinStake] [decimal](19, 8) NULL,
	[MaxStake] [decimal](19, 8) NULL,
	[ExchangeId] [int] NULL,
	[ResourceId] [varchar](20) NULL,
	[GameGroupID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [BIT] NULL
 CONSTRAINT [PK_StakeLevel] PRIMARY KEY CLUSTERED 
(
	[StakeLevelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[StakeLevel] ADD  CONSTRAINT [DF_StakeLevel_GameGroupID]  DEFAULT ((0)) FOR [GameGroupID]
GO

ALTER TABLE [dbo].[StakeLevel] ADD  CONSTRAINT [DF_StakeLevel_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

-----------------[StakeLevelGroupDetail]--------------------
CREATE TABLE [dbo].[StakeLevelGroupDetail](
	[StakeLevelID] [int] NOT NULL,
	[GameTypeID] [int] NOT NULL,
	[MinLabel] [nvarchar](50) NULL,
	[MaxLabel] [nvarchar](50) NULL,
	[MinStake] [decimal](19, 8) NULL,
	[MaxStake] [decimal](19, 8) NULL,
	[ParentTypeID] [int] NULL,
	[MaxGameStake] [decimal](19, 8) NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [BIT] NULL
 CONSTRAINT [PK_StakeLevelGroupDetail] PRIMARY KEY CLUSTERED 
(
	[StakeLevelID] ASC,
	[GameTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[StakeLevelGroupDetail] ADD  CONSTRAINT [DF_StakeLevelGroupDetail_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

-----------------[PlayCurrencySetting]--------------------
CREATE TABLE [dbo].[PlayCurrencySetting](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SiteId] [int] NULL,
	[SiteName] [nvarchar](50) NULL,
	[SportType] [int] NULL,
	[MemberCurrency] [int] NULL,
	[PlayCurrency] [int] NULL,
	[FromDate] [date] NULL,
	[ToDate] [date] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [BIT] NULL
 CONSTRAINT [PK_PlayCurrencySetting] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[PlayCurrencySetting] ADD  CONSTRAINT [DF_PlayCurrencySetting_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO