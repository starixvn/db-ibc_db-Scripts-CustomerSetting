/*<info serverAlias="DBGLOB-GlobCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250116@Tacy	
	Task: Scale Out DBCUST - Setup InHouse replication on GlobCustdb
	DB: DBGLOB-GlobCustDB
	
	Revisions:
		- 20250116@Tacy: Created [RedmineID: #216870]
*/
/*
	Dep_ProductSetting_Del_InHouse
	Dep_ProductSettingDetail_Del_InHouse
	Dep_ProductStatusProfile_Del_InHouse
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Dep_ProductSetting_Del_InHouse
CREATE TABLE [dbo].[Dep_ProductSetting_Del_InHouse](
	[ProductSettingID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[Dep_ProductSetting_Del_InHouse] ADD  CONSTRAINT [DF_Dep_ProductSetting_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_Dep_ProductSetting_Del_InHouse_RepUpdateTime] ON [dbo].[Dep_ProductSetting_Del_InHouse]
(
	[RepUpdateTime] ASC
)
GO

-------------------------------------------------------------------
-- Dep_ProductSettingDetail_Del_InHouse
CREATE TABLE [dbo].[Dep_ProductSettingDetail_Del_InHouse](
	[ProductSettingID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[Dep_ProductSettingDetail_Del_InHouse] ADD  CONSTRAINT [DF_Dep_ProductSettingDetail_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_Dep_ProductSettingDetail_Del_InHouse_RepUpdateTime] ON [dbo].[Dep_ProductSettingDetail_Del_InHouse]
(
	[RepUpdateTime] ASC
)
GO

-------------------------------------------------------------------
-- Dep_ProductStatusProfile_Del_InHouse
CREATE TABLE [dbo].[Dep_ProductStatusProfile_Del_InHouse](
	[Sporttype] [smallint] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[Dep_ProductStatusProfile_Del_InHouse] ADD  CONSTRAINT [DF_Dep_ProductStatusProfile_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_Dep_ProductStatusProfile_Del_InHouse_RepUpdateTime] ON [dbo].[Dep_ProductStatusProfile_Del_InHouse]
(
	[RepUpdateTime] ASC
)
GO