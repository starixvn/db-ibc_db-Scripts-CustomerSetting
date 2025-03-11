/*<info serverAlias="DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241227@Virgil	
	Task: Customer Setting - Apply In-house replication for profile setting tables
	DB: DBCUST-CustDB
	
	Revisions:
		- 20241225@Virgil: Created [RedmineID: #214117]

	Table Related:
		GameLaunchPerCurrency
		GameLaunchPerSite
		PlayCurrencySetting
		ProductGlobalSetting
		ProductLaunchedSiteCurrency
		ProductSettingSystemDisplay
		ProductSettingUpdateRestriction
		CategoryConfig
		GameGroup
		ProductBetSetting
		StakeLevel
		StakeLevelGroupDetail
		ProductProfileSiteCurrency
		ProductProfileSiteCurrency_UAT
		ProductSettingProfile
		ProductSettingProfile_UAT
		ProductStatusProfile
		ProductStatusSiteCurrency
		SportNonOfferedSiteCurrency
		ProductSiteConfig	
*/
USE CustDB
GO

CREATE TABLE [dbo].[GameLaunchPerCurrency_Del_InHouse](
	[SportType] [SMALLINT] NOT NULL
	,[BetType] [INT] NOT NULL
	,[Currency] [INT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[GameLaunchPerCurrency_Del_InHouse] ADD  CONSTRAINT [DF_GameLaunchPerCurrency_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

/***************************************************************************/
CREATE TABLE [dbo].[GameLaunchPerSite_Del_InHouse](
	[SportType] [SMALLINT] NOT NULL
	,[BetType] [INT] NOT NULL
	,[SiteID] [INT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[GameLaunchPerSite_Del_InHouse] ADD  CONSTRAINT [DF_GameLaunchPerSite_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

/***************************************************************************/
CREATE TABLE [dbo].[PlayCurrencySetting_Del_InHouse](
	[ID] [INT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[PlayCurrencySetting_Del_InHouse] ADD  CONSTRAINT [DF_PlayCurrencySetting_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

/***************************************************************************/
CREATE TABLE [dbo].[ProductGlobalSetting_Del_InHouse](
	[Sporttype] [SMALLINT] NOT NULL
	,[Bettype] [SMALLINT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[ProductGlobalSetting_Del_InHouse] ADD  CONSTRAINT [DF_ProductGlobalSetting_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

/***************************************************************************/
CREATE TABLE [dbo].[ProductLaunchedSiteCurrency_Del_InHouse](
	[SiteID] [INT] NOT NULL
	,[Currency] [INT] NOT NULL
	,[SportType] [SMALLINT] NOT NULL
	,[BetType] [SMALLINT] NOT NULL
	,[LaunchedLevel] [TINYINT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[ProductLaunchedSiteCurrency_Del_InHouse] ADD  CONSTRAINT [DF_ProductLaunchedSiteCurrency_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

/***************************************************************************/
CREATE TABLE [dbo].[ProductSettingSystemDisplay_Del_InHouse](
	[SystemID] [TINYINT] NOT NULL
	,[ProductID] [TINYINT] NOT NULL
	,[SettingType] [SMALLINT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[ProductSettingSystemDisplay_Del_InHouse] ADD  CONSTRAINT [DF_ProductSettingSystemDisplay_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

/***************************************************************************/
CREATE TABLE [dbo].[ProductSettingUpdateRestriction_Del_InHouse](
	[SystemID] [TINYINT] NOT NULL
	,[ProductID] [TINYINT] NOT NULL
	,[SettingType] [SMALLINT] NOT NULL
	,[ActorRoleID] [TINYINT] NOT NULL
	,[TargetRoleID] [TINYINT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[ProductSettingUpdateRestriction_Del_InHouse] ADD  CONSTRAINT [DF_ProductSettingUpdateRestriction_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

/***************************************************************************/
CREATE TABLE [dbo].[CategoryConfig_Del_InHouse](
	[CategoryID] [SMALLINT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL	
) ON [DATA]
GO

ALTER TABLE [dbo].[CategoryConfig_Del_InHouse] ADD  CONSTRAINT [DF_CategoryConfig_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

/***************************************************************************/
CREATE TABLE [dbo].[GameGroup_Del_InHouse](
	[GameGroupID] [INT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[GameGroup_Del_InHouse] ADD  CONSTRAINT [DF_GameGroup_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

/***************************************************************************/
CREATE TABLE [dbo].[ProductBetSetting_Del_InHouse](
	[Sporttype] [SMALLINT] NOT NULL
	,[Bettype] [SMALLINT] NOT NULL
	,[Currency] [TINYINT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[ProductBetSetting_Del_InHouse] ADD  CONSTRAINT [DF_ProductBetSetting_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

/***************************************************************************/
CREATE TABLE [dbo].[StakeLevel_Del_InHouse](
	[StakeLevelID] [INT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[StakeLevel_Del_InHouse] ADD  CONSTRAINT [DF_StakeLevel_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

/***************************************************************************/
CREATE TABLE [dbo].[StakeLevelGroupDetail_Del_InHouse](
	[StakeLevelID] [INT] NOT NULL
	,[GameTypeID] [INT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[StakeLevelGroupDetail_Del_InHouse] ADD  CONSTRAINT [DF_StakeLevelGroupDetail_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

/***************************************************************************/
CREATE TABLE [dbo].[ProductProfileSiteCurrency_Del_InHouse](
	[SiteID] [INT] NOT NULL
	,[Currency] [INT] NOT NULL
	,[ProductSettingID] [INT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[ProductProfileSiteCurrency_Del_InHouse] ADD  CONSTRAINT [DF_ProductProfileSiteCurrency_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

/***************************************************************************/
CREATE TABLE [dbo].[ProductProfileSiteCurrency_UAT_Del_InHouse](
	[SiteID] [INT] NOT NULL
	,[Currency] [INT] NOT NULL
	,[ProductSettingID] [INT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[ProductProfileSiteCurrency_UAT_Del_InHouse] ADD  CONSTRAINT [DF_ProductProfileSiteCurrency_UAT_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

/***************************************************************************/
CREATE TABLE [dbo].[ProductSettingProfile_Del_InHouse](
	[ProductSettingID] [INT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[ProductSettingProfile_Del_InHouse] ADD  CONSTRAINT [DF_ProductSettingProfile_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

/***************************************************************************/
CREATE TABLE [dbo].[ProductSettingProfile_UAT_Del_InHouse](
	[ProductSettingID] [INT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[ProductSettingProfile_UAT_Del_InHouse] ADD  CONSTRAINT [DF_ProductSettingProfile_UAT_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

/***************************************************************************/
CREATE TABLE [dbo].[ProductStatusProfile_Del_InHouse](
	[Sporttype] [SMALLINT] NOT NULL
	,[Bettype] [SMALLINT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[ProductStatusProfile_Del_InHouse] ADD  CONSTRAINT [DF_ProductStatusProfile_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

/***************************************************************************/
CREATE TABLE [dbo].[ProductStatusSiteCurrency_Del_InHouse](
	[SportType] [SMALLINT] NOT NULL
	,[BetType] [SMALLINT] NOT NULL
	,[Currency] [INT] NOT NULL
	,[SiteID] [INT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[ProductStatusSiteCurrency_Del_InHouse] ADD  CONSTRAINT [DF_ProductStatusSiteCurrency_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

/***************************************************************************/
CREATE TABLE [dbo].[SportNonOfferedSiteCurrency_Del_InHouse](
	[SportType] [SMALLINT] NOT NULL
	,[BetType] [INT] NOT NULL
	,[Currency] [INT] NOT NULL
	,[SiteID] [INT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[SportNonOfferedSiteCurrency_Del_InHouse] ADD  CONSTRAINT [DF_SportNonOfferedSiteCurrency_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

/***************************************************************************/
 CREATE TABLE [dbo].[ProductSiteConfig_Del_InHouse](
 	[SiteID] [INT] NOT NULL
 	,[ProductID] [TINYINT] NOT NULL
 	,[RepUpdateTime] [DATETIME2](7) NOT NULL
 ) ON [DATA]
 GO
 
ALTER TABLE [dbo].[ProductSiteConfig_Del_InHouse] ADD  CONSTRAINT [DF_ProductSiteConfig_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
 /***************************************************************************/

