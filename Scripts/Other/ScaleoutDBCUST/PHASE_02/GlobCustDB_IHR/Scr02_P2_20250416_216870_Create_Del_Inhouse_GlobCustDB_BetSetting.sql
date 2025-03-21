/*<info serverAlias="DBGLOB-GlobCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250116@Tacy	
	Task: Scale Out DBCUST - Setup InHouse replication on GlobCustdb
	DB: DBGLOB-GlobCustDB
	
	Revisions:
		- 20250116@Tacy: Created [RedmineID: #216870]
*/
/*
	Dep_ProductBetSetting_Del_InHouse
	Dep_StakeLevel_Del_InHouse
	Dep_StakeLevelGroupDetail_Del_InHouse
	
	GameGroup_Del_InHouse

	ProductBetSetting_Del_InHouse
	StakeLevel_Del_InHouse
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/****** Object:  Table [dbo].[Dep_ProductBetSetting_Del_InHouse] ******/
CREATE TABLE [dbo].[Dep_ProductBetSetting_Del_InHouse](
	[Sporttype] [int] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[Currency] [tinyint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[Dep_ProductBetSetting_Del_InHouse] ADD  CONSTRAINT [DF_Dep_ProductBetSetting_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_Dep_ProductBetSetting_Del_InHouse_RepUpdateTime] ON [dbo].[Dep_ProductBetSetting_Del_InHouse]
(
	[RepUpdateTime] ASC
)
GO

-----------------------------------------------------------------
/****** Object:  Table [dbo].[Dep_StakeLevel_Del_InHouse] ******/

CREATE TABLE [dbo].[Dep_StakeLevel_Del_InHouse](
	[StakeLevelID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL
) ON [DATA]
GO

CREATE CLUSTERED INDEX [CIX_Dep_StakeLevel_Del_InHouse_RepUpdateTime] ON [dbo].[Dep_StakeLevel_Del_InHouse]
(
	[RepUpdateTime] ASC
)
GO

----------------------------------------------------------------------------
/****** Object:  Table [dbo].[Dep_StakeLevelGroupDetail_Del_InHouse] ******/
CREATE TABLE [dbo].[Dep_StakeLevelGroupDetail_Del_InHouse](
	[StakeLevelID] [int] NOT NULL,
	[GameTypeID] [smallint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[Dep_StakeLevelGroupDetail_Del_InHouse] ADD  CONSTRAINT [DF_Dep_StakeLevelGroupDetail_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_Dep_StakeLevelGroupDetail_Del_InHouse_RepUpdateTime] ON [dbo].[Dep_StakeLevelGroupDetail_Del_InHouse]
(
	[RepUpdateTime] ASC
)
GO

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/****** Object:  Table [dbo].[GameGroup_Del_InHouse] ******/
CREATE TABLE [dbo].[GameGroup_Del_InHouse](
	[GameGroupID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[GameGroup_Del_InHouse] ADD  CONSTRAINT [DF_GameGroup_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_GameGroup_Del_InHouse] ON [dbo].[GameGroup_Del_InHouse]
(
	[RepUpdateTime] ASC
)
GO

--------------------------------------------------------------------
/****** Object:  Table [dbo].[ProductBetSetting_Del_InHouse] ******/
CREATE TABLE [dbo].[ProductBetSetting_Del_InHouse](
	[Sporttype] [smallint] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[Currency] [tinyint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[ProductBetSetting_Del_InHouse] ADD  CONSTRAINT [DF_ProductBetSetting_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_ProductBetSetting_Del_InHouse] ON [dbo].[ProductBetSetting_Del_InHouse]
(
	[RepUpdateTime] ASC
)
GO

-------------------------------------------------------------
/****** Object:  Table [dbo].[StakeLevel_Del_InHouse] ******/
CREATE TABLE [dbo].[StakeLevel_Del_InHouse](
	[StakeLevelID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[StakeLevel_Del_InHouse] ADD  CONSTRAINT [DF_StakeLevel_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_StakeLevel_Del_InHouse] ON [dbo].[StakeLevel_Del_InHouse]
(
	[RepUpdateTime] ASC
)
GO