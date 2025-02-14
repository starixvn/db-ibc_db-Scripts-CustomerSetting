/*<info serverAlias="DBGLOB-GlobCustDB" executers="" viewers="" isFunction="0"></info>*/
/*
	Created: DaveTruong
	Date: 20250120
	Task: Create table ScaleOut Custsetting on  GlobCustDB [RedmineID:#217137]
	DB: DBGLOB/GlobCustDB
*/


USE [GlobCustDB]
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

/****** Object:  Table [dbo].[BetLimitControlTypeDetails]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BetLimitControlTypeDetails](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BetLimitTypeID] [int] NOT NULL,
	[ProductID] [tinyint] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[LeagueGroupID] [int] NOT NULL,
	[LeagueID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_BetLimitControlTypeDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

CREATE NONCLUSTERED INDEX [IX_BetLimitControlTypeDetails_BetLimitTypeID] ON [dbo].[BetLimitControlTypeDetails]
(
	[BetLimitTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO

CREATE NONCLUSTERED INDEX [IX_BetLimitControlTypeDetails_RepUpdateTime] ON [dbo].[BetLimitControlTypeDetails]
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
/****** Object:  Table [dbo].[Dep_Initial_BetSetting]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dep_Initial_BetSetting](
	[ConfigID] [int] NOT NULL,
	[Currency] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[MaxPerNumber] [money] NULL,
	[MaxPayoutPerMatch] [money] NULL,
 CONSTRAINT [PK_Dep_Initial_Dep_Initial_BetSetting] PRIMARY KEY CLUSTERED 
(
	[ConfigID] ASC,
	[Currency] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
/****** Object:  Table [dbo].[Dep_Initial_ProductConfig]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dep_Initial_ProductConfig](
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
 CONSTRAINT [PK_Dep_Initial_ProductConfig] PRIMARY KEY CLUSTERED 
(
	[ConfigID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA] TEXTIMAGE_ON [DATA]
GO
/****** Object:  Table [dbo].[Dep_Initial_ProductConfig_Detail]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dep_Initial_ProductConfig_Detail](
	[ConfigID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[SettingType] [tinyint] NOT NULL,
	[IsDefault] [bit] NOT NULL,
	[DefaultValueSuper] [decimal](11, 8) NULL,
	[DefaultValueMaster] [decimal](11, 8) NULL,
	[DefaultValueAgent] [decimal](11, 8) NULL,
	[DefaultValueMember] [decimal](11, 8) NULL,
	[SpecialRequirement] [varchar](max) NULL,
 CONSTRAINT [PK_Dep_Initial_ProductConfig_Detail] PRIMARY KEY CLUSTERED 
(
	[ConfigID] ASC,
	[SportType] ASC,
	[BetType] ASC,
	[IsLive] ASC,
	[SettingType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA] TEXTIMAGE_ON [DATA]
GO
/****** Object:  Table [dbo].[Dep_Initial_StepByConfig]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dep_Initial_StepByConfig](
	[StepID] [tinyint] NOT NULL,
	[IsScanCustomer] [bit] NULL,
	[SortOrder] [tinyint] IDENTITY(1,1) NOT NULL
) ON [DATA]
GO
/****** Object:  Table [dbo].[Dep_ProductBetSetting]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dep_ProductBetSetting](
	[Sporttype] [int] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[Currency] [tinyint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[DefaultMinBet] [money] NULL,
	[DefaultMaxBet] [money] NULL,
	[DefaultMaxPerMatch] [money] NULL,
	[MaxPerBall] [decimal](19, 8) NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_Dep_ProductBetSetting] PRIMARY KEY CLUSTERED 
(
	[Sporttype] ASC,
	[Bettype] ASC,
	[Currency] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[Dep_ProductBetSetting] ADD  CONSTRAINT [DF_Dep_ProductBetSetting_Minbet]  DEFAULT ((0)) FOR [MinBet]
GO
CREATE NONCLUSTERED INDEX [IX_Dep_ProductBetSetting_RepUpdateTime] ON [dbo].[Dep_ProductBetSetting]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
CREATE TABLE [dbo].[Dep_ProductSetting](
	[ProductSettingID] [int] NOT NULL,
	[ProductID] [smallint] NOT NULL,
	[SettingType] [tinyint] NOT NULL,
	[TemplateID] [tinyint] NOT NULL,
	[DisplayOrder] [tinyint] NOT NULL,
	[SettingLevel] [tinyint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_Dep_ProductSetting] PRIMARY KEY CLUSTERED 
(
	[ProductSettingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[Dep_ProductSetting] ADD  CONSTRAINT [DF_Dep_ProductSetting_TemplateID]  DEFAULT ((0)) FOR [TemplateID]
GO

CREATE NONCLUSTERED INDEX [IX_Dep_ProductSetting_RepUpdateTime] ON [dbo].[Dep_ProductSetting]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/****** Object:  Table [dbo].[Dep_ProductSettingDetail]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dep_ProductSettingDetail](
	[ProductSettingID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[MaxDefaultValue] [decimal](19, 8) NULL,
	[SettingStatus] [tinyint] NULL,
	[MinDefaultValue] [decimal](19, 8) NULL,
	[IsApplyBA] [bit] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_Dep_ProductSettingDetail] PRIMARY KEY CLUSTERED 
(
	[ProductSettingID] ASC,
	[SportType] ASC,
	[BetType] ASC,
	[IsLive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[Dep_ProductSettingDetail] ADD  CONSTRAINT [DF_Dep_ProductSettingDetail_MaxDefaultValue]  DEFAULT ((0)) FOR [MaxDefaultValue]
GO
ALTER TABLE [dbo].[Dep_ProductSettingDetail] ADD  CONSTRAINT [DF_Dep_ProductSettingDetail_IsApplyBA]  DEFAULT ((0)) FOR [IsApplyBA]
GO

CREATE NONCLUSTERED INDEX [IX_Dep_ProductSettingDetail_RepUpdateTime] ON [dbo].[Dep_ProductSettingDetail]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/****** Object:  Table [dbo].[Dep_ProductSettingType]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dep_ProductSettingType](
	[SettingType] [tinyint] NOT NULL,
	[SettingName] [varchar](30) NULL,
	[SettingNameDetail] [varchar](30) NULL,
 CONSTRAINT [PK_Dep_ProductSettingType] PRIMARY KEY CLUSTERED 
(
	[SettingType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
/****** Object:  Table [dbo].[Dep_ProductStakeLevelGroup]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dep_ProductStakeLevelGroup](
	[Sporttype] [smallint] NOT NULL,
	[GameGroupID] [tinyint] NOT NULL,
	[MinBet] [money] NOT NULL,
	[MaxBet] [money] NOT NULL,
	[LicenseeGroupID] [tinyint] NOT NULL,
	[Remark] [varchar](1000) NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
	[SiteID] [int] NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_ProductStakeLevelGroup] PRIMARY KEY CLUSTERED 
(
	[Sporttype] ASC,
	[GameGroupID] ASC,
	[LicenseeGroupID] ASC,
	[SiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[Dep_ProductStakeLevelGroup] ADD  CONSTRAINT [DF_Dep_ProductStakeLevelGroup_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
ALTER TABLE [dbo].[Dep_ProductStakeLevelGroup] ADD  CONSTRAINT [DF_Dep_ProductStakeLevelGroup_SiteID]  DEFAULT ((0)) FOR [SiteID]
GO
ALTER TABLE [dbo].[Dep_ProductStakeLevelGroup] ADD  CONSTRAINT [DF_Dep_ProductStakeLevelGroup_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
CREATE NONCLUSTERED INDEX [IX_Dep_ProductStakeLevelGroup_RepUpdateTime] ON [dbo].[Dep_ProductStakeLevelGroup]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/****** Object:  Table [dbo].[Dep_ProductStatusProfile]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dep_ProductStatusProfile](
	[Sporttype] [smallint] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[bitmapOrder] [tinyint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_Dep_ProductStatusProfile] PRIMARY KEY NONCLUSTERED 
(
	[Sporttype] ASC,
	[Bettype] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

CREATE NONCLUSTERED INDEX [IX_Dep_ProductStatusProfile_RepUpdateTime] ON [dbo].[Dep_ProductStatusProfile]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO

/****** Object:  Table [dbo].[Dep_StakeLevel]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dep_StakeLevel](
	[StakeLevelID] [int] NOT NULL,
	[GameTypeID] [smallint] NOT NULL,
	[GameGroupID] [smallint] NOT NULL,
	[MinLabel] [nvarchar](50) NULL,
	[MaxLabel] [nvarchar](50) NULL,
	[MinStake] [decimal](19, 8) NULL,
	[MaxStake] [decimal](19, 8) NULL,
	[ExchangeID] [int] NULL,
	[ResourceId] [varchar](20) NULL,
	[SiteID] [int] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_Dep_StakeLevel] PRIMARY KEY CLUSTERED 
(
	[StakeLevelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[Dep_StakeLevel] ADD  CONSTRAINT [DF_Dep_StakeLevel_GameGroupID]  DEFAULT ((0)) FOR [GameGroupID]
GO

CREATE NONCLUSTERED INDEX [IX_Dep_StakeLevel_RepUpdateTime] ON [dbo].[Dep_StakeLevel]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/****** Object:  Table [dbo].[Dep_StakeLevel_History]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dep_StakeLevel_History](
	[StakeLevelID] [int] NOT NULL,
	[GameTypeID] [smallint] NOT NULL,
	[MaxLabel] [nvarchar](50) NULL,
	[MaxStake] [decimal](19, 8) NULL,
	[SiteID] [int] NULL,
	[UpdateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Dep_StakeLevel_History] PRIMARY KEY CLUSTERED 
(
	[StakeLevelID] ASC,
	[UpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
/****** Object:  Table [dbo].[Dep_StakeLevelGroupDetail]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dep_StakeLevelGroupDetail](
	[StakeLevelID] [int] NOT NULL,
	[GameTypeID] [smallint] NOT NULL,
	[MinLabel] [nvarchar](50) NULL,
	[MaxLabel] [nvarchar](50) NULL,
	[MinStake] [decimal](19, 8) NULL,
	[MaxStake] [decimal](19, 8) NULL,
	[ParentTypeID] [int] NULL,
	[MaxGameStake] [decimal](19, 8) NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_Dep_StakeLevelGroupDetail] PRIMARY KEY CLUSTERED 
(
	[StakeLevelID] ASC,
	[GameTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

CREATE NONCLUSTERED INDEX [IX_Dep_StakeLevelGroupDetail_RepUpdateTime] ON [dbo].[Dep_StakeLevelGroupDetail]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/****** Object:  Table [dbo].[Dep_StakeLevelGroupDetail_History]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dep_StakeLevelGroupDetail_History](
	[StakeLevelID] [int] NOT NULL,
	[GameTypeID] [smallint] NOT NULL,
	[MaxLabel] [nvarchar](50) NULL,
	[MaxStake] [decimal](19, 8) NULL,
	[MaxGameStake] [decimal](19, 8) NULL,
	[UpdateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Dep_StakeLevelGroupDetail_History] PRIMARY KEY CLUSTERED 
(
	[StakeLevelID] ASC,
	[GameTypeID] ASC,
	[UpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
/****** Object:  Table [dbo].[Dep_UMConfig]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dep_UMConfig](
	[FunctionType] [tinyint] NOT NULL,
	[ProductID] [tinyint] NOT NULL,
	[SettingType] [tinyint] NOT NULL,
	[LicenseeID] [int] NOT NULL,
	[BeginTime] [smalldatetime] NULL,
	[EndTime] [smalldatetime] NULL,
	[Time_Stamp] [timestamp] NULL,
 CONSTRAINT [PK_Dep_UMConfig] PRIMARY KEY CLUSTERED 
(
	[FunctionType] ASC,
	[ProductID] ASC,
	[SettingType] ASC,
	[LicenseeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
/****** Object:  Table [dbo].[DomainManagement]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DomainManagement](
	[DomainID] [smallint] IDENTITY(1,1) NOT NULL,
	[Domain] [varchar](50) NOT NULL,
	[System] [varchar](20) NOT NULL,
	[Site] [varchar](500) NOT NULL,
	[BrandName] [varchar](10) NULL,
	[Status] [tinyint] NOT NULL,
	[ExpiredDate] [datetime] NULL,
	[LastUpdateTime] [datetime] NOT NULL,
	[RestrictedCountries] [varchar](4000) NULL,
	[Remark] [nvarchar](2000) NULL,
	[isDeleted] [bit] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_DomainManagement] PRIMARY KEY CLUSTERED 
(
	[DomainID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[DomainManagement] ADD  CONSTRAINT [DF_DomainManagement_LastUpdateTime]  DEFAULT (getdate()) FOR [LastUpdateTime]
GO
ALTER TABLE [dbo].[DomainManagement] ADD  CONSTRAINT [DF_DomainManagement_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[DomainManagement] ADD  CONSTRAINT [DF_DomainManagement_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
CREATE NONCLUSTERED INDEX [IX_DomainManagement_RepUpdateTime] ON [dbo].[DomainManagement]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/****** Object:  Table [dbo].[GameGroup]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameGroup](
	[GameGroupID] [int] NOT NULL,
	[RefSportType] [smallint] NOT NULL,
	[RefBetType] [int] NOT NULL,
	[GroupName] [nvarchar](100) NULL,
	[IsDeposit] [bit] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
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
CREATE NONCLUSTERED INDEX [IX_GameGroup_RepUpdateTime] ON [dbo].[GameGroup]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/****** Object:  Table [dbo].[GameLaunchPerCurrency]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameLaunchPerCurrency](
	[SportType] [smallint] NOT NULL,
	[BetType] [int] NOT NULL,
	[Currency] [int] NOT NULL,
	[IsLaunched] [bit] NOT NULL,
	[IsTest] [bit] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_GameLaunchPerCurrency] PRIMARY KEY CLUSTERED 
(
	[Currency] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[GameLaunchPerCurrency] ADD  DEFAULT ((0)) FOR [IsLaunched]
GO
ALTER TABLE [dbo].[GameLaunchPerCurrency] ADD  DEFAULT ((0)) FOR [IsTest]
GO
ALTER TABLE [dbo].[GameLaunchPerCurrency] ADD  CONSTRAINT [DF_GameLaunchPerCurrency_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
CREATE NONCLUSTERED INDEX [IX_GameLaunchPerCurrency_RepUpdateTime] ON [dbo].[GameLaunchPerCurrency]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/****** Object:  Table [dbo].[GameLaunchPerSite]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameLaunchPerSite](
	[SportType] [smallint] NOT NULL,
	[BetType] [int] NOT NULL,
	[SiteID] [int] NOT NULL,
	[IsLaunched] [bit] NOT NULL,
	[IsTest] [bit] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_GameLaunchPerSite] PRIMARY KEY CLUSTERED 
(
	[SiteID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[GameLaunchPerSite] ADD  DEFAULT ((0)) FOR [IsLaunched]
GO
ALTER TABLE [dbo].[GameLaunchPerSite] ADD  DEFAULT ((0)) FOR [IsTest]
GO
ALTER TABLE [dbo].[GameLaunchPerSite] ADD  CONSTRAINT [DF_GameLaunchPerSite_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
CREATE NONCLUSTERED INDEX [IX_GameLaunchPerSite_RepUpdateTime] ON [dbo].[GameLaunchPerSite]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
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
/****** Object:  Table [dbo].[LossLimit_GlobalSetting]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LossLimit_GlobalSetting](
	[ProductId] [tinyint] NOT NULL,
	[ExchangeId] [int] NOT NULL,
	[MinLossLimit] [money] NULL,
	[DefaultLossLimit] [money] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_LossLimit_GlobalSetting] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC,
	[ExchangeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[LossLimit_GlobalSetting] ADD  CONSTRAINT [DF_LossLimit_GlobalSetting_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE NONCLUSTERED INDEX [IX_LossLimit_GlobalSetting_RepUpdateTime] ON [dbo].[LossLimit_GlobalSetting]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO

/****** Object:  Table [dbo].[MaxPayoutGlobalSetting]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaxPayoutGlobalSetting](
	[SportType] [int] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[Currency] [tinyint] NOT NULL,
	[SingleMatchParlay] [money] NOT NULL,
	[Combo2] [money] NOT NULL,
	[Combo35] [money] NOT NULL,
	[ComboOver6] [money] NOT NULL,
	[SettingStatus] [tinyint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_MaxPayoutGlobalSetting] PRIMARY KEY CLUSTERED 
(
	[SportType] ASC,
	[BetType] ASC,
	[Currency] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[MaxPayoutGlobalSetting] ADD  CONSTRAINT [DF_MaxPayoutGlobalSetting_SingleMatchParlay]  DEFAULT ((0)) FOR [SingleMatchParlay]
GO
ALTER TABLE [dbo].[MaxPayoutGlobalSetting] ADD  CONSTRAINT [DF_MaxPayoutGlobalSetting_Combo2]  DEFAULT ((0)) FOR [Combo2]
GO
ALTER TABLE [dbo].[MaxPayoutGlobalSetting] ADD  CONSTRAINT [DF_MaxPayoutGlobalSetting_Combo35]  DEFAULT ((0)) FOR [Combo35]
GO
ALTER TABLE [dbo].[MaxPayoutGlobalSetting] ADD  CONSTRAINT [DF_MaxPayoutGlobalSetting_ComboOver6]  DEFAULT ((0)) FOR [ComboOver6]
GO
ALTER TABLE [dbo].[MaxPayoutGlobalSetting] ADD  CONSTRAINT [DF_MaxPayoutGlobalSetting_SettingStatus]  DEFAULT ((0)) FOR [SettingStatus]
GO
ALTER TABLE [dbo].[MaxPayoutGlobalSetting] ADD  CONSTRAINT [DF_MaxPayoutGlobalSetting_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE NONCLUSTERED INDEX [IX_MaxPayoutGlobalSetting_RepUpdateTime] ON [dbo].[MaxPayoutGlobalSetting]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
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
/****** Object:  Table [dbo].[PlayCurrencySetting]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlayCurrencySetting](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SiteId] [int] NULL,
	[SiteName] [nvarchar](50) NULL,
	[SportType] [int] NULL,
	[MemberCurrency] [int] NULL,
	[PlayCurrency] [int] NULL,
	[FromDate] [date] NULL,
	[ToDate] [date] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_PlayCurrencySetting] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[PlayCurrencySetting] ADD  CONSTRAINT [DF_PlayCurrencySetting_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
CREATE NONCLUSTERED INDEX [IX_PlayCurrencySetting_RepUpdateTime] ON [dbo].[PlayCurrencySetting]
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
/****** Object:  Table [dbo].[ProductBetSetting]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
CREATE NONCLUSTERED INDEX [IX_ProductBetSetting_RepUpdateTime] ON [dbo].[ProductBetSetting]
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
/****** Object:  Table [dbo].[ProductStakeLevelGroup]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductStakeLevelGroup](
	[Sporttype] [smallint] NOT NULL,
	[GameGroupID] [tinyint] NOT NULL,
	[MinBet] [money] NOT NULL,
	[MaxBet] [money] NOT NULL,
	[CreditGroupID] [tinyint] NOT NULL,
	[Remark] [varchar](1000) NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_ProductStakeLevelGroup] PRIMARY KEY CLUSTERED 
(
	[Sporttype] ASC,
	[GameGroupID] ASC,
	[CreditGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[ProductStakeLevelGroup] ADD  CONSTRAINT [DF_ProductStakeLevelGroup_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
ALTER TABLE [dbo].[ProductStakeLevelGroup] ADD  CONSTRAINT [DF_ProductStakeLevelGroup_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
CREATE NONCLUSTERED INDEX [IX_ProductStakeLevelGroup_RepUpdateTime] ON [dbo].[ProductStakeLevelGroup]
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

CREATE TABLE [dbo].[SettingSystem](
	[SystemID] [tinyint] NOT NULL,
	[SystemName] [varchar](50) NULL,
	[Description] [varchar](100) NULL,
	[SystemPrefix] [varchar](10) NULL,
 CONSTRAINT [PK_SettingSystem] PRIMARY KEY CLUSTERED 
(
	[SystemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
/****** Object:  Table [dbo].[Site]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Site](
	[siteid] [int] IDENTITY(1,1) NOT NULL,
	[site] [nvarchar](50) NULL,
	[type] [nvarchar](50) NULL,
	[spreada] [float] NULL,
	[spreadb] [float] NULL,
	[spreadc] [float] NULL,
	[spreadd] [float] NULL,
	[spreade] [float] NULL,
	[spreadf] [float] NULL,
	[ServerID] [int] NOT NULL,
	[isLicensee] [bit] NOT NULL,
	[isActive] [bit] NOT NULL,
	[isDeposit] [bit] NOT NULL,
	[SpecialGroup] [tinyint] NULL,
	[BlockNewCust] [bit] NULL,
	[UnblockTime] [varchar](50) NULL,
	[IsChinaView] [bit] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[SiteDBGroupID] [smallint] NOT NULL,
	[SiteLabel] [varchar](50) NULL,
	[SpecialPlatfrom] [tinyint] NULL,
	[CustDBGroupID] [smallint] NOT NULL,
	[SiteType] [tinyint] NULL,
 CONSTRAINT [PK_Site] PRIMARY KEY NONCLUSTERED 
(
	[siteid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[Site] ADD  CONSTRAINT [DF_Site_ServerID]  DEFAULT ((0)) FOR [ServerID]
GO
ALTER TABLE [dbo].[Site] ADD  CONSTRAINT [DF_Site_isLicensee]  DEFAULT ((0)) FOR [isLicensee]
GO
ALTER TABLE [dbo].[Site] ADD  CONSTRAINT [DF_Site_isActive]  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[Site] ADD  CONSTRAINT [DF_Site_SpecialGroup]  DEFAULT ((0)) FOR [SpecialGroup]
GO
ALTER TABLE [dbo].[Site] ADD  CONSTRAINT [DF_SettingSystem_BlockNewCust]  DEFAULT ((0)) FOR [BlockNewCust]
GO
ALTER TABLE [dbo].[Site] ADD  CONSTRAINT [DF_Site_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
ALTER TABLE [dbo].[Site] ADD  CONSTRAINT [DF_Site_SiteDBGroupID]  DEFAULT ((0)) FOR [SiteDBGroupID]
GO
ALTER TABLE [dbo].[Site] ADD  CONSTRAINT [DF_Site_SpecialPlatform]  DEFAULT ((0)) FOR [SpecialPlatfrom]
GO
ALTER TABLE [dbo].[Site] ADD  CONSTRAINT [DF_Site_CustDBGroupID]  DEFAULT ((0)) FOR [CustDBGroupID]
GO
ALTER TABLE [dbo].[Site] ADD  CONSTRAINT [DF_Site_SiteType]  DEFAULT ((0)) FOR [SiteType]
GO
CREATE NONCLUSTERED INDEX [IX_RepUpdateTime] ON [dbo].[Site]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/****** Object:  Table [dbo].[SiteDBConfig]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SiteDBConfig](
	[SiteDBGroupID] [smallint] NOT NULL,
	[LinkedServerName] [varchar](512) NULL,
	[ClientAccessName] [varchar](512) NULL,
	[AGIP] [varchar](50) NULL,
	[AWSProxyDomain] [varchar](50) NULL,
	[AWSProxyPort] [int] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[FQDN] [varchar](50) NULL,
 CONSTRAINT [PK_SiteDBConfig_SiteDBGroupID] PRIMARY KEY CLUSTERED 
(
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[SiteDBConfig] ADD  CONSTRAINT [DF_SiteDBConfig_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
CREATE NONCLUSTERED INDEX [IX_SiteDBConfig_RepUpdateTime] ON [dbo].[SiteDBConfig]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/****** Object:  Table [dbo].[SportBettypeSettingMatrix]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SportBettypeSettingMatrix](
	[SportType] [smallint] NOT NULL,
	[BetType] [int] NOT NULL,
	[isLicensee] [bit] NOT NULL,
	[isLive] [bit] NOT NULL,
	[Site] [varchar](50) NOT NULL,
	[isActive] [bit] NOT NULL,
	[SportTypeRefPT] [smallint] NULL,
	[BetTypeRefPT] [int] NULL,
	[isLivePT] [bit] NOT NULL,
	[TablePT] [varchar](50) NULL,
	[SportTypeRefComm] [smallint] NULL,
	[BetTypeRefComm] [int] NULL,
	[TableComm] [varchar](50) NULL,
	[SportTypeRefBetSetting] [smallint] NULL,
	[BetTypeRefBetSetting] [int] NULL,
	[TableBetSetting] [varchar](50) NULL,
	[IsLiveComm] [bit] NOT NULL,
	[IsLiveBetSetting] [bit] NOT NULL,
	[TableBettrans] [varchar](100) NULL,
	[SporttypeRefWinlossLimit] [smallint] NULL,
	[BettypeRefWinlossLimit] [smallint] NULL,
	[RealProductId] [tinyint] NULL,
	[isDeleted] [bit] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[ProductID] [tinyint] NULL,
 CONSTRAINT [PK_SportBettypeSettingMatrix] PRIMARY KEY CLUSTERED 
(
	[BetType] ASC,
	[SportType] ASC,
	[isLicensee] ASC,
	[isLive] ASC,
	[Site] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[SportBettypeSettingMatrix] ADD  CONSTRAINT [DF_SportBettypeSettingMatrix_isActive]  DEFAULT ((0)) FOR [isActive]
GO
ALTER TABLE [dbo].[SportBettypeSettingMatrix] ADD  CONSTRAINT [DF_SportBettypeSettingMatrix_isLivePT]  DEFAULT ((0)) FOR [isLivePT]
GO
ALTER TABLE [dbo].[SportBettypeSettingMatrix] ADD  CONSTRAINT [SportBettypeSettingMatrix_IsLiveComm]  DEFAULT ((0)) FOR [IsLiveComm]
GO
ALTER TABLE [dbo].[SportBettypeSettingMatrix] ADD  CONSTRAINT [SportBettypeSettingMatrix_IsLiveBetSetting]  DEFAULT ((0)) FOR [IsLiveBetSetting]
GO
ALTER TABLE [dbo].[SportBettypeSettingMatrix] ADD  CONSTRAINT [DF_SportBettypeSettingMatrix_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[SportBettypeSettingMatrix] ADD  CONSTRAINT [SportBettypeSettingMatrix_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
CREATE NONCLUSTERED INDEX [IX_SportBettypeSettingMatrix_RepUpdateTime] ON [dbo].[SportBettypeSettingMatrix]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
CREATE NONCLUSTERED INDEX [IX_SportBettypeSettingMatrix_SportType] ON [dbo].[SportBettypeSettingMatrix]
(
	[SportType] ASC,
	[RealProductId] ASC,
	[ProductID] ASC
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
CREATE TABLE [dbo].[StakeLevel](
	[StakeLevelID] [int] IDENTITY(1,1) NOT NULL,
	[GameTypeID] [int] NULL,
	[MinLabel] [nvarchar](50) NULL,
	[MaxLabel] [nvarchar](50) NULL,
	[MinStake] [decimal](19, 8) NULL,
	[MaxStake] [decimal](19, 8) NULL,
	[ExchangeId] [int] NULL,
	[ResourceId] [varchar](20) NULL,
	[GameGroupID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
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
CREATE NONCLUSTERED INDEX [IX_StakeLevel_RepUpdateTime] ON [dbo].[StakeLevel]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/****** Object:  Table [dbo].[StakeLevel_History]    Script Date: 2/13/2025 10:37:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StakeLevel_History](
	[StakeLevelID] [int] NOT NULL,
	[GameTypeID] [int] NULL,
	[MaxLabel] [nvarchar](50) NULL,
	[MaxStake] [decimal](19, 8) NULL,
	[UpdateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_StakeLevel_History] PRIMARY KEY CLUSTERED 
(
	[StakeLevelID] ASC,
	[UpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
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



