/*<info serverAlias="DBGLOB-GlobCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250116@Tacy	
	Task: Scale Out DBCUST - Setup InHouse replication on GlobCustdb
	DB: DBGLOB-GlobCustDB
	
	Revisions:
		- 20250116@Tacy: Created [RedmineID: #216870]
*/
/*
	GameLaunchPerCurrency_Del_InHouse
	GameLaunchPerSite_Del_InHouse
	GameRoundBetLimitSettings_Del_InHouse
	LossLimit_GlobalSetting_Del_InHouse
	MaxPayoutGlobalSetting_Del_InHouse
	PlayCurrencySetting_Del_InHouse
	SiteDBConfig_Del_InHouse
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/****** Object:  Table [dbo].[GameLaunchPerCurrency_Del_InHouse] ******/
CREATE TABLE [dbo].[GameLaunchPerCurrency_Del_InHouse](
	[SportType] [smallint] NOT NULL,
	[BetType] [int] NOT NULL,
	[Currency] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[GameLaunchPerCurrency_Del_InHouse] ADD  CONSTRAINT [DF_GameLaunchPerCurrency_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_GameLaunchPerCurrency_Del_InHouse] ON [dbo].[GameLaunchPerCurrency_Del_InHouse]
(
	[RepUpdateTime] ASC
)
GO

--------------------------------------------------------------------
/****** Object:  Table [dbo].[GameLaunchPerSite_Del_InHouse] ******/
CREATE TABLE [dbo].[GameLaunchPerSite_Del_InHouse](
	[SportType] [smallint] NOT NULL,
	[BetType] [int] NOT NULL,
	[SiteID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[GameLaunchPerSite_Del_InHouse] ADD  CONSTRAINT [DF_GameLaunchPerSite_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_GameLaunchPerSite_Del_InHouse] ON [dbo].[GameLaunchPerSite_Del_InHouse]
(
	[RepUpdateTime] ASC
)
GO

----------------------------------------------------------------------------
/****** Object:  Table [dbo].[GameRoundBetLimitSettings_Del_InHouse] ******/
CREATE TABLE [dbo].[GameRoundBetLimitSettings_Del_InHouse](
	[SportType] [smallint] NOT NULL,
	[BetType] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[GameRoundBetLimitSettings_Del_InHouse] ADD  CONSTRAINT [DF_GameRoundBetLimitSettings_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_GameRoundBetLimitSettings_Del_InHouse_RepUpdateTime] ON [dbo].[GameRoundBetLimitSettings_Del_InHouse]
(
	[RepUpdateTime] ASC
)
GO

--------------------------------------------------------------------------
/****** Object:  Table [dbo].[LossLimit_GlobalSetting_Del_InHouse] ******/
CREATE TABLE [dbo].[LossLimit_GlobalSetting_Del_InHouse](
	[ProductId] [tinyint] NOT NULL,
	[ExchangeId] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[LossLimit_GlobalSetting_Del_InHouse] ADD  CONSTRAINT [DF_LossLimit_GlobalSetting_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_LossLimit_GlobalSetting_Del_InHouse_RepUpdateTime] ON [dbo].[LossLimit_GlobalSetting_Del_InHouse]
(
	[RepUpdateTime] ASC
)
GO

-------------------------------------------------------------------------
/****** Object:  Table [dbo].[MaxPayoutGlobalSetting_Del_InHouse] ******/
CREATE TABLE [dbo].[MaxPayoutGlobalSetting_Del_InHouse](
	[SportType] [int] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[Currency] [tinyint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[MaxPayoutGlobalSetting_Del_InHouse] ADD  CONSTRAINT [DF_MaxPayoutGlobalSetting_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_MaxPayoutGlobalSetting_Del_InHouse_RepUpdateTime] ON [dbo].[MaxPayoutGlobalSetting_Del_InHouse]
(
	[RepUpdateTime] ASC
)
GO

----------------------------------------------------------------------
/****** Object:  Table [dbo].[PlayCurrencySetting_Del_InHouse] ******/
CREATE TABLE [dbo].[PlayCurrencySetting_Del_InHouse](
	[ID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[PlayCurrencySetting_Del_InHouse] ADD  CONSTRAINT [DF_PlayCurrencySetting_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_PlayCurrencySetting_Del_InHouse] ON [dbo].[PlayCurrencySetting_Del_InHouse]
(
	[RepUpdateTime] ASC
)
GO


---------------------------------------------------------------
/****** Object:  Table [dbo].[SiteDBConfig_Del_InHouse] ******/
CREATE TABLE [dbo].[SiteDBConfig_Del_InHouse](
	[SiteDBGroupID] [smallint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[SiteDBConfig_Del_InHouse] ADD  CONSTRAINT [DF_SiteDBConfig_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_SiteDBConfig_Del_InHouse_RepUpdateTime] ON [dbo].[SiteDBConfig_Del_InHouse]
(
	[RepUpdateTime] ASC
)
GO