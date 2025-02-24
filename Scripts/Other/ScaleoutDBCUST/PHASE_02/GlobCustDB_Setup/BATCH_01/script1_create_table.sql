/*<info serverAlias="DBGLOB-GlobCustDB" executers="" viewers="" isFunction="0"></info>*/
/*
	Created: DaveTruong
	Date: 20250120
	Task: Create table ScaleOut Custsetting on  GlobCustDB [RedmineID:#217137]
	DB: DBGLOB/GlobCustDB
*/
USE [GlobCustDB]
GO
IF OBJECT_ID('Site', 'V') IS NOT NULL
    DROP VIEW [Site];
GO
IF OBJECT_ID('SiteDBConfig', 'V') IS NOT NULL
    DROP VIEW SiteDBConfig;
GO
/*Dep_Initial_BetSetting*/
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
/*Dep_Initial_ProductConfig*/
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
/*Dep_Initial_ProductConfig_Detail*/
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

/*Dep_Initial_StepByConfig*/
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

/*Dep_ProductBetSetting*/
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
/*Dep_ProductSetting*/
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
/*Dep_ProductSettingDetail*/
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
/*Dep_ProductSettingType*/
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
/*Dep_ProductStakeLevelGroup*/
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
/*Dep_ProductStatusProfile*/
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
/*Dep_StakeLevel*/
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
/*Dep_StakeLevel_History*/
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
/*Dep_StakeLevelGroupDetail*/
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
/*Dep_StakeLevelGroupDetail_History*/
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
/*Dep_UMConfig*/
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
/*DomainManagement*/
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
/*GameGroup*/
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
/*GameLaunchPerCurrency*/
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
/*GameLaunchPerSite*/
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
/*LossLimit_GlobalSetting*/
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

/*MaxPayoutGlobalSetting*/
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
/*PlayCurrencySetting*/
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
/*ProductBetSetting*/
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
/*ProductStakeLevelGroup*/
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
/*SettingSystem*/
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
/*Site*/
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
CREATE UNIQUE CLUSTERED INDEX [IX_Site] ON [dbo].[Site]
(
	[site] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO

/*SiteDBConfig*/
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

/*SportBettypeSettingMatrix*/
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
/*StakeLevel*/
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
/*StakeLevel_History*/
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
