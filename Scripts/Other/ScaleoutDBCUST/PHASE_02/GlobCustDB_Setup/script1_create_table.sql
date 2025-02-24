/*<info serverAlias="DBGLOB-GlobCustDB" executers="" viewers="" isFunction="0"></info>*/
/*
	Created: DaveTruong
	Date: 20250120
	Task: Create table ScaleOut Custsetting on  GlobCustDB [RedmineID:#217137]
	DB: DBGLOB/GlobCustDB
*/


USE [GlobCustDB]
GO

IF OBJECT_ID('MsgError', 'V') IS NOT NULL
    DROP VIEW MsgError;
GO

/****** Object:  Table [dbo].[Acc_SuperPrefix]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Acc_SuperPrefix](
	[GroupName] [varchar](50) NOT NULL,
	[Prefix] [varchar](10) NOT NULL,
	[AllowNewSuper] [bit] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_AccSuperPrefix] PRIMARY KEY NONCLUSTERED 
(
	[GroupName] ASC,
	[Prefix] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[Acc_SuperPrefix] ADD  CONSTRAINT [DF_Acc_SuperPrefix_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE NONCLUSTERED INDEX [IX_Acc_SuperPrefix_RepUpdateTime] ON [dbo].[Acc_SuperPrefix]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO


/****** Object:  Table [dbo].[CategoryConfig]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryConfig](
	[CategoryID] [int] NOT NULL,
	[CategoryName] [varchar](100) NULL,
	[OfferDeposit] [bit] NULL,
	[CategoryNameCS] [nvarchar](100) NULL,
	[CustomerClass] [int] NULL,
	[HiddenSite] [tinyint] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_CategoryConfig] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[CategoryConfig] ADD  DEFAULT ((0)) FOR [HiddenSite]
GO
ALTER TABLE [dbo].[CategoryConfig] ADD  CONSTRAINT [DF_CategoryConfig_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
CREATE NONCLUSTERED INDEX [IX_CategoryConfig_RepUpdateTime] ON [dbo].[CategoryConfig]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/****** Object:  Table [dbo].[DangerLevelPolicy]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DangerLevelPolicy](
	[SportType] [tinyint] NOT NULL,
	[DangerLevel] [tinyint] NOT NULL,
	[ActionType] [tinyint] NOT NULL,
	[Value] [decimal](9, 2) NOT NULL,
	[LeagueGroupID] [smallint] NOT NULL,
 CONSTRAINT [PK_DangerLevelPolicy] PRIMARY KEY CLUSTERED 
(
	[SportType] ASC,
	[DangerLevel] ASC,
	[ActionType] ASC,
	[LeagueGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[DangerLevelPolicy] ADD  CONSTRAINT [DF_DangerLevelPolicy_LeagueGroupID]  DEFAULT ((0)) FOR [LeagueGroupID]
GO

/****** Object:  Table [dbo].[GameRoundBetLimitSettings]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameRoundBetLimitSettings](
	[SportType] [smallint] NOT NULL,
	[BetType] [int] NOT NULL,
	[ProductID] [tinyint] NULL,
	[GameRoundBetLimit] [money] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_GameRoundBetLimitSettings] PRIMARY KEY CLUSTERED 
(
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[GameRoundBetLimitSettings] ADD  CONSTRAINT [DF_GameRoundBetLimitSettings_GameRoundBetLimit]  DEFAULT ((0)) FOR [GameRoundBetLimit]
GO
ALTER TABLE [dbo].[GameRoundBetLimitSettings] ADD  CONSTRAINT [DF_GameRoundBetLimitSettings_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
CREATE NONCLUSTERED INDEX [IX_GameRoundBetLimitSettings_RepUpdateTime] ON [dbo].[GameRoundBetLimitSettings]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/****** Object:  Table [dbo].[Initial_ProductConfig]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Initial_ProductConfig](
	[ConfigID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [tinyint] NOT NULL,
	[SportTypeList] [varchar](300) NOT NULL,
	[BetTypeList] [varchar](300) NOT NULL,
	[Site] [varchar](max) NOT NULL,
	[Currency] [varchar](max) NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NULL,
	[IsTest] [bit] NOT NULL,
	[Status] [tinyint] NULL,
	[CurrentStep] [tinyint] NULL,
	[ProcessedStep] [varchar](500) NULL,
	[Remark] [varchar](1000) NULL,
 CONSTRAINT [PK_Initial_ProductConfig] PRIMARY KEY CLUSTERED 
(
	[ConfigID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA] TEXTIMAGE_ON [DATA]
GO
/****** Object:  Table [dbo].[Initial_ProductConfig_Detail]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Initial_ProductConfig_Detail](
	[ConfigID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[SettingType] [tinyint] NOT NULL,
	[IsDefault] [bit] NOT NULL,
	[CopyFromSportType] [smallint] NULL,
	[CopyFromBetType] [smallint] NULL,
	[DefaultValueSuper] [decimal](11, 8) NULL,
	[DefaultValueMaster] [decimal](11, 8) NULL,
	[DefaultValueAgent] [decimal](11, 8) NULL,
	[DefaultValueMember] [decimal](11, 8) NULL,
	[SpecialRequirement] [varchar](max) NULL,
 CONSTRAINT [PK_Initial_ProductConfig_Detail] PRIMARY KEY CLUSTERED 
(
	[ConfigID] ASC,
	[SportType] ASC,
	[BetType] ASC,
	[IsLive] ASC,
	[SettingType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA] TEXTIMAGE_ON [DATA]
GO
/****** Object:  Table [dbo].[Initial_StepByConfig]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Initial_StepByConfig](
	[StepID] [tinyint] NOT NULL,
	[IsScanCustomer] [bit] NULL,
	[SortOrder] [tinyint] IDENTITY(1,1) NOT NULL
) ON [DATA]
GO

/****** Object:  Table [dbo].[MsgError]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MsgError](
	[MsgID] [int] NOT NULL,
	[MsgGroupID] [int] NOT NULL,
	[MsgNameEN] [nvarchar](500) NOT NULL,
	[MsgNameCT] [nvarchar](500) NULL,
	[MsgNameCS] [nvarchar](500) NULL,
	[MsgNameJP] [nvarchar](500) NULL,
	[MsgNameTH] [nvarchar](500) NULL,
	[MsgNameKO] [nvarchar](500) NULL,
	[MsgNameES] [nvarchar](500) NULL,
	[MsgNameVI] [nvarchar](500) NULL,
	[IsActive] [bit] NOT NULL,
	[MsgNameCN] [nvarchar](500) NULL,
	[MsgNameIN] [nvarchar](500) NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_MsgError] PRIMARY KEY CLUSTERED 
(
	[MsgID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[MsgError] ADD  CONSTRAINT [DF_MsgError_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
CREATE NONCLUSTERED INDEX [IX_MsgError_RepUpdateTime] ON [dbo].[MsgError]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/****** Object:  Table [dbo].[MsgErrorGroup]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MsgErrorGroup](
	[MsgGroupID] [int] NOT NULL,
	[MsgGroupName] [nvarchar](100) NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_MsgErrorGroup] PRIMARY KEY CLUSTERED 
(
	[MsgGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[MsgErrorGroup] ADD  CONSTRAINT [DF_MsgErrorGroup_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
CREATE NONCLUSTERED INDEX [IX_MsgErrorGroup_RepUpdateTime] ON [dbo].[MsgErrorGroup]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO

/****** Object:  Table [dbo].[ProblemAccountReason]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProblemAccountReason](
	[ReasonID] [tinyint] NOT NULL,
	[ReasonName] [varchar](100) NOT NULL,
	[IsCN88] [bit] NOT NULL,
	[IsCredit] [bit] NOT NULL,
	[IsLicensee] [bit] NOT NULL,
	[ReasonNameCS] [nvarchar](100) NULL,
	[ReasonGroupID] [tinyint] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_ProblemAccountReason] PRIMARY KEY CLUSTERED 
(
	[ReasonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[ProblemAccountReason] ADD  CONSTRAINT [DF_ProblemAccountReason_IsCN88]  DEFAULT ((0)) FOR [IsCN88]
GO
ALTER TABLE [dbo].[ProblemAccountReason] ADD  CONSTRAINT [DF_ProblemAccountReason_IsCredit]  DEFAULT ((0)) FOR [IsCredit]
GO
ALTER TABLE [dbo].[ProblemAccountReason] ADD  CONSTRAINT [DF_ProblemAccountReason_IsLicensee]  DEFAULT ((0)) FOR [IsLicensee]
GO

CREATE NONCLUSTERED INDEX [IX_ProblemAccountReason_RepUpdateTime] ON [dbo].[ProblemAccountReason]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO

/****** Object:  Table [dbo].[ProductGlobalSetting]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductGlobalSetting](
	[Sporttype] [smallint] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[MaxPositiontaking] [smallmoney] NULL,
	[Maxsdiscount] [decimal](9, 8) NULL,
	[IsDep] [bit] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_ProductGlobalSetting] PRIMARY KEY CLUSTERED 
(
	[Sporttype] ASC,
	[Bettype] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[ProductGlobalSetting] ADD  CONSTRAINT [DF_ProductGlobalSetting_MaxPositiontaking]  DEFAULT ((0)) FOR [MaxPositiontaking]
GO
ALTER TABLE [dbo].[ProductGlobalSetting] ADD  CONSTRAINT [DF_ProductGlobalSetting_Maxsdiscount]  DEFAULT ((0)) FOR [Maxsdiscount]
GO
ALTER TABLE [dbo].[ProductGlobalSetting] ADD  CONSTRAINT [DF_ProductGlobalSetting_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
CREATE NONCLUSTERED INDEX [IX_ProductGlobalSetting_RepUpdateTime] ON [dbo].[ProductGlobalSetting]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/****** Object:  Table [dbo].[ProductLaunchedSiteCurrency]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductLaunchedSiteCurrency](
	[SiteID] [int] NOT NULL,
	[Currency] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[IsLaunched] [bit] NOT NULL,
	[IsTest] [tinyint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[LaunchedLevel] [tinyint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_ProductLaunchedSiteCurrency] PRIMARY KEY CLUSTERED 
(
	[SiteID] ASC,
	[Currency] ASC,
	[SportType] ASC,
	[BetType] ASC,
	[LaunchedLevel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[ProductLaunchedSiteCurrency] ADD  CONSTRAINT [DF_ProductLaunchedSiteCurrency_BetType]  DEFAULT ((0)) FOR [BetType]
GO
ALTER TABLE [dbo].[ProductLaunchedSiteCurrency] ADD  CONSTRAINT [DF_ProductLaunchedSiteCurrency_LaunchedLevel]  DEFAULT ((0)) FOR [LaunchedLevel]
GO
ALTER TABLE [dbo].[ProductLaunchedSiteCurrency] ADD  CONSTRAINT [DF_ProductLaunchedSiteCurrency_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
CREATE NONCLUSTERED INDEX [IX_ProductLaunchedSiteCurrency_RepUpdateTime] ON [dbo].[ProductLaunchedSiteCurrency]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/****** Object:  Table [dbo].[ProductProfileSiteCurrency]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductProfileSiteCurrency](
	[SiteID] [int] NOT NULL,
	[Currency] [int] NOT NULL,
	[ProductSettingID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
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
CREATE NONCLUSTERED INDEX [IX_ProductProfileSiteCurrency_RepUpdateTime] ON [dbo].[ProductProfileSiteCurrency]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/****** Object:  Table [dbo].[ProductProfileSiteCurrency_UAT]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductProfileSiteCurrency_UAT](
	[SiteID] [int] NOT NULL,
	[Currency] [int] NOT NULL,
	[ProductSettingID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
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
CREATE NONCLUSTERED INDEX [IX_ProductProfileSiteCurrency_UAT_RepUpdateTime] ON [dbo].[ProductProfileSiteCurrency_UAT]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/****** Object:  Table [dbo].[ProductSettingProfile]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
CREATE NONCLUSTERED INDEX [IX_ProductSettingProfile_GroupType] ON [dbo].[ProductSettingProfile]
(
	[GroupType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
CREATE NONCLUSTERED INDEX [IX_ProductSettingProfile_RepUpdateTime] ON [dbo].[ProductSettingProfile]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO

CREATE CLUSTERED INDEX [CIX_ProductSettingProfile] ON [dbo].[ProductSettingProfile]
(
	[SettingType] ASC,
	[SportType] ASC,
	[BetType] ASC,
	[IsLive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/****** Object:  Table [dbo].[ProductSettingProfile_UAT]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
CREATE NONCLUSTERED INDEX [IX_ProductSettingProfile_UAT_GroupType] ON [dbo].[ProductSettingProfile_UAT]
(
	[GroupType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
CREATE NONCLUSTERED INDEX [IX_ProductSettingProfile_UAT_RepUpdateTime] ON [dbo].[ProductSettingProfile_UAT]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
CREATE CLUSTERED INDEX [CIX_ProductSettingProfile_UAT] ON [dbo].[ProductSettingProfile_UAT]
(
	[SettingType] ASC,
	[SportType] ASC,
	[BetType] ASC,
	[IsLive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/****** Object:  Table [dbo].[ProductSettingSystemDisplay]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductSettingSystemDisplay](
	[SystemID] [tinyint] NOT NULL,
	[ProductID] [tinyint] NOT NULL,
	[SettingType] [smallint] NOT NULL,
	[DisplayMode] [tinyint] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_ProductSettingSystemDisplay] PRIMARY KEY CLUSTERED 
(
	[SystemID] ASC,
	[ProductID] ASC,
	[SettingType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[ProductSettingSystemDisplay] ADD  CONSTRAINT [DF_ProductSettingSystemDisplay_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
CREATE NONCLUSTERED INDEX [IX_ProductSettingSystemDisplay_RepUpdateTime] ON [dbo].[ProductSettingSystemDisplay]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO

/****** Object:  Table [dbo].[ProductSettingSystemDisplay_UAT]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductSettingSystemDisplay_UAT](
	[SystemID] [tinyint] NOT NULL,
	[ProductID] [tinyint] NOT NULL,
	[SettingType] [smallint] NOT NULL,
	[DisplayMode] [tinyint] NULL
) ON [DATA]
GO

/****** Object:  Table [dbo].[ProductSettingType]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductSettingType](
	[SettingType] [tinyint] NOT NULL,
	[SettingName] [varchar](30) NULL,
	[SettingNameDetail] [varchar](200) NULL,
 CONSTRAINT [PK_ProductSettingType] PRIMARY KEY CLUSTERED 
(
	[SettingType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
/****** Object:  Table [dbo].[ProductSettingUpdateRestriction]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductSettingUpdateRestriction](
	[SystemID] [tinyint] NOT NULL,
	[ProductID] [tinyint] NOT NULL,
	[SettingType] [smallint] NOT NULL,
	[ActorRoleID] [tinyint] NOT NULL,
	[TargetRoleID] [tinyint] NOT NULL,
	[ErrCode] [int] NULL,
	[RestrictionMode] [tinyint] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_ProductSettingUpdateRestriction] PRIMARY KEY CLUSTERED 
(
	[SystemID] ASC,
	[ProductID] ASC,
	[SettingType] ASC,
	[ActorRoleID] ASC,
	[TargetRoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[ProductSettingUpdateRestriction] ADD  CONSTRAINT [DF_ProductSettingUpdateRestriction_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
CREATE NONCLUSTERED INDEX [IX_ProductSettingUpdateRestriction_RepUpdateTime] ON [dbo].[ProductSettingUpdateRestriction]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO

/****** Object:  Table [dbo].[ProductStatusProfile]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductStatusProfile](
	[Sporttype] [smallint] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[bitmapOrder] [tinyint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_ProductStatusProfile] PRIMARY KEY CLUSTERED 
(
	[Sporttype] ASC,
	[Bettype] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[ProductStatusProfile] ADD  CONSTRAINT [DF_ProductStatusProfile_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
CREATE NONCLUSTERED INDEX [IX_ProductStatusProfile_RepUpdateTime] ON [dbo].[ProductStatusProfile]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/****** Object:  Table [dbo].[ProductStatusSiteCurrency]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductStatusSiteCurrency](
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[Currency] [int] NOT NULL,
	[SiteID] [int] NOT NULL,
	[IsHidden] [bit] NOT NULL,
	[IsDisabled] [bit] NOT NULL,
	[HasSynced] [bit] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
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
CREATE NONCLUSTERED INDEX [IX_ProductStatusSiteCurrency_RepUpdateTime] ON [dbo].[ProductStatusSiteCurrency]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/****** Object:  Table [dbo].[ProfilePicture]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProfilePicture](
	[ImageId] [int] NOT NULL,
	[Image] [varbinary](max) NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_ProfilePicture] PRIMARY KEY CLUSTERED 
(
	[ImageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA] TEXTIMAGE_ON [DATA]
GO
ALTER TABLE [dbo].[ProfilePicture] ADD  CONSTRAINT [DF_ProfilePicture_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
CREATE NONCLUSTERED INDEX [IX_RepUpdateTime_ProfilePicture] ON [dbo].[ProfilePicture]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO

/****** Object:  Table [dbo].[SportNonOfferedSiteCurrency]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SportNonOfferedSiteCurrency](
	[SportType] [smallint] NOT NULL,
	[BetType] [int] NOT NULL,
	[Currency] [int] NOT NULL,
	[SiteID] [int] NOT NULL,
	[RealProductID] [tinyint] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
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
CREATE NONCLUSTERED INDEX [IX_SportNonOfferedSiteCurrency_RepUpdateTime] ON [dbo].[SportNonOfferedSiteCurrency]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/****** Object:  Table [dbo].[StakeLevel]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StakeLevel_History]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Winlimit_ActionSetting]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Winlimit_ActionSetting](
	[ActionID] [tinyint] NOT NULL,
	[ActionName] [varchar](50) NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_Winlimit_ActionSetting] PRIMARY KEY CLUSTERED 
(
	[ActionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[Winlimit_ActionSetting] ADD  CONSTRAINT [DF_Winlimit_ActionSetting_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
CREATE NONCLUSTERED INDEX [IX_Winlimit_ActionSetting_RepUpdateTime] ON [dbo].[Winlimit_ActionSetting]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/****** Object:  Table [dbo].[Winlimit_GameGroupSetting]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Winlimit_GameGroupSetting](
	[ProductID] [tinyint] NOT NULL,
	[BetTypeID] [smallint] NOT NULL,
	[GroupID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_Winlimit_GroupSetting] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[BetTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[Winlimit_GameGroupSetting] ADD  CONSTRAINT [DF_Winlimit_GameGroupSetting_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
CREATE NONCLUSTERED INDEX [IX_Winlimit_GameGroupSetting_RepUpdateTime] ON [dbo].[Winlimit_GameGroupSetting]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/****** Object:  Table [dbo].[Winlimit_Group]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Winlimit_Group](
	[GroupID] [int] NOT NULL,
	[GroupName] [varchar](200) NOT NULL,
 CONSTRAINT [PK_Winlimit_Group] PRIMARY KEY CLUSTERED 
(
	[GroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
/****** Object:  Table [dbo].[Winlimit_LevelSetting]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Winlimit_LevelSetting](
	[LevelID] [tinyint] NOT NULL,
	[LevelName] [varchar](50) NOT NULL,
	[LevelOrder] [tinyint] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_Winlimit_LevelSetting] PRIMARY KEY CLUSTERED 
(
	[LevelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[Winlimit_LevelSetting] ADD  CONSTRAINT [DF_Winlimit_LevelSetting_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
CREATE NONCLUSTERED INDEX [IX_Winlimit_LevelSetting_RepUpdateTime] ON [dbo].[Winlimit_LevelSetting]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO

CREATE TABLE [dbo].[Winlimit_ProductGlobalSetting](
	[ProductID] [int] NOT NULL,
	[BetTypeID] [smallint] NOT NULL,
	[GroupID] [int] NOT NULL,
	[GroupName] [varchar](200) NULL,
	[Level1] [money] NULL,
	[Level2] [money] NULL,
	[Level3] [money] NULL,
	[Level101] [money] NULL,
	[Level102] [money] NULL,
	[blockedTransferLvl3] [bit] NULL,
	[Currency] [int] NOT NULL,
	[IsDeposit] [bit] NOT NULL,
 CONSTRAINT [PK_Winlimit_ProductGlobalSetting] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[BetTypeID] ASC,
	[GroupID] ASC,
	[Currency] ASC,
	[IsDeposit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
/****** Object:  Table [dbo].[Winlimit_ProductSetting]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Winlimit_ProductSetting](
	[ProductID] [tinyint] NOT NULL,
	[BettypeID] [smallint] NOT NULL,
	[LevelID] [tinyint] NOT NULL,
	[SettingStatus] [tinyint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_Winlimit_ProductSetting] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[BettypeID] ASC,
	[LevelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[Winlimit_ProductSetting] ADD  CONSTRAINT [DF_Winlimit_ProductSetting_SettingStatus]  DEFAULT ((0)) FOR [SettingStatus]
GO
ALTER TABLE [dbo].[Winlimit_ProductSetting] ADD  CONSTRAINT [DF_Winlimit_ProductSetting_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
CREATE NONCLUSTERED INDEX [IX_Winlimit_ProductSetting_RepUpdateTime] ON [dbo].[Winlimit_ProductSetting]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/****** Object:  Table [dbo].[WinLimit_ProductSettingDetail]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WinLimit_ProductSettingDetail](
	[ProductID] [tinyint] NOT NULL,
	[GroupID] [smallint] NOT NULL,
	[ExchangeID] [int] NOT NULL,
	[SiteID] [int] NOT NULL,
	[LevelID] [tinyint] NOT NULL,
	[MaxWinLimit] [money] NOT NULL,
	[IsBlockedPlaceBet] [bit] NOT NULL,
	[IsBlockedTransfer] [bit] NOT NULL,
	[MaxWinLimit_RM] [money] NULL,
	[IsSuspendedAccount] [bit] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_WinLimit_ProductSettingDetail] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[GroupID] ASC,
	[ExchangeID] ASC,
	[SiteID] ASC,
	[LevelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[WinLimit_ProductSettingDetail] ADD  CONSTRAINT [DF_WinLimit_ProductSettingDetail_MaxWinLimit]  DEFAULT ((0)) FOR [MaxWinLimit]
GO
ALTER TABLE [dbo].[WinLimit_ProductSettingDetail] ADD  CONSTRAINT [DF_WinLimit_ProductSettingDetail_IsBlockedPlaceBet]  DEFAULT ((0)) FOR [IsBlockedPlaceBet]
GO
ALTER TABLE [dbo].[WinLimit_ProductSettingDetail] ADD  CONSTRAINT [DF_WinLimit_ProductSettingDetail_IsBlockedTransfer]  DEFAULT ((0)) FOR [IsBlockedTransfer]
GO
ALTER TABLE [dbo].[WinLimit_ProductSettingDetail] ADD  CONSTRAINT [DF_WinLimit_ProductSettingDetail_MaxWinLimit_RM]  DEFAULT ((0)) FOR [MaxWinLimit_RM]
GO
ALTER TABLE [dbo].[WinLimit_ProductSettingDetail] ADD  CONSTRAINT [DF_WinLimit_ProductSettingDetail_IsSuspendedAccount]  DEFAULT ((0)) FOR [IsSuspendedAccount]
GO
ALTER TABLE [dbo].[WinLimit_ProductSettingDetail] ADD  CONSTRAINT [DF_WinLimit_ProductSettingDetail_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE NONCLUSTERED INDEX [IX_WinLimit_ProductSettingDetail_RepUpdateTime] ON [dbo].[WinLimit_ProductSettingDetail]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO



/****** Object:  Table [dbo].[UMConfig]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UMConfig](
	[ProductID] [tinyint] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[SettingType] [tinyint] NOT NULL,
	[FunctionType] [tinyint] NOT NULL,
	[SiteID] [int] NOT NULL,
	[Currency] [int] NOT NULL,
	[SuperID] [int] NOT NULL,
	[BeginTime] [smalldatetime] NULL,
	[EndTime] [smalldatetime] NULL,
	[Time_Stamp] [timestamp] NULL,
	[ShowTime] [smalldatetime] NULL,
	[LockAddingNew] [bit] NULL,
	[ConfigID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_UMConfig] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[SportType] ASC,
	[SettingType] ASC,
	[FunctionType] ASC,
	[SiteID] ASC,
	[Currency] ASC,
	[SuperID] ASC,
	[BetType] ASC,
	[IsLive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
CREATE NONCLUSTERED INDEX [IX_UMConfig_ConfigID] ON [dbo].[UMConfig]
(
	[ConfigID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
