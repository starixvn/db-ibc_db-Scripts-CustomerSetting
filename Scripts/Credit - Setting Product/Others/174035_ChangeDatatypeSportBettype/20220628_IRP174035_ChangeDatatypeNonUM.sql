/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220628@Johnson
	Task: change database structure for sport/bettype [#RedmineID:#174035]
	DB: DBCUST/CustDB
*/

-----------------------------------------------------------------------------------------------
--VRBettypeGroup: run at dbcust
ALTER TABLE [dbo].[VRBettypeGroup] ALTER COLUMN SportType SMALLINT NULL
GO

-----------------------------------------------------------------------------------------------
--VRLeagueGroup: run at dbcust
ALTER TABLE [dbo].[VRLeagueGroup] ALTER COLUMN SportType SMALLINT NULL
GO

-----------------------------------------------------------------------------------------------
--VRSetting_AutoUpdate_ByExcel: run at dbcust only
ALTER TABLE VRSetting_AutoUpdate_ByExcel ALTER COLUMN [SportType] SMALLINT NOT NULL
GO

-----------------------------------------------------------------------------------------------
--VRSettingAutoUpdate: run at dbcust 

/****** Object:  Index [PK_VRSettingAutoUpdate]    Script Date: 6/28/2022 9:49:06 AM ******/
ALTER TABLE [dbo].[VRSettingAutoUpdate] DROP CONSTRAINT [PK_VRSettingAutoUpdate]
GO

ALTER TABLE VRSettingAutoUpdate ALTER COLUMN [SportType] SMALLINT NOT NULL
GO

ALTER TABLE VRSettingAutoUpdate ALTER COLUMN [BetType] SMALLINT NOT NULL
GO

/****** Object:  Index [PK_VRSettingAutoUpdate]    Script Date: 6/28/2022 9:49:06 AM ******/
ALTER TABLE [dbo].[VRSettingAutoUpdate] ADD  CONSTRAINT [PK_VRSettingAutoUpdate] PRIMARY KEY CLUSTERED 
(
	[CustId] ASC,
	[SportType] ASC,
	[IsLive] ASC,
	[VRLeagueGroupId] ASC,
	[VRBettypeGroupId] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [virtualrate_table]
GO

-----------------------------------------------------------------------------------------------
--Winlimit_ProductGlobalSetting: run at dbcust only

/****** Object:  Index [PK_Winlimit_ProductGlobalSetting]    Script Date: 6/28/2022 9:02:11 AM ******/
ALTER TABLE [dbo].[Winlimit_ProductGlobalSetting] DROP CONSTRAINT [PK_Winlimit_ProductGlobalSetting]
GO

ALTER TABLE Winlimit_ProductGlobalSetting ALTER COLUMN [BetTypeID] SMALLINT NOT NULL
GO

/****** Object:  Index [PK_Winlimit_ProductGlobalSetting]    Script Date: 6/28/2022 9:01:59 AM ******/
ALTER TABLE [dbo].[Winlimit_ProductGlobalSetting] ADD  CONSTRAINT [PK_Winlimit_ProductGlobalSetting] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[BetTypeID] ASC,
	[GroupID] ASC,
	[Currency] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [WinlimitSetting_Tables]
GO


-----------------------------------------------------------------------------------------------
--VRSettingHierarchy: run at dbcust & rep server

/****** Object:  Index [IX_SportLeague]    Script Date: 6/29/2022 10:36:51 AM ******/
DROP INDEX [IX_SportLeague] ON [dbo].[VRSettingHierarchy]
GO

ALTER TABLE [dbo].[VRSettingHierarchy] ALTER COLUMN SportType SMALLINT NULL
GO

ALTER TABLE [dbo].[VRSettingHierarchy] ALTER COLUMN BetType SMALLINT NULL

/****** Object:  Index [IX_SportLeague]    Script Date: 6/29/2022 10:36:51 AM ******/
CREATE NONCLUSTERED INDEX [IX_SportLeague] ON [dbo].[VRSettingHierarchy]
(
	[SportType] ASC,
	[BetType] ASC,
	[VRLeagueGroupID] ASC
)
INCLUDE ( 	[ParentLevelID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [virtualrate_table]
GO