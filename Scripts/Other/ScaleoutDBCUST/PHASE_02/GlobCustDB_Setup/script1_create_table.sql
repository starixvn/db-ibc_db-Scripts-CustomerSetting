/*<info serverAlias="DBGLOB-GlobCustDB" executers="" viewers="" isFunction="0"></info>*/
/*
	Created: DaveTruong
	Date: 20250120
	Task: Create table ScaleOut Custsetting on  GlobCustDB [RedmineID:#217137]
	DB: DBGLOB/GlobCustDB
*/

USE [GlobCustDB]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TABLE [dbo].[Acc_SuperPrefix]
(
	  [GroupName] VARCHAR(50) NOT NULL
	, [Prefix] VARCHAR(10) NOT NULL
	, [AllowNewSuper] BIT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_AccSuperPrefix] PRIMARY KEY ([GroupName] ASC, [Prefix] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_Acc_SuperPrefix_RepUpdateTime] ON [dbo].[Acc_SuperPrefix] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[Acc_SuperPrefix] ADD CONSTRAINT [DF_Acc_SuperPrefix_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO


CREATE TABLE [dbo].[BetLimitControlTypeDetails]
(
	  [ID] INT NOT NULL IDENTITY(1,1)
	, [BetLimitTypeID] INT NOT NULL
	, [ProductID] TINYINT NOT NULL
	, [Sporttype] SMALLINT NOT NULL
	, [Bettype] SMALLINT NOT NULL
	, [LeagueGroupID] INT NOT NULL
	, [LeagueID] INT NOT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_BetLimitControlTypeDetails] PRIMARY KEY ([ID] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_BetLimitControlTypeDetails_RepUpdateTime] ON [dbo].[BetLimitControlTypeDetails] ([RepUpdateTime] ASC);
GO

CREATE NONCLUSTERED INDEX [IX_BetLimitControlTypeDetails_BetLimitTypeID] ON [dbo].[BetLimitControlTypeDetails] ([BetLimitTypeID] ASC);
GO



CREATE TABLE [dbo].[CategoryConfig]
(
	  [CategoryID] INT NOT NULL
	, [CategoryName] VARCHAR(100) NULL
	, [OfferDeposit] BIT NULL
	, [CategoryNameCS] NVARCHAR(100) NULL
	, [CustomerClass] INT NULL
	, [HiddenSite] TINYINT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_CategoryConfig] PRIMARY KEY ([CategoryID] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_CategoryConfig_RepUpdateTime] ON [dbo].[CategoryConfig] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[CategoryConfig] ADD CONSTRAINT [DF_CategoryConfig_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO
ALTER TABLE [dbo].[CategoryConfig] ADD DEFAULT ((0)) FOR [HiddenSite]; 
GO


CREATE TABLE [dbo].[DangerLevelPolicy]
(
	  [SportType] TINYINT NOT NULL
	, [DangerLevel] TINYINT NOT NULL
	, [ActionType] TINYINT NOT NULL
	, [Value] DECIMAL(9,2) NOT NULL
	, [LeagueGroupID] SMALLINT NOT NULL
	, CONSTRAINT [PK_DangerLevelPolicy] PRIMARY KEY ([SportType] ASC, [DangerLevel] ASC, [ActionType] ASC, [LeagueGroupID] ASC)
)
GO
ALTER TABLE [dbo].[DangerLevelPolicy] ADD CONSTRAINT [DF_DangerLevelPolicy_LeagueGroupID] DEFAULT ((0)) FOR [LeagueGroupID]; 
GO


CREATE TABLE [dbo].[Dep_Initial_BetSetting]
(
	  [ConfigID] INT NOT NULL
	, [Currency] INT NOT NULL
	, [SportType] SMALLINT NOT NULL
	, [BetType] SMALLINT NOT NULL
	, [MinBet] MONEY NULL
	, [MaxBet] MONEY NULL
	, [MaxPerMatch] MONEY NULL
	, [MaxPerNumber] MONEY NULL
	, [MaxPayoutPerMatch] MONEY NULL
	, CONSTRAINT [PK_Dep_Initial_Dep_Initial_BetSetting] PRIMARY KEY ([ConfigID] ASC, [Currency] ASC, [SportType] ASC, [BetType] ASC)
)
GO


CREATE TABLE [dbo].[Dep_Initial_ProductConfig]
(
	  [ConfigID] INT NOT NULL IDENTITY(1,1)
	, [ProductID] TINYINT NOT NULL
	, [SportTypeList] VARCHAR(300) NOT NULL
	, [BetTypeList] VARCHAR(300) NOT NULL
	, [Site] VARCHAR(MAX) NOT NULL
	, [Currency] VARCHAR(MAX) NOT NULL
	, [StartTime] DATETIME NOT NULL
	, [EndTime] DATETIME NULL
	, [IsTest] BIT NOT NULL
	, [Status] TINYINT NULL
	, [CurrentStep] TINYINT NULL
	, [ProcessedStep] VARCHAR(500) NULL
	, [Remark] VARCHAR(1000) NULL
	, CONSTRAINT [PK_Dep_Initial_ProductConfig] PRIMARY KEY ([ConfigID] ASC)
)
GO


CREATE TABLE [dbo].[Dep_Initial_ProductConfig_Detail]
(
	  [ConfigID] INT NOT NULL
	, [SportType] SMALLINT NOT NULL
	, [BetType] SMALLINT NOT NULL
	, [IsLive] BIT NOT NULL
	, [SettingType] TINYINT NOT NULL
	, [IsDefault] BIT NOT NULL
	, [DefaultValueSuper] DECIMAL(11,8) NULL
	, [DefaultValueMaster] DECIMAL(11,8) NULL
	, [DefaultValueAgent] DECIMAL(11,8) NULL
	, [DefaultValueMember] DECIMAL(11,8) NULL
	, [SpecialRequirement] VARCHAR(MAX) NULL
	, CONSTRAINT [PK_Dep_Initial_ProductConfig_Detail] PRIMARY KEY ([ConfigID] ASC, [SportType] ASC, [BetType] ASC, [IsLive] ASC, [SettingType] ASC)
)
GO


CREATE TABLE [dbo].[Dep_Initial_StepByConfig]
(
	  [StepID] TINYINT NOT NULL
	, [IsScanCustomer] BIT NULL
	, [SortOrder] TINYINT NOT NULL IDENTITY(1,1)
)
GO


CREATE TABLE [dbo].[Dep_ProductBetSetting]
(
	  [Sporttype] INT NOT NULL
	, [Bettype] SMALLINT NOT NULL
	, [Currency] TINYINT NOT NULL
	, [MinBet] MONEY NULL
	, [MaxBet] MONEY NULL
	, [MaxPerMatch] MONEY NULL
	, [DefaultMinBet] MONEY NULL
	, [DefaultMaxBet] MONEY NULL
	, [DefaultMaxPerMatch] MONEY NULL
	, [MaxPerBall] DECIMAL(19,8) NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_Dep_ProductBetSetting] PRIMARY KEY ([Sporttype] ASC, [Bettype] ASC, [Currency] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_Dep_ProductBetSetting_RepUpdateTime] ON [dbo].[Dep_ProductBetSetting] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[Dep_ProductBetSetting] ADD CONSTRAINT [DF_Dep_ProductBetSetting_Minbet] DEFAULT ((0)) FOR [MinBet]; 
GO


CREATE TABLE [dbo].[Dep_ProductSetting]
(
	  [ProductSettingID] INT NOT NULL
	, [ProductID] SMALLINT NOT NULL
	, [SettingType] TINYINT NOT NULL
	, [TemplateID] TINYINT NOT NULL
	, [DisplayOrder] TINYINT NOT NULL
	, [SettingLevel] TINYINT NOT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_Dep_ProductSetting] PRIMARY KEY ([ProductSettingID] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_Dep_ProductSetting_RepUpdateTime] ON [dbo].[Dep_ProductSetting] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[Dep_ProductSetting] ADD CONSTRAINT [DF_Dep_ProductSetting_TemplateID] DEFAULT ((0)) FOR [TemplateID]; 
GO


CREATE TABLE [dbo].[Dep_ProductSettingDetail]
(
	  [ProductSettingID] INT NOT NULL
	, [SportType] SMALLINT NOT NULL
	, [BetType] SMALLINT NOT NULL
	, [IsLive] BIT NOT NULL
	, [MaxDefaultValue] DECIMAL(19,8) NULL
	, [SettingStatus] TINYINT NULL
	, [MinDefaultValue] DECIMAL(19,8) NULL
	, [IsApplyBA] BIT NOT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_Dep_ProductSettingDetail] PRIMARY KEY ([ProductSettingID] ASC, [SportType] ASC, [BetType] ASC, [IsLive] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_Dep_ProductSettingDetail_RepUpdateTime] ON [dbo].[Dep_ProductSettingDetail] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[Dep_ProductSettingDetail] ADD CONSTRAINT [DF_Dep_ProductSettingDetail_IsApplyBA] DEFAULT ((0)) FOR [IsApplyBA]; 
GO
ALTER TABLE [dbo].[Dep_ProductSettingDetail] ADD CONSTRAINT [DF_Dep_ProductSettingDetail_MaxDefaultValue] DEFAULT ((0)) FOR [MaxDefaultValue]; 
GO


CREATE TABLE [dbo].[Dep_ProductSettingType]
(
	  [SettingType] TINYINT NOT NULL
	, [SettingName] VARCHAR(30) NULL
	, [SettingNameDetail] VARCHAR(30) NULL
	, CONSTRAINT [PK_Dep_ProductSettingType] PRIMARY KEY ([SettingType] ASC)
)
GO


CREATE TABLE [dbo].[Dep_ProductStakeLevelGroup]
(
	  [Sporttype] SMALLINT NOT NULL
	, [GameGroupID] TINYINT NOT NULL
	, [MinBet] MONEY NOT NULL
	, [MaxBet] MONEY NOT NULL
	, [LicenseeGroupID] TINYINT NOT NULL
	, [Remark] VARCHAR(1000) NULL
	, [RepUpdateTime] DATETIME2(7) NOT NULL
	, [SiteID] INT NOT NULL
	, [isDeleted] BIT NOT NULL
	, CONSTRAINT [PK_Dep_ProductStakeLevelGroup] PRIMARY KEY ([Sporttype] ASC, [GameGroupID] ASC, [LicenseeGroupID] ASC, [SiteID] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_Dep_ProductStakeLevelGroup_RepUpdateTime] ON [dbo].[Dep_ProductStakeLevelGroup] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[Dep_ProductStakeLevelGroup] ADD CONSTRAINT [DF_Dep_ProductStakeLevelGroup_isDeleted] DEFAULT ((0)) FOR [isDeleted]; 
GO
ALTER TABLE [dbo].[Dep_ProductStakeLevelGroup] ADD CONSTRAINT [DF_Dep_ProductStakeLevelGroup_SiteID] DEFAULT ((0)) FOR [SiteID]; 
GO
ALTER TABLE [dbo].[Dep_ProductStakeLevelGroup] ADD CONSTRAINT [DF_Dep_ProductStakeLevelGroup_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO


CREATE TABLE [dbo].[Dep_ProductStatusProfile]
(
	  [Sporttype] SMALLINT NOT NULL
	, [Bettype] SMALLINT NOT NULL
	, [bitmapOrder] TINYINT NOT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_Dep_ProductStatusProfile] PRIMARY KEY ([Sporttype] ASC, [Bettype] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_Dep_ProductStatusProfile_RepUpdateTime] ON [dbo].[Dep_ProductStatusProfile] ([RepUpdateTime] ASC);
GO



CREATE TABLE [dbo].[Dep_StakeLevel]
(
	  [StakeLevelID] INT NOT NULL
	, [GameTypeID] SMALLINT NOT NULL
	, [GameGroupID] SMALLINT NOT NULL
	, [MinLabel] NVARCHAR(50) NULL
	, [MaxLabel] NVARCHAR(50) NULL
	, [MinStake] DECIMAL(19,8) NULL
	, [MaxStake] DECIMAL(19,8) NULL
	, [ExchangeID] INT NULL
	, [ResourceId] VARCHAR(20) NULL
	, [SiteID] INT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_Dep_StakeLevel] PRIMARY KEY ([StakeLevelID] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_Dep_StakeLevel_RepUpdateTime] ON [dbo].[Dep_StakeLevel] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[Dep_StakeLevel] ADD CONSTRAINT [DF_Dep_StakeLevel_GameGroupID] DEFAULT ((0)) FOR [GameGroupID]; 
GO


CREATE TABLE [dbo].[Dep_StakeLevel_History]
(
	  [StakeLevelID] INT NOT NULL
	, [GameTypeID] SMALLINT NOT NULL
	, [MaxLabel] NVARCHAR(50) NULL
	, [MaxStake] DECIMAL(19,8) NULL
	, [SiteID] INT NULL
	, [UpdateTime] DATETIME NOT NULL
	, CONSTRAINT [PK_Dep_StakeLevel_History] PRIMARY KEY ([StakeLevelID] ASC, [UpdateTime] ASC)
)
GO


CREATE TABLE [dbo].[Dep_StakeLevelGroupDetail]
(
	  [StakeLevelID] INT NOT NULL
	, [GameTypeID] SMALLINT NOT NULL
	, [MinLabel] NVARCHAR(50) NULL
	, [MaxLabel] NVARCHAR(50) NULL
	, [MinStake] DECIMAL(19,8) NULL
	, [MaxStake] DECIMAL(19,8) NULL
	, [ParentTypeID] INT NULL
	, [MaxGameStake] DECIMAL(19,8) NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_Dep_StakeLevelGroupDetail] PRIMARY KEY ([StakeLevelID] ASC, [GameTypeID] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_Dep_StakeLevelGroupDetail_RepUpdateTime] ON [dbo].[Dep_StakeLevelGroupDetail] ([RepUpdateTime] ASC);
GO



CREATE TABLE [dbo].[Dep_StakeLevelGroupDetail_History]
(
	  [StakeLevelID] INT NOT NULL
	, [GameTypeID] SMALLINT NOT NULL
	, [MaxLabel] NVARCHAR(50) NULL
	, [MaxStake] DECIMAL(19,8) NULL
	, [MaxGameStake] DECIMAL(19,8) NULL
	, [UpdateTime] DATETIME NOT NULL
	, CONSTRAINT [PK_Dep_StakeLevelGroupDetail_History] PRIMARY KEY ([StakeLevelID] ASC, [GameTypeID] ASC, [UpdateTime] ASC)
)
GO


CREATE TABLE [dbo].[Dep_UMConfig]
(
	  [FunctionType] TINYINT NOT NULL
	, [ProductID] TINYINT NOT NULL
	, [SettingType] TINYINT NOT NULL
	, [LicenseeID] INT NOT NULL
	, [BeginTime] SMALLDATETIME NULL
	, [EndTime] SMALLDATETIME NULL
	, [Time_Stamp] TIMESTAMP NULL
	, CONSTRAINT [PK_Dep_UMConfig] PRIMARY KEY ([FunctionType] ASC, [ProductID] ASC, [SettingType] ASC, [LicenseeID] ASC)
)
GO


CREATE TABLE [dbo].[DomainManagement]
(
	  [DomainID] SMALLINT NOT NULL IDENTITY(1,1)
	, [Domain] VARCHAR(50) NOT NULL
	, [System] VARCHAR(20) NOT NULL
	, [Site] VARCHAR(500) NOT NULL
	, [BrandName] VARCHAR(10) NULL
	, [Status] TINYINT NOT NULL
	, [ExpiredDate] DATETIME NULL
	, [LastUpdateTime] DATETIME NOT NULL
	, [RestrictedCountries] VARCHAR(4000) NULL
	, [Remark] NVARCHAR(2000) NULL
	, [isDeleted] BIT NOT NULL
	, [RepUpdateTime] DATETIME2(7) NOT NULL
	, CONSTRAINT [PK_DomainManagement] PRIMARY KEY ([DomainID] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_DomainManagement_RepUpdateTime] ON [dbo].[DomainManagement] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[DomainManagement] ADD CONSTRAINT [DF_DomainManagement_LastUpdateTime] DEFAULT (getdate()) FOR [LastUpdateTime]; 
GO
ALTER TABLE [dbo].[DomainManagement] ADD CONSTRAINT [DF_DomainManagement_isDeleted] DEFAULT ((0)) FOR [isDeleted]; 
GO
ALTER TABLE [dbo].[DomainManagement] ADD CONSTRAINT [DF_DomainManagement_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO


CREATE TABLE [dbo].[GameGroup]
(
	  [GameGroupID] INT NOT NULL
	, [RefSportType] SMALLINT NOT NULL
	, [RefBetType] INT NOT NULL
	, [GroupName] NVARCHAR(100) NULL
	, [IsDeposit] BIT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_GameGroup] PRIMARY KEY ([GameGroupID] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_GameGroup_RepUpdateTime] ON [dbo].[GameGroup] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[GameGroup] ADD CONSTRAINT [DF_GameGroup_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO
ALTER TABLE [dbo].[GameGroup] ADD DEFAULT ((0)) FOR [IsDeposit]; 
GO
ALTER TABLE [dbo].[GameGroup] ADD CONSTRAINT [DF_GameGroup_RefSportType] DEFAULT ((0)) FOR [RefSportType]; 
GO
ALTER TABLE [dbo].[GameGroup] ADD CONSTRAINT [DF_GameGroup_RefBetType] DEFAULT ((0)) FOR [RefBetType]; 
GO


CREATE TABLE [dbo].[GameLaunchPerCurrency]
(
	  [SportType] SMALLINT NOT NULL
	, [BetType] INT NOT NULL
	, [Currency] INT NOT NULL
	, [IsLaunched] BIT NOT NULL
	, [IsTest] BIT NOT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_GameLaunchPerCurrency] PRIMARY KEY ([SportType] ASC, [BetType] ASC, [Currency] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_GameLaunchPerCurrency_RepUpdateTime] ON [dbo].[GameLaunchPerCurrency] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[GameLaunchPerCurrency] ADD CONSTRAINT [DF_GameLaunchPerCurrency_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO
ALTER TABLE [dbo].[GameLaunchPerCurrency] ADD DEFAULT ((0)) FOR [IsLaunched]; 
GO
ALTER TABLE [dbo].[GameLaunchPerCurrency] ADD DEFAULT ((0)) FOR [IsTest]; 
GO


CREATE TABLE [dbo].[GameLaunchPerSite]
(
	  [SportType] SMALLINT NOT NULL
	, [BetType] INT NOT NULL
	, [SiteID] INT NOT NULL
	, [IsLaunched] BIT NOT NULL
	, [IsTest] BIT NOT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_GameLaunchPerSite] PRIMARY KEY ([SportType] ASC, [BetType] ASC, [SiteID] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_GameLaunchPerSite_RepUpdateTime] ON [dbo].[GameLaunchPerSite] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[GameLaunchPerSite] ADD CONSTRAINT [DF_GameLaunchPerSite_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO
ALTER TABLE [dbo].[GameLaunchPerSite] ADD DEFAULT ((0)) FOR [IsLaunched]; 
GO
ALTER TABLE [dbo].[GameLaunchPerSite] ADD DEFAULT ((0)) FOR [IsTest]; 
GO


CREATE TABLE [dbo].[GameRoundBetLimitSettings]
(
	  [SportType] SMALLINT NOT NULL
	, [BetType] INT NOT NULL
	, [ProductID] TINYINT NULL
	, [GameRoundBetLimit] MONEY NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_GameRoundBetLimitSettings] PRIMARY KEY ([SportType] ASC, [BetType] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_GameRoundBetLimitSettings_RepUpdateTime] ON [dbo].[GameRoundBetLimitSettings] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[GameRoundBetLimitSettings] ADD CONSTRAINT [DF_GameRoundBetLimitSettings_GameRoundBetLimit] DEFAULT ((0)) FOR [GameRoundBetLimit]; 
GO
ALTER TABLE [dbo].[GameRoundBetLimitSettings] ADD CONSTRAINT [DF_GameRoundBetLimitSettings_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO


CREATE TABLE [dbo].[Initial_ProductConfig]
(
	  [ConfigID] INT NOT NULL IDENTITY(1,1)
	, [ProductID] TINYINT NOT NULL
	, [SportTypeList] VARCHAR(300) NOT NULL
	, [BetTypeList] VARCHAR(300) NOT NULL
	, [Site] VARCHAR(MAX) NOT NULL
	, [Currency] VARCHAR(MAX) NOT NULL
	, [StartTime] DATETIME NOT NULL
	, [EndTime] DATETIME NULL
	, [IsTest] BIT NOT NULL
	, [Status] TINYINT NULL
	, [CurrentStep] TINYINT NULL
	, [ProcessedStep] VARCHAR(500) NULL
	, [Remark] VARCHAR(1000) NULL
	, CONSTRAINT [PK_Initial_ProductConfig] PRIMARY KEY ([ConfigID] ASC)
)
GO


CREATE TABLE [dbo].[Initial_ProductConfig_Detail]
(
	  [ConfigID] INT NOT NULL
	, [SportType] SMALLINT NOT NULL
	, [BetType] SMALLINT NOT NULL
	, [IsLive] BIT NOT NULL
	, [SettingType] TINYINT NOT NULL
	, [IsDefault] BIT NOT NULL
	, [CopyFromSportType] SMALLINT NULL
	, [CopyFromBetType] SMALLINT NULL
	, [DefaultValueSuper] DECIMAL(11,8) NULL
	, [DefaultValueMaster] DECIMAL(11,8) NULL
	, [DefaultValueAgent] DECIMAL(11,8) NULL
	, [DefaultValueMember] DECIMAL(11,8) NULL
	, [SpecialRequirement] VARCHAR(MAX) NULL
	, CONSTRAINT [PK_Initial_ProductConfig_Detail] PRIMARY KEY ([ConfigID] ASC, [SportType] ASC, [BetType] ASC, [IsLive] ASC, [SettingType] ASC)
)
GO


CREATE TABLE [dbo].[Initial_StepByConfig]
(
	  [StepID] TINYINT NOT NULL
	, [IsScanCustomer] BIT NULL
	, [SortOrder] TINYINT NOT NULL IDENTITY(1,1)
)
GO


CREATE TABLE [dbo].[LossLimit_GlobalSetting]
(
	  [ProductId] TINYINT NOT NULL
	, [ExchangeId] INT NOT NULL
	, [MinLossLimit] MONEY NULL
	, [DefaultLossLimit] MONEY NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_LossLimit_GlobalSetting] PRIMARY KEY ([ProductId] ASC, [ExchangeId] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_LossLimit_GlobalSetting_RepUpdateTime] ON [dbo].[LossLimit_GlobalSetting] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[LossLimit_GlobalSetting] ADD CONSTRAINT [DF_LossLimit_GlobalSetting_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO


CREATE TABLE [dbo].[MaxPayoutGlobalSetting]
(
	  [SportType] INT NOT NULL
	, [BetType] SMALLINT NOT NULL
	, [Currency] TINYINT NOT NULL
	, [SingleMatchParlay] MONEY NOT NULL
	, [Combo2] MONEY NOT NULL
	, [Combo35] MONEY NOT NULL
	, [ComboOver6] MONEY NOT NULL
	, [SettingStatus] TINYINT NOT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_MaxPayoutGlobalSetting] PRIMARY KEY ([SportType] ASC, [BetType] ASC, [Currency] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_MaxPayoutGlobalSetting_RepUpdateTime] ON [dbo].[MaxPayoutGlobalSetting] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[MaxPayoutGlobalSetting] ADD CONSTRAINT [DF_MaxPayoutGlobalSetting_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO
ALTER TABLE [dbo].[MaxPayoutGlobalSetting] ADD CONSTRAINT [DF_MaxPayoutGlobalSetting_SingleMatchParlay] DEFAULT ((0)) FOR [SingleMatchParlay]; 
GO
ALTER TABLE [dbo].[MaxPayoutGlobalSetting] ADD CONSTRAINT [DF_MaxPayoutGlobalSetting_Combo2] DEFAULT ((0)) FOR [Combo2]; 
GO
ALTER TABLE [dbo].[MaxPayoutGlobalSetting] ADD CONSTRAINT [DF_MaxPayoutGlobalSetting_Combo35] DEFAULT ((0)) FOR [Combo35]; 
GO
ALTER TABLE [dbo].[MaxPayoutGlobalSetting] ADD CONSTRAINT [DF_MaxPayoutGlobalSetting_ComboOver6] DEFAULT ((0)) FOR [ComboOver6]; 
GO
ALTER TABLE [dbo].[MaxPayoutGlobalSetting] ADD CONSTRAINT [DF_MaxPayoutGlobalSetting_SettingStatus] DEFAULT ((0)) FOR [SettingStatus]; 
GO


CREATE TABLE [dbo].[MsgError]
(
	  [MsgID] INT NOT NULL
	, [MsgGroupID] INT NOT NULL
	, [MsgNameEN] NVARCHAR(500) NOT NULL
	, [MsgNameCT] NVARCHAR(500) NULL
	, [MsgNameCS] NVARCHAR(500) NULL
	, [MsgNameJP] NVARCHAR(500) NULL
	, [MsgNameTH] NVARCHAR(500) NULL
	, [MsgNameKO] NVARCHAR(500) NULL
	, [MsgNameES] NVARCHAR(500) NULL
	, [MsgNameVI] NVARCHAR(500) NULL
	, [IsActive] BIT NOT NULL
	, [MsgNameCN] NVARCHAR(500) NULL
	, [MsgNameIN] NVARCHAR(500) NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_MsgError] PRIMARY KEY ([MsgID] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_MsgError_RepUpdateTime] ON [dbo].[MsgError] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[MsgError] ADD CONSTRAINT [DF_MsgError_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO
/*
CREATE TRIGGER [dbo].[reminder2]
ON [bodb02].[dbo].[MsgError]
FOR UPDATE
AS
--exec CustDB.[dbo].DROPSYN
exec sp_dropserver DBTXN , 'droplogins'
--ROLLBACK TRANSACTION
GO
	ALTER TABLE [dbo].[MsgError] DISABLE TRIGGER [reminder2]
	GOCREATE TRIGGER [dbo].[Afterupdate]
ON [bodb02].[dbo].[MsgError]
after UPDATE
AS
--exec CustDB.[dbo].CREATESYN
commit transaction t1
GO
	ALTER TABLE [dbo].[MsgError] DISABLE TRIGGER [Afterupdate]
	GO
*/

CREATE TABLE [dbo].[MsgErrorGroup]
(
	  [MsgGroupID] INT NOT NULL
	, [MsgGroupName] NVARCHAR(100) NOT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_MsgErrorGroup] PRIMARY KEY ([MsgGroupID] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_MsgErrorGroup_RepUpdateTime] ON [dbo].[MsgErrorGroup] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[MsgErrorGroup] ADD CONSTRAINT [DF_MsgErrorGroup_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO


CREATE TABLE [dbo].[PlayCurrencySetting]
(
	  [ID] INT NOT NULL IDENTITY(1,1)
	, [SiteId] INT NULL
	, [SiteName] NVARCHAR(50) NULL
	, [SportType] INT NULL
	, [MemberCurrency] INT NULL
	, [PlayCurrency] INT NULL
	, [FromDate] DATE NULL
	, [ToDate] DATE NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_PlayCurrencySetting] PRIMARY KEY ([ID] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_PlayCurrencySetting_RepUpdateTime] ON [dbo].[PlayCurrencySetting] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[PlayCurrencySetting] ADD CONSTRAINT [DF_PlayCurrencySetting_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO


CREATE TABLE [dbo].[ProblemAccountReason]
(
	  [ReasonID] TINYINT NOT NULL
	, [ReasonName] VARCHAR(100) NOT NULL
	, [IsCN88] BIT NOT NULL
	, [IsCredit] BIT NOT NULL
	, [IsLicensee] BIT NOT NULL
	, [ReasonNameCS] NVARCHAR(100) NULL
	, [ReasonGroupID] TINYINT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_ProblemAccountReason] PRIMARY KEY ([ReasonID] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_ProblemAccountReason_RepUpdateTime] ON [dbo].[ProblemAccountReason] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[ProblemAccountReason] ADD CONSTRAINT [DF_ProblemAccountReason_IsCN88] DEFAULT ((0)) FOR [IsCN88]; 
GO
ALTER TABLE [dbo].[ProblemAccountReason] ADD CONSTRAINT [DF_ProblemAccountReason_IsCredit] DEFAULT ((0)) FOR [IsCredit]; 
GO
ALTER TABLE [dbo].[ProblemAccountReason] ADD CONSTRAINT [DF_ProblemAccountReason_IsLicensee] DEFAULT ((0)) FOR [IsLicensee]; 
GO


CREATE TABLE [dbo].[ProductBetSetting]
(
	  [Sporttype] SMALLINT NOT NULL
	, [Bettype] SMALLINT NOT NULL
	, [Currency] TINYINT NOT NULL
	, [MinBet] MONEY NULL
	, [IsDep] BIT NULL
	, [MaxBet] MONEY NULL
	, [MaxPerMatch] MONEY NULL
	, [DefaultMinBet] MONEY NULL
	, [DefaultMaxBet] MONEY NULL
	, [DefaultMaxPerMatch] MONEY NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_ProductBetSetting] PRIMARY KEY ([Sporttype] ASC, [Bettype] ASC, [Currency] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_ProductBetSetting_RepUpdateTime] ON [dbo].[ProductBetSetting] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[ProductBetSetting] ADD CONSTRAINT [DF_ProductBetSetting_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO
ALTER TABLE [dbo].[ProductBetSetting] ADD CONSTRAINT [DF_ProductBetSetting_Minbet] DEFAULT ((0)) FOR [MinBet]; 
GO


CREATE TABLE [dbo].[ProductGlobalSetting]
(
	  [Sporttype] SMALLINT NOT NULL
	, [Bettype] SMALLINT NOT NULL
	, [MaxPositiontaking] SMALLMONEY NULL
	, [Maxsdiscount] DECIMAL(9,8) NULL
	, [IsDep] BIT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_ProductGlobalSetting] PRIMARY KEY ([Sporttype] ASC, [Bettype] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_ProductGlobalSetting_RepUpdateTime] ON [dbo].[ProductGlobalSetting] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[ProductGlobalSetting] ADD CONSTRAINT [DF_ProductGlobalSetting_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO
ALTER TABLE [dbo].[ProductGlobalSetting] ADD CONSTRAINT [DF_ProductGlobalSetting_MaxPositiontaking] DEFAULT ((0)) FOR [MaxPositiontaking]; 
GO
ALTER TABLE [dbo].[ProductGlobalSetting] ADD CONSTRAINT [DF_ProductGlobalSetting_Maxsdiscount] DEFAULT ((0)) FOR [Maxsdiscount]; 
GO


CREATE TABLE [dbo].[ProductLaunchedSiteCurrency]
(
	  [SiteID] INT NOT NULL
	, [Currency] INT NOT NULL
	, [SportType] SMALLINT NOT NULL
	, [IsLaunched] BIT NOT NULL
	, [IsTest] TINYINT NOT NULL
	, [BetType] SMALLINT NOT NULL
	, [LaunchedLevel] TINYINT NOT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_ProductLaunchedSiteCurrency] PRIMARY KEY ([SiteID] ASC, [Currency] ASC, [SportType] ASC, [BetType] ASC, [LaunchedLevel] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_ProductLaunchedSiteCurrency_RepUpdateTime] ON [dbo].[ProductLaunchedSiteCurrency] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[ProductLaunchedSiteCurrency] ADD CONSTRAINT [DF_ProductLaunchedSiteCurrency_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO
ALTER TABLE [dbo].[ProductLaunchedSiteCurrency] ADD CONSTRAINT [DF_ProductLaunchedSiteCurrency_BetType] DEFAULT ((0)) FOR [BetType]; 
GO
ALTER TABLE [dbo].[ProductLaunchedSiteCurrency] ADD CONSTRAINT [DF_ProductLaunchedSiteCurrency_LaunchedLevel] DEFAULT ((0)) FOR [LaunchedLevel]; 
GO


CREATE TABLE [dbo].[ProductProfileSiteCurrency]
(
	  [SiteID] INT NOT NULL
	, [Currency] INT NOT NULL
	, [ProductSettingID] INT NOT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_ProductProfileSiteCurrency] PRIMARY KEY ([SiteID] ASC, [Currency] ASC, [ProductSettingID] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_ProductProfileSiteCurrency_RepUpdateTime] ON [dbo].[ProductProfileSiteCurrency] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[ProductProfileSiteCurrency] ADD CONSTRAINT [DF_ProductProfileSiteCurrency_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO


CREATE TABLE [dbo].[ProductProfileSiteCurrency_UAT]
(
	  [SiteID] INT NOT NULL
	, [Currency] INT NOT NULL
	, [ProductSettingID] INT NOT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_ProductProfileSiteCurrency_UAT] PRIMARY KEY ([SiteID] ASC, [Currency] ASC, [ProductSettingID] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_ProductProfileSiteCurrency_UAT_RepUpdateTime] ON [dbo].[ProductProfileSiteCurrency_UAT] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[ProductProfileSiteCurrency_UAT] ADD CONSTRAINT [DF_ProductProfileSiteCurrency_UAT_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO



CREATE TABLE [dbo].[ProductSettingProfile]
(
	  [ProductSettingID] INT NOT NULL
	, [SettingType] SMALLINT NOT NULL
	, [SportType] SMALLINT NOT NULL
	, [BetType] SMALLINT NOT NULL
	, [IsLive] BIT NOT NULL
	, [ProductID] TINYINT NOT NULL
	, [MaxPT] SMALLMONEY NULL
	, [MaxDiscount] DECIMAL(9,8) NULL
	, [IsSync] BIT NULL
	, [IsHidden] BIT NULL
	, [IsDisabled] BIT NULL
	, [SettingLevel] TINYINT NULL
	, [DisplayOrder] TINYINT NOT NULL
	, [SettingStatus] TINYINT NULL
	, [IntervalValue] DECIMAL(19,8) NULL
	, [RealProductId] TINYINT NOT NULL
	, [MaxChoice] TINYINT NULL
	, [Parent_ProductSettingID] INT NULL
	, [Child_DisplayOrder] INT NULL
	, [SubType] TINYINT NULL
	, [GroupID] TINYINT NULL
	, [GroupType] TINYINT NULL
	, [GroupTypeOrder] TINYINT NULL
	, [SubGroupID] TINYINT NULL
	, [SubGroupOrder] TINYINT NULL
	, [CreationStatus] TINYINT NULL
	, [DisplayType] TINYINT NULL
	, [MarketType] TINYINT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_ProductSettingProfile] PRIMARY KEY ([ProductSettingID] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_ProductSettingProfile_GroupType] ON [dbo].[ProductSettingProfile] ([GroupType] ASC);
GO

CREATE NONCLUSTERED INDEX [IX_ProductSettingProfile_RepUpdateTime] ON [dbo].[ProductSettingProfile] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[ProductSettingProfile] ADD CONSTRAINT [DF_ProductSettingProfile_MaxPT] DEFAULT ((90)) FOR [MaxPT]; 
GO
ALTER TABLE [dbo].[ProductSettingProfile] ADD CONSTRAINT [DF_ProductSettingProfile_MaxDiscount] DEFAULT ((0.01)) FOR [MaxDiscount]; 
GO
ALTER TABLE [dbo].[ProductSettingProfile] ADD CONSTRAINT [DF_ProductSettingProfile_IsSync] DEFAULT ((0)) FOR [IsSync]; 
GO
ALTER TABLE [dbo].[ProductSettingProfile] ADD CONSTRAINT [DF_ProductSettingProfile_IsHidden] DEFAULT ((1)) FOR [IsHidden]; 
GO
ALTER TABLE [dbo].[ProductSettingProfile] ADD CONSTRAINT [DF_ProductSettingProfile_IsDisabled] DEFAULT ((0)) FOR [IsDisabled]; 
GO
ALTER TABLE [dbo].[ProductSettingProfile] ADD CONSTRAINT [DF_ProductSettingProfile_DisplayOrder] DEFAULT ((0)) FOR [DisplayOrder]; 
GO
ALTER TABLE [dbo].[ProductSettingProfile] ADD CONSTRAINT [DF_ProductSettingProfile_SettingStatus] DEFAULT ((0)) FOR [SettingStatus]; 
GO
ALTER TABLE [dbo].[ProductSettingProfile] ADD CONSTRAINT [DF_ProductSettingProfile_CreationStatus] DEFAULT ((0)) FOR [CreationStatus]; 
GO
ALTER TABLE [dbo].[ProductSettingProfile] ADD CONSTRAINT [DF_ProductSettingProfile_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO


CREATE TABLE [dbo].[ProductSettingProfile_UAT]
(
	  [ProductSettingID] INT NOT NULL
	, [SettingType] SMALLINT NOT NULL
	, [SportType] SMALLINT NOT NULL
	, [BetType] SMALLINT NOT NULL
	, [IsLive] BIT NOT NULL
	, [ProductID] TINYINT NOT NULL
	, [MaxPT] SMALLMONEY NULL
	, [MaxDiscount] DECIMAL(9,8) NULL
	, [IsSync] BIT NULL
	, [IsHidden] BIT NULL
	, [IsDisabled] BIT NULL
	, [SettingLevel] TINYINT NULL
	, [DisplayOrder] TINYINT NOT NULL
	, [SettingStatus] TINYINT NULL
	, [IntervalValue] DECIMAL(19,8) NULL
	, [RealProductId] TINYINT NOT NULL
	, [MaxChoice] TINYINT NULL
	, [Parent_ProductSettingID] INT NULL
	, [Child_DisplayOrder] INT NULL
	, [SubType] TINYINT NULL
	, [GroupID] TINYINT NULL
	, [GroupType] TINYINT NULL
	, [GroupTypeOrder] TINYINT NULL
	, [SubGroupID] TINYINT NULL
	, [SubGroupOrder] TINYINT NULL
	, [CreationStatus] TINYINT NULL
	, [DisplayType] TINYINT NULL
	, [MarketType] TINYINT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_ProductSettingProfile_UAT] PRIMARY KEY ([ProductSettingID] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_ProductSettingProfile_UAT_GroupType] ON [dbo].[ProductSettingProfile_UAT] ([GroupType] ASC);
GO

CREATE NONCLUSTERED INDEX [IX_ProductSettingProfile_UAT_RepUpdateTime] ON [dbo].[ProductSettingProfile_UAT] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[ProductSettingProfile_UAT] ADD CONSTRAINT [DF_ProductSettingProfile_UAT_MaxPT] DEFAULT ((90)) FOR [MaxPT]; 
GO
ALTER TABLE [dbo].[ProductSettingProfile_UAT] ADD CONSTRAINT [DF_ProductSettingProfile_UAT_MaxDiscount] DEFAULT ((0.01)) FOR [MaxDiscount]; 
GO
ALTER TABLE [dbo].[ProductSettingProfile_UAT] ADD CONSTRAINT [DF_ProductSettingProfile_UAT_IsSync] DEFAULT ((0)) FOR [IsSync]; 
GO
ALTER TABLE [dbo].[ProductSettingProfile_UAT] ADD CONSTRAINT [DF_ProductSettingProfile_UAT_IsHidden] DEFAULT ((1)) FOR [IsHidden]; 
GO
ALTER TABLE [dbo].[ProductSettingProfile_UAT] ADD CONSTRAINT [DF_ProductSettingProfile_UAT_IsDisabled] DEFAULT ((0)) FOR [IsDisabled]; 
GO
ALTER TABLE [dbo].[ProductSettingProfile_UAT] ADD CONSTRAINT [DF_ProductSettingProfile_UAT_DisplayOrder] DEFAULT ((0)) FOR [DisplayOrder]; 
GO
ALTER TABLE [dbo].[ProductSettingProfile_UAT] ADD CONSTRAINT [DF_ProductSettingProfile_UAT_SettingStatus] DEFAULT ((0)) FOR [SettingStatus]; 
GO
ALTER TABLE [dbo].[ProductSettingProfile_UAT] ADD CONSTRAINT [DF_ProductSettingProfile_UAT_CreationStatus] DEFAULT ((0)) FOR [CreationStatus]; 
GO
ALTER TABLE [dbo].[ProductSettingProfile_UAT] ADD CONSTRAINT [DF_ProductSettingProfile_UAT_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO


CREATE TABLE [dbo].[ProductSettingSystemDisplay]
(
	  [SystemID] TINYINT NOT NULL
	, [ProductID] TINYINT NOT NULL
	, [SettingType] SMALLINT NOT NULL
	, [DisplayMode] TINYINT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_ProductSettingSystemDisplay] PRIMARY KEY ([SystemID] ASC, [ProductID] ASC, [SettingType] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_ProductSettingSystemDisplay_RepUpdateTime] ON [dbo].[ProductSettingSystemDisplay] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[ProductSettingSystemDisplay] ADD CONSTRAINT [DF_ProductSettingSystemDisplay_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO


CREATE TABLE [dbo].[ProductSettingSystemDisplay_UAT]
(
	  [SystemID] TINYINT NOT NULL
	, [ProductID] TINYINT NOT NULL
	, [SettingType] SMALLINT NOT NULL
	, [DisplayMode] TINYINT NULL
)
GO


CREATE TABLE [dbo].[ProductSettingType]
(
	  [SettingType] TINYINT NOT NULL
	, [SettingName] VARCHAR(30) NULL
	, [SettingNameDetail] VARCHAR(200) NULL
	, CONSTRAINT [PK_ProductSettingType] PRIMARY KEY ([SettingType] ASC)
)
GO


CREATE TABLE [dbo].[ProductSettingUpdateRestriction]
(
	  [SystemID] TINYINT NOT NULL
	, [ProductID] TINYINT NOT NULL
	, [SettingType] SMALLINT NOT NULL
	, [ActorRoleID] TINYINT NOT NULL
	, [TargetRoleID] TINYINT NOT NULL
	, [ErrCode] INT NULL
	, [RestrictionMode] TINYINT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_ProductSettingUpdateRestriction] PRIMARY KEY ([SystemID] ASC, [ProductID] ASC, [SettingType] ASC, [ActorRoleID] ASC, [TargetRoleID] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_ProductSettingUpdateRestriction_RepUpdateTime] ON [dbo].[ProductSettingUpdateRestriction] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[ProductSettingUpdateRestriction] ADD CONSTRAINT [DF_ProductSettingUpdateRestriction_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO


CREATE TABLE [dbo].[ProductStakeLevelGroup]
(
	  [Sporttype] SMALLINT NOT NULL
	, [GameGroupID] TINYINT NOT NULL
	, [MinBet] MONEY NOT NULL
	, [MaxBet] MONEY NOT NULL
	, [CreditGroupID] TINYINT NOT NULL
	, [Remark] VARCHAR(1000) NULL
	, [RepUpdateTime] DATETIME2(7) NOT NULL
	, [isDeleted] BIT NOT NULL
	, CONSTRAINT [PK_ProductStakeLevelGroup] PRIMARY KEY ([Sporttype] ASC, [GameGroupID] ASC, [CreditGroupID] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_ProductStakeLevelGroup_RepUpdateTime] ON [dbo].[ProductStakeLevelGroup] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[ProductStakeLevelGroup] ADD CONSTRAINT [DF_ProductStakeLevelGroup_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO
ALTER TABLE [dbo].[ProductStakeLevelGroup] ADD CONSTRAINT [DF_ProductStakeLevelGroup_isDeleted] DEFAULT ((0)) FOR [isDeleted]; 
GO


CREATE TABLE [dbo].[ProductStatusProfile]
(
	  [Sporttype] SMALLINT NOT NULL
	, [Bettype] SMALLINT NOT NULL
	, [bitmapOrder] TINYINT NOT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_ProductStatusProfile] PRIMARY KEY ([Sporttype] ASC, [Bettype] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_ProductStatusProfile_RepUpdateTime] ON [dbo].[ProductStatusProfile] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[ProductStatusProfile] ADD CONSTRAINT [DF_ProductStatusProfile_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO


CREATE TABLE [dbo].[ProductStatusSiteCurrency]
(
	  [SportType] SMALLINT NOT NULL
	, [BetType] SMALLINT NOT NULL
	, [Currency] INT NOT NULL
	, [SiteID] INT NOT NULL
	, [IsHidden] BIT NOT NULL
	, [IsDisabled] BIT NOT NULL
	, [HasSynced] BIT NOT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_ProductStatusSiteCurrency] PRIMARY KEY ([SportType] ASC, [BetType] ASC, [Currency] ASC, [SiteID] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_ProductStatusSiteCurrency_RepUpdateTime] ON [dbo].[ProductStatusSiteCurrency] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[ProductStatusSiteCurrency] ADD DEFAULT ((1)) FOR [HasSynced]; 
GO
ALTER TABLE [dbo].[ProductStatusSiteCurrency] ADD CONSTRAINT [DF_ProductStatusSiteCurrency_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO


CREATE TABLE [dbo].[ProfilePicture]
(
	  [ImageId] INT NOT NULL
	, [Image] VARBINARY(MAX) NOT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, [IsDeleted] BIT NULL
	, CONSTRAINT [PK_ProfilePicture] PRIMARY KEY ([ImageId] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_RepUpdateTime_ProfilePicture] ON [dbo].[ProfilePicture] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[ProfilePicture] ADD CONSTRAINT [DF_ProfilePicture_IsDeleted] DEFAULT ((0)) FOR [IsDeleted]; 
GO


CREATE TABLE [dbo].[SettingSystem]
(
	  [SystemID] TINYINT NOT NULL
	, [SystemName] VARCHAR(50) NULL
	, [Description] VARCHAR(100) NULL
	, [SystemPrefix] VARCHAR(10) NULL
	, CONSTRAINT [PK_SettingSystem] PRIMARY KEY ([SystemID] ASC)
)
GO


CREATE TABLE [dbo].[Site]
(
	  [siteid] INT NOT NULL IDENTITY(1,1)
	, [site] NVARCHAR(50) NULL
	, [type] NVARCHAR(50) NULL
	, [spreada] FLOAT NULL
	, [spreadb] FLOAT NULL
	, [spreadc] FLOAT NULL
	, [spreadd] FLOAT NULL
	, [spreade] FLOAT NULL
	, [spreadf] FLOAT NULL
	, [ServerID] INT NOT NULL
	, [isLicensee] BIT NOT NULL
	, [isActive] BIT NOT NULL
	, [isDeposit] BIT NOT NULL
	, [SpecialGroup] TINYINT NULL
	, [BlockNewCust] BIT NULL
	, [UnblockTime] VARCHAR(50) NULL
	, [IsChinaView] BIT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, [SiteDBGroupID] SMALLINT NOT NULL
	, [SiteLabel] VARCHAR(50) NULL
	, [SpecialPlatfrom] TINYINT NULL
	, [CustDBGroupID] SMALLINT NOT NULL
	, [SiteType] TINYINT NULL
	, CONSTRAINT [PK_Site] PRIMARY KEY ([siteid] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_RepUpdateTime] ON [dbo].[Site] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[Site] ADD CONSTRAINT [DF_Site_SpecialPlatform] DEFAULT ((0)) FOR [SpecialPlatfrom]; 
GO
ALTER TABLE [dbo].[Site] ADD CONSTRAINT [DF_Site_SpecialGroup] DEFAULT ((0)) FOR [SpecialGroup]; 
GO
ALTER TABLE [dbo].[Site] ADD CONSTRAINT [DF_Site_SiteDBGroupID] DEFAULT ((0)) FOR [SiteDBGroupID]; 
GO
ALTER TABLE [dbo].[Site] ADD CONSTRAINT [DF_Site_SiteType] DEFAULT ((0)) FOR [SiteType]; 
GO
ALTER TABLE [dbo].[Site] ADD CONSTRAINT [DF_Site_isLicensee] DEFAULT ((0)) FOR [isLicensee]; 
GO
ALTER TABLE [dbo].[Site] ADD CONSTRAINT [DF_Site_isActive] DEFAULT ((1)) FOR [isActive]; 
GO
ALTER TABLE [dbo].[Site] ADD CONSTRAINT [DF_Site_ServerID] DEFAULT ((0)) FOR [ServerID]; 
GO
ALTER TABLE [dbo].[Site] ADD CONSTRAINT [DF_Site_CustDBGroupID] DEFAULT ((0)) FOR [CustDBGroupID]; 
GO
ALTER TABLE [dbo].[Site] ADD CONSTRAINT [DF_Site_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO
ALTER TABLE [dbo].[Site] ADD CONSTRAINT [DF_SettingSystem_BlockNewCust] DEFAULT ((0)) FOR [BlockNewCust]; 
GO

/*
CREATE TRIGGER [dbo].[trg_LOCAL_Site] ON [dbo].[Site]
AFTER UPDATE, INSERT
AS
BEGIN
	SET NOCOUNT ON;   
	
	IF EXISTS (SELECT i.SiteDBGroupID
				FROM INSERTED i
					INNER JOIN  DELETED d ON i.siteid = d.siteid
				WHERE d.Site = 'BEST-ODDS'
					AND ( i.SiteDBGroupID > 0 OR d.SiteDBGroupID > 0)
				)
	BEGIN

		DECLARE @tmp TABLE (eventtype VARCHAR(100), parameter VARCHAR(20),sqltext NVARCHAR(MAX))
	
		DECLARE  @str NVARCHAR(100)
				,@hostname VARCHAR(100)
				,@action as char(1)

		SET @str = 'DBCC INPUTBUFFER(' + CONVERT(NVARCHAR(100),@@SPID) + ') WITH NO_INFOMSGS'
		INSERT INTO @tmp (eventtype,parameter,sqltext)
		EXEC(@str)
	
		SELECT @hostname = hostname FROM sys.sysprocesses	WHERE spid = @@SPID	
	
		SET @action = (CASE WHEN EXISTS(SELECT * FROM DELETED)
								THEN
									CASE WHEN EXISTS(SELECT * FROM INSERTED)
										THEN 'U'  -- Set Action to Updated.
										ELSE 'D'  -- Set Action to Deleted.
									END
							WHEN EXISTS(SELECT * FROM INSERTED)
								THEN 'I'  -- Set Action to Insert.
							ELSE '' -- Skip. It may have been a "failed delete".   
						END)

		-- Helios Edit
		INSERT INTO tracking (username,dtime, UserAction,sqltext,hostname, tablename)
		SELECT SYSTEM_USER, CURRENT_TIMESTAMP, @action, sqltext , @hostname, 'Site'
		FROM @tmp


		-- Revision Code
		--INSERT INTO tracking (username,dtime,sqltext,hostname, tablename, tp )
		--SELECT SYSTEM_USER, CURRENT_TIMESTAMP, sqltext , @hostname, 'Site', @action
		--FROM @tmp
 END 

END
 
GO
	ALTER TABLE [dbo].[Site] DISABLE TRIGGER [trg_LOCAL_Site]
	GO

	*/
CREATE TABLE [dbo].[SiteDBConfig]
(
	  [SiteDBGroupID] SMALLINT NOT NULL
	, [LinkedServerName] VARCHAR(512) NULL
	, [ClientAccessName] VARCHAR(512) NULL
	, [AGIP] VARCHAR(50) NULL
	, [AWSProxyDomain] VARCHAR(50) NULL
	, [AWSProxyPort] INT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, [FQDN] VARCHAR(50) NULL
	, CONSTRAINT [PK_SiteDBConfig_SiteDBGroupID] PRIMARY KEY ([SiteDBGroupID] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_SiteDBConfig_RepUpdateTime] ON [dbo].[SiteDBConfig] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[SiteDBConfig] ADD CONSTRAINT [DF_SiteDBConfig_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO


CREATE TABLE [dbo].[SportBettypeSettingMatrix]
(
	  [SportType] SMALLINT NOT NULL
	, [BetType] INT NOT NULL
	, [isLicensee] BIT NOT NULL
	, [isLive] BIT NOT NULL
	, [Site] VARCHAR(50) NOT NULL
	, [isActive] BIT NOT NULL
	, [SportTypeRefPT] SMALLINT NULL
	, [BetTypeRefPT] INT NULL
	, [isLivePT] BIT NOT NULL
	, [TablePT] VARCHAR(50) NULL
	, [SportTypeRefComm] SMALLINT NULL
	, [BetTypeRefComm] INT NULL
	, [TableComm] VARCHAR(50) NULL
	, [SportTypeRefBetSetting] SMALLINT NULL
	, [BetTypeRefBetSetting] INT NULL
	, [TableBetSetting] VARCHAR(50) NULL
	, [IsLiveComm] BIT NOT NULL
	, [IsLiveBetSetting] BIT NOT NULL
	, [TableBettrans] VARCHAR(100) NULL
	, [SporttypeRefWinlossLimit] SMALLINT NULL
	, [BettypeRefWinlossLimit] SMALLINT NULL
	, [RealProductId] TINYINT NULL
	, [isDeleted] BIT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, [ProductID] TINYINT NULL
	, CONSTRAINT [PK_SportBettypeSettingMatrix] PRIMARY KEY ([SportType] ASC, [BetType] ASC, [isLicensee] ASC, [isLive] ASC, [Site] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_SportBettypeSettingMatrix_RepUpdateTime] ON [dbo].[SportBettypeSettingMatrix] ([RepUpdateTime] ASC);
GO

CREATE NONCLUSTERED INDEX [IX_SportBettypeSettingMatrix_SportType] ON [dbo].[SportBettypeSettingMatrix] ([SportType] ASC, [RealProductId] ASC, [ProductID] ASC);
GO

ALTER TABLE [dbo].[SportBettypeSettingMatrix] ADD CONSTRAINT [DF_SportBettypeSettingMatrix_isDeleted] DEFAULT ((0)) FOR [isDeleted]; 
GO
ALTER TABLE [dbo].[SportBettypeSettingMatrix] ADD CONSTRAINT [SportBettypeSettingMatrix_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO
ALTER TABLE [dbo].[SportBettypeSettingMatrix] ADD CONSTRAINT [DF_SportBettypeSettingMatrix_isActive] DEFAULT ((0)) FOR [isActive]; 
GO
ALTER TABLE [dbo].[SportBettypeSettingMatrix] ADD CONSTRAINT [DF_SportBettypeSettingMatrix_isLivePT] DEFAULT ((0)) FOR [isLivePT]; 
GO
ALTER TABLE [dbo].[SportBettypeSettingMatrix] ADD CONSTRAINT [SportBettypeSettingMatrix_IsLiveComm] DEFAULT ((0)) FOR [IsLiveComm]; 
GO
ALTER TABLE [dbo].[SportBettypeSettingMatrix] ADD CONSTRAINT [SportBettypeSettingMatrix_IsLiveBetSetting] DEFAULT ((0)) FOR [IsLiveBetSetting]; 
GO


CREATE TABLE [dbo].[SportNonOfferedSiteCurrency]
(
	  [SportType] SMALLINT NOT NULL
	, [BetType] INT NOT NULL
	, [Currency] INT NOT NULL
	, [SiteID] INT NOT NULL
	, [RealProductID] TINYINT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_SportNonOfferedSiteCurrency] PRIMARY KEY ([SportType] ASC, [BetType] ASC, [Currency] ASC, [SiteID] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_SportNonOfferedSiteCurrency_RepUpdateTime] ON [dbo].[SportNonOfferedSiteCurrency] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[SportNonOfferedSiteCurrency] ADD CONSTRAINT [DF_SportNonOfferedSiteCurrency_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO


CREATE TABLE [dbo].[StakeLevel]
(
	  [StakeLevelID] INT NOT NULL IDENTITY(1,1)
	, [GameTypeID] INT NULL
	, [MinLabel] NVARCHAR(50) NULL
	, [MaxLabel] NVARCHAR(50) NULL
	, [MinStake] DECIMAL(19,8) NULL
	, [MaxStake] DECIMAL(19,8) NULL
	, [ExchangeId] INT NULL
	, [ResourceId] VARCHAR(20) NULL
	, [GameGroupID] INT NOT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_StakeLevel] PRIMARY KEY ([StakeLevelID] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_StakeLevel_RepUpdateTime] ON [dbo].[StakeLevel] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[StakeLevel] ADD CONSTRAINT [DF_StakeLevel_GameGroupID] DEFAULT ((0)) FOR [GameGroupID]; 
GO
ALTER TABLE [dbo].[StakeLevel] ADD CONSTRAINT [DF_StakeLevel_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO


CREATE TABLE [dbo].[StakeLevel_History]
(
	  [StakeLevelID] INT NOT NULL
	, [GameTypeID] INT NULL
	, [MaxLabel] NVARCHAR(50) NULL
	, [MaxStake] DECIMAL(19,8) NULL
	, [UpdateTime] DATETIME NOT NULL
	, CONSTRAINT [PK_StakeLevel_History] PRIMARY KEY ([StakeLevelID] ASC, [UpdateTime] ASC)
)
GO



CREATE TABLE [dbo].[UMConfig]
(
	  [ProductID] TINYINT NOT NULL
	, [SportType] SMALLINT NOT NULL
	, [BetType] SMALLINT NOT NULL
	, [IsLive] BIT NOT NULL
	, [SettingType] TINYINT NOT NULL
	, [FunctionType] TINYINT NOT NULL
	, [SiteID] INT NOT NULL
	, [Currency] INT NOT NULL
	, [SuperID] INT NOT NULL
	, [BeginTime] SMALLDATETIME NULL
	, [EndTime] SMALLDATETIME NULL
	, [Time_Stamp] TIMESTAMP NULL
	, [ShowTime] SMALLDATETIME NULL
	, [LockAddingNew] BIT NULL
	, [ConfigID] INT NOT NULL IDENTITY(1,1)
	, CONSTRAINT [PK_UMConfig] PRIMARY KEY ([ProductID] ASC, [SportType] ASC, [BetType] ASC, [IsLive] ASC, [SettingType] ASC, [FunctionType] ASC, [SiteID] ASC, [Currency] ASC, [SuperID] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_UMConfig_ConfigID] ON [dbo].[UMConfig] ([ConfigID] ASC);
GO



CREATE TABLE [dbo].[Winlimit_ActionSetting]
(
	  [ActionID] TINYINT NOT NULL
	, [ActionName] VARCHAR(50) NOT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_Winlimit_ActionSetting] PRIMARY KEY ([ActionID] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_Winlimit_ActionSetting_RepUpdateTime] ON [dbo].[Winlimit_ActionSetting] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[Winlimit_ActionSetting] ADD CONSTRAINT [DF_Winlimit_ActionSetting_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO


CREATE TABLE [dbo].[Winlimit_GameGroupSetting]
(
	  [ProductID] TINYINT NOT NULL
	, [BetTypeID] SMALLINT NOT NULL
	, [GroupID] INT NOT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_Winlimit_GroupSetting] PRIMARY KEY ([ProductID] ASC, [BetTypeID] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_Winlimit_GameGroupSetting_RepUpdateTime] ON [dbo].[Winlimit_GameGroupSetting] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[Winlimit_GameGroupSetting] ADD CONSTRAINT [DF_Winlimit_GameGroupSetting_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO


CREATE TABLE [dbo].[Winlimit_Group]
(
	  [GroupID] INT NOT NULL
	, [GroupName] VARCHAR(200) NOT NULL
	, CONSTRAINT [PK_Winlimit_Group] PRIMARY KEY ([GroupID] ASC)
)
GO


CREATE TABLE [dbo].[Winlimit_LevelSetting]
(
	  [LevelID] TINYINT NOT NULL
	, [LevelName] VARCHAR(50) NOT NULL
	, [LevelOrder] TINYINT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_Winlimit_LevelSetting] PRIMARY KEY ([LevelID] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_Winlimit_LevelSetting_RepUpdateTime] ON [dbo].[Winlimit_LevelSetting] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[Winlimit_LevelSetting] ADD CONSTRAINT [DF_Winlimit_LevelSetting_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO


CREATE TABLE [dbo].[Winlimit_ProductGlobalSetting]
(
	  [ProductID] INT NOT NULL
	, [BetTypeID] SMALLINT NOT NULL
	, [GroupID] INT NOT NULL
	, [GroupName] VARCHAR(200) NULL
	, [Level1] MONEY NULL
	, [Level2] MONEY NULL
	, [Level3] MONEY NULL
	, [Level101] MONEY NULL
	, [Level102] MONEY NULL
	, [blockedTransferLvl3] BIT NULL
	, [Currency] INT NOT NULL
	, [IsDeposit] BIT NOT NULL
	, CONSTRAINT [PK_Winlimit_ProductGlobalSetting] PRIMARY KEY ([ProductID] ASC, [BetTypeID] ASC, [GroupID] ASC, [Currency] ASC, [IsDeposit] ASC)
)
GO


CREATE TABLE [dbo].[Winlimit_ProductSetting]
(
	  [ProductID] TINYINT NOT NULL
	, [BettypeID] SMALLINT NOT NULL
	, [LevelID] TINYINT NOT NULL
	, [SettingStatus] TINYINT NOT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_Winlimit_ProductSetting] PRIMARY KEY ([ProductID] ASC, [BettypeID] ASC, [LevelID] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_Winlimit_ProductSetting_RepUpdateTime] ON [dbo].[Winlimit_ProductSetting] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[Winlimit_ProductSetting] ADD CONSTRAINT [DF_Winlimit_ProductSetting_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO
ALTER TABLE [dbo].[Winlimit_ProductSetting] ADD CONSTRAINT [DF_Winlimit_ProductSetting_SettingStatus] DEFAULT ((0)) FOR [SettingStatus]; 
GO


CREATE TABLE [dbo].[WinLimit_ProductSettingDetail]
(
	  [ProductID] TINYINT NOT NULL
	, [GroupID] SMALLINT NOT NULL
	, [ExchangeID] INT NOT NULL
	, [SiteID] INT NOT NULL
	, [LevelID] TINYINT NOT NULL
	, [MaxWinLimit] MONEY NOT NULL
	, [IsBlockedPlaceBet] BIT NOT NULL
	, [IsBlockedTransfer] BIT NOT NULL
	, [MaxWinLimit_RM] MONEY NULL
	, [IsSuspendedAccount] BIT NULL
	, [RepUpdateTime] DATETIME2(7) NULL
	, CONSTRAINT [PK_WinLimit_ProductSettingDetail] PRIMARY KEY ([ProductID] ASC, [GroupID] ASC, [ExchangeID] ASC, [SiteID] ASC, [LevelID] ASC)
)
GO
CREATE NONCLUSTERED INDEX [IX_WinLimit_ProductSettingDetail_RepUpdateTime] ON [dbo].[WinLimit_ProductSettingDetail] ([RepUpdateTime] ASC);
GO

ALTER TABLE [dbo].[WinLimit_ProductSettingDetail] ADD CONSTRAINT [DF_WinLimit_ProductSettingDetail_IsSuspendedAccount] DEFAULT ((0)) FOR [IsSuspendedAccount]; 
GO
ALTER TABLE [dbo].[WinLimit_ProductSettingDetail] ADD CONSTRAINT [DF_WinLimit_ProductSettingDetail_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]; 
GO
ALTER TABLE [dbo].[WinLimit_ProductSettingDetail] ADD CONSTRAINT [DF_WinLimit_ProductSettingDetail_MaxWinLimit] DEFAULT ((0)) FOR [MaxWinLimit]; 
GO
ALTER TABLE [dbo].[WinLimit_ProductSettingDetail] ADD CONSTRAINT [DF_WinLimit_ProductSettingDetail_IsBlockedPlaceBet] DEFAULT ((0)) FOR [IsBlockedPlaceBet]; 
GO
ALTER TABLE [dbo].[WinLimit_ProductSettingDetail] ADD CONSTRAINT [DF_WinLimit_ProductSettingDetail_IsBlockedTransfer] DEFAULT ((0)) FOR [IsBlockedTransfer]; 
GO
ALTER TABLE [dbo].[WinLimit_ProductSettingDetail] ADD CONSTRAINT [DF_WinLimit_ProductSettingDetail_MaxWinLimit_RM] DEFAULT ((0)) FOR [MaxWinLimit_RM]; 
GO
