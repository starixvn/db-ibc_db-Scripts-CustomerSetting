/*<info serverAlias="DBGLOB-GlobCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250212@Johnson	
	Task: Move tables to GlobCustDB
	DB: DBGLOB/GlobCustDB
	
	Revisions:
		- 20250212@Johnson: move tables Del_Inhouse to GlobCustDB [RedmineID: #216870]
*/		

/***************************************************************************/
CREATE TABLE [dbo].[ProductGlobalSetting_Del_InHouse](
	[Sporttype] [SMALLINT] NOT NULL
	,[Bettype] [SMALLINT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[ProductGlobalSetting_Del_InHouse] ADD  CONSTRAINT [DF_ProductGlobalSetting_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_ProductGlobalSetting_Del_InHouse] ON [dbo].[ProductGlobalSetting_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
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

CREATE CLUSTERED INDEX [CIX_ProductLaunchedSiteCurrency_Del_InHouse] ON [dbo].[ProductLaunchedSiteCurrency_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
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

CREATE CLUSTERED INDEX [CIX_ProductProfileSiteCurrency_Del_InHouse] ON [dbo].[ProductProfileSiteCurrency_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
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

CREATE CLUSTERED INDEX [CIX_ProductProfileSiteCurrency_UAT_Del_InHouse] ON [dbo].[ProductProfileSiteCurrency_UAT_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/***************************************************************************/
CREATE TABLE [dbo].[ProductSettingProfile_Del_InHouse](
	[ProductSettingID] [INT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[ProductSettingProfile_Del_InHouse] ADD  CONSTRAINT [DF_ProductSettingProfile_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_ProductSettingProfile_Del_InHouse] ON [dbo].[ProductSettingProfile_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO

/***************************************************************************/
CREATE TABLE [dbo].[ProductSettingProfile_UAT_Del_InHouse](
	[ProductSettingID] [INT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
) ON [DATA]
GO

ALTER TABLE [dbo].[ProductSettingProfile_UAT_Del_InHouse] ADD  CONSTRAINT [DF_ProductSettingProfile_UAT_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_ProductSettingProfile_UAT_Del_InHouse] ON [dbo].[ProductSettingProfile_UAT_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
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

CREATE CLUSTERED INDEX [CIX_ProductSettingSystemDisplay_Del_InHouse] ON [dbo].[ProductSettingSystemDisplay_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
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

CREATE CLUSTERED INDEX [CIX_ProductSettingUpdateRestriction_Del_InHouse] ON [dbo].[ProductSettingUpdateRestriction_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
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

CREATE CLUSTERED INDEX [CIX_ProductStatusProfile_Del_InHouse] ON [dbo].[ProductStatusProfile_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
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

CREATE CLUSTERED INDEX [CIX_ProductStatusSiteCurrency_Del_InHouse] ON [dbo].[ProductStatusSiteCurrency_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
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

CREATE CLUSTERED INDEX [CIX_SportNonOfferedSiteCurrency_Del_InHouse] ON [dbo].[SportNonOfferedSiteCurrency_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/***************************************************************************/

CREATE TABLE [dbo].[Acc_SuperPrefix_Del_InHouse](
	[GroupName] [varchar](50) NOT NULL,
	[Prefix] [varchar](10) NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL
) ON [DATA]

GO

ALTER TABLE [dbo].[Acc_SuperPrefix_Del_InHouse] ADD  CONSTRAINT [DF_Acc_SuperPrefix_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_Acc_SuperPrefix_Del_InHouse] ON [dbo].[Acc_SuperPrefix_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/***************************************************************************/
CREATE TABLE [dbo].[CategoryConfig_Del_InHouse](
	[CategoryID] [SMALLINT] NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL	
) ON [DATA]
GO

ALTER TABLE [dbo].[CategoryConfig_Del_InHouse] ADD  CONSTRAINT [DF_CategoryConfig_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_CategoryConfig_Del_InHouse] ON [dbo].[CategoryConfig_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO

/***************************************************************************/
CREATE TABLE [dbo].[Winlimit_ActionSetting_Del_InHouse]
	(
		ActionID [TINYINT]  NOT NULL
		,[RepUpdateTime] [DATETIME2](7) NOT NULL
	) ON [DATA]
GO
ALTER TABLE [dbo].[Winlimit_ActionSetting_Del_InHouse] ADD CONSTRAINT [DF_Winlimit_ActionSetting_Del_InHouse_RepUpdateTime] DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
CREATE CLUSTERED INDEX [CIX_Winlimit_ActionSetting_Del_InHouse_RepUpdateTime] ON [dbo].[Winlimit_ActionSetting_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
GO

/***************************************************************************/
CREATE TABLE [dbo].[Winlimit_GameGroupSetting_Del_InHouse]
	(
		ProductID [TINYINT]  NOT NULL,
		BetTypeID [SMALLINT]  NOT NULL,
		[RepUpdateTime] [DATETIME2](7) NOT NULL
	) ON [DATA]
GO

ALTER TABLE [dbo].[Winlimit_GameGroupSetting_Del_InHouse] ADD CONSTRAINT [DF_Winlimit_GameGroupSetting_Del_InHouse_RepUpdateTime] DEFAULT (sysdatetime())  FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_Winlimit_GameGroupSetting_Del_InHouse_RepUpdateTime] ON [dbo].[Winlimit_GameGroupSetting_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
GO

/***************************************************************************/
CREATE TABLE [dbo].[Winlimit_LevelSetting_Del_InHouse]
	(
		LevelID [TINYINT]  NOT NULL,
		[RepUpdateTime] [DATETIME2](7) NOT NULL
	) ON [DATA]
GO

ALTER TABLE [dbo].[Winlimit_LevelSetting_Del_InHouse] ADD CONSTRAINT [DF_Winlimit_LevelSetting_Del_InHouse_RepUpdateTime] DEFAULT (sysdatetime())  FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_Winlimit_LevelSetting_Del_InHouse_RepUpdateTime] ON [dbo].[Winlimit_LevelSetting_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
GO

/***************************************************************************/
CREATE TABLE [dbo].[Winlimit_ProductSetting_Del_InHouse]
	(
		ProductID [TINYINT]  NOT NULL,
		BettypeID [SMALLINT]  NOT NULL,
		LevelID [TINYINT]  NOT NULL,
		[RepUpdateTime] [DATETIME2](7) NOT NULL
	) ON [DATA]
GO

ALTER TABLE [dbo].[Winlimit_ProductSetting_Del_InHouse] ADD CONSTRAINT [DF_Winlimit_ProductSetting_Del_InHouse_RepUpdateTime] DEFAULT (sysdatetime())  FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_Winlimit_ProductSetting_Del_InHouse_RepUpdateTime] ON [dbo].[Winlimit_ProductSetting_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
GO

/***************************************************************************/
CREATE TABLE [dbo].[WinLimit_ProductSettingDetail_Del_InHouse]
	(
		ProductID [TINYINT]  NOT NULL,
		GroupID [SMALLINT]  NOT NULL,
		ExchangeID [INT]  NOT NULL,
		SiteID [INT]  NOT NULL,
		LevelID [TINYINT]  NOT NULL,
		[RepUpdateTime] [DATETIME2](7) NOT NULL
	) ON [DATA]
GO

ALTER TABLE [dbo].[WinLimit_ProductSettingDetail_Del_InHouse] ADD CONSTRAINT [DF_WinLimit_ProductSettingDetail_Del_InHouse_RepUpdateTime] DEFAULT (sysdatetime())  FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_WinLimit_ProductSettingDetail_Del_InHouse_RepUpdateTime] ON [dbo].[WinLimit_ProductSettingDetail_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
GO

/***************************************************************************/
CREATE TABLE [dbo].[MsgError_Del_InHouse](
	[MsgID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL
) ON [DATA]

GO

ALTER TABLE [dbo].[MsgError_Del_InHouse] ADD  CONSTRAINT [DF_MsgError_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_MsgError_Del_InHouse_RepUpdateTime] ON [dbo].[MsgError_Del_InHouse]
(
	[RepUpdateTime] ASC
)ON [DATA]
GO

/***************************************************************************/
CREATE TABLE [dbo].[Winlimit_ProductGlobalSetting_Del_InHouse]
	(
		[ProductID] [INT] NOT NULL
		,[BetTypeID] [SMALLINT] NOT NULL
		,[GroupID] [INT] NOT NULL
		,[Currency] [INT] NOT NULL
		,[IsDeposit] [BIT] NOT NULL
		,[RepUpdateTime] DATETIME2(7) NULL
	) ON [DATA]
GO

ALTER TABLE [dbo].[Winlimit_ProductGlobalSetting_Del_InHouse] ADD CONSTRAINT [DF_Winlimit_ProductGlobalSetting_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_Winlimit_ProductGlobalSetting_Del_InHouse_RepUpdateTime] ON [dbo].[Winlimit_ProductGlobalSetting_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
GO
/***************************************************************************/
CREATE TABLE [dbo].[Winlimit_Group_Del_InHouse]
	(
		[GroupID] [INT] NOT NULL,
		[RepUpdateTime] DATETIME2(7) NULL
	) ON [DATA]
GO
ALTER TABLE [dbo].[Winlimit_Group_Del_InHouse] ADD CONSTRAINT [DF_Winlimit_Group_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
GO
CREATE CLUSTERED INDEX [CIX_Winlimit_Group_Del_InHouse_RepUpdateTime] ON [dbo].[Winlimit_Group_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
GO
/***************************************************************************/
CREATE TABLE [dbo].[MsgErrorGroup_Del_InHouse](
	[MsgGroupID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL
) ON [DATA]

GO

ALTER TABLE [dbo].[MsgErrorGroup_Del_InHouse] ADD  CONSTRAINT [DF_MsgErrorGroup_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_MsgErrorGroup_Del_InHouse_RepUpdateTime] ON [dbo].[MsgErrorGroup_Del_InHouse]
(
	[RepUpdateTime] ASC
)ON [DATA]
GO
/***************************************************************************/
CREATE TABLE [dbo].[ProblemAccountReason_Del_InHouse](
	[ReasonID] [tinyint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL
) ON [DATA]

GO

ALTER TABLE [dbo].[ProblemAccountReason_Del_InHouse] ADD  CONSTRAINT [DF_ProblemAccountReason_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_ProblemAccountReason_Del_InHouse] ON [dbo].[ProblemAccountReason_Del_InHouse]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO

/***************************************************************************/
--Add column RepUpdateTime for Winlimit_ProductGlobalSetting/Winlimit_Group to setup inhouse
ALTER TABLE [dbo].[Winlimit_ProductGlobalSetting] ADD [RepUpdateTime] [datetime2](7) CONSTRAINT [DF_Winlimit_ProductGlobalSetting_RepUpdateTime] DEFAULT (SYSDATETIME()) 
GO

ALTER TABLE [dbo].[Winlimit_Group] ADD [RepUpdateTime] [datetime2](7) CONSTRAINT [DF_Winlimit_Group_RepUpdateTime] DEFAULT (SYSDATETIME()) 
GO