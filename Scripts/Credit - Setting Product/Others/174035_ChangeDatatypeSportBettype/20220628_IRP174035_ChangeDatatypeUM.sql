/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220628@Johnson
	Task: change database structure for sport/bettype on UM [#RedmineID:#174035]
	DB: DBCUST/CustDB
*/
--step 1: drop all subscriptions/articles relavant to tables ProductBetSetting
--CustWinLossLimit_Member,CustWinLossLimit_Agent,VRSettingReference,ProductStatusSiteCurrency
--ProductGlobalSetting

--step 2: alter column for tables at dbcust & replicated servers

----------------------------------------------------------------------
--ProductBetSetting
/****** Object:  Index [PK_ProductBetSetting]    Script Date: 6/28/2022 10:29:03 AM ******/
ALTER TABLE [dbo].[ProductBetSetting] DROP CONSTRAINT [PK_ProductBetSetting]
GO

ALTER TABLE ProductBetSetting ALTER COLUMN Sporttype SMALLINT NOT NULL

/****** Object:  Index [PK_ProductBetSetting]    Script Date: 6/28/2022 10:29:03 AM ******/
ALTER TABLE [dbo].[ProductBetSetting] ADD  CONSTRAINT [PK_ProductBetSetting] PRIMARY KEY CLUSTERED 
(
	[Sporttype] ASC,
	[Bettype] ASC,
	[Currency] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO

----------------------------------------------------------------------
--ProductGlobalSetting
/****** Object:  Index [PK_ProductGlobalSetting]    Script Date: 6/28/2022 3:21:34 PM ******/
ALTER TABLE [dbo].[ProductGlobalSetting] DROP CONSTRAINT [PK_ProductGlobalSetting]
GO

ALTER TABLE ProductGlobalSetting ALTER COLUMN [Sporttype] SMALLINT NOT NULL
GO

/****** Object:  Index [PK_ProductGlobalSetting]    Script Date: 6/28/2022 3:21:34 PM ******/
ALTER TABLE [dbo].[ProductGlobalSetting] ADD  CONSTRAINT [PK_ProductGlobalSetting] PRIMARY KEY CLUSTERED 
(
	[Sporttype] ASC,
	[Bettype] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO

----------------------------------------------------------------------
--ProductStatusSiteCurrency
/****** Object:  Index [PK_ProductStatusSiteCurrency]    Script Date: 6/29/2022 9:12:11 AM ******/
ALTER TABLE [dbo].[ProductStatusSiteCurrency] DROP CONSTRAINT [PK_ProductStatusSiteCurrency]
GO

ALTER TABLE [ProductStatusSiteCurrency] ALTER COLUMN [BetType] SMALLINT NOT NULL
GO

/****** Object:  Index [PK_ProductStatusSiteCurrency]    Script Date: 6/29/2022 9:12:11 AM ******/
ALTER TABLE [dbo].[ProductStatusSiteCurrency] ADD  CONSTRAINT [PK_ProductStatusSiteCurrency] PRIMARY KEY CLUSTERED 
(
	[SportType] ASC,
	[BetType] ASC,
	[Currency] ASC,
	[SiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

----------------------------------------------------------------------
--VRSettingReference
/****** Object:  Index [PK_VRSettingReference]    Script Date: 6/29/2022 11:05:35 AM ******/
ALTER TABLE [dbo].[VRSettingReference] DROP CONSTRAINT [PK_VRSettingReference]
GO

ALTER TABLE [dbo].[VRSettingReference] ALTER COLUMN [SportType] SMALLINT NOT NULL
GO

ALTER TABLE [dbo].[VRSettingReference] ALTER COLUMN [BetType] SMALLINT NOT NULL
GO

/****** Object:  Index [PK_VRSettingReference]    Script Date: 6/29/2022 11:05:35 AM ******/
ALTER TABLE [dbo].[VRSettingReference] ADD  CONSTRAINT [PK_VRSettingReference] PRIMARY KEY CLUSTERED 
(
	[SportType] ASC,
	[LeagueGroupID] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [virtualrate_table]
GO

----------------------------------------------------------------------
--CustWinLossLimit_Agent
/****** Object:  Index [PK_CustWinLossLimit_Agent]    Script Date: 6/29/2022 12:58:58 PM ******/
ALTER TABLE [dbo].[CustWinLossLimit_Agent] DROP CONSTRAINT [PK_CustWinLossLimit_Agent]
GO

ALTER TABLE [CustWinLossLimit_Agent] ALTER COLUMN BetType SMALLINT NOT NULL

/****** Object:  Index [PK_CustWinLossLimit_Agent]    Script Date: 6/29/2022 12:58:58 PM ******/
ALTER TABLE [dbo].[CustWinLossLimit_Agent] ADD  CONSTRAINT [PK_CustWinLossLimit_Agent] PRIMARY KEY CLUSTERED 
(
	[CustId] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [CustWinLossLimit_Agent_table]
GO

----------------------------------------------------------------------
--CustWinLossLimit_Member
/****** Object:  Index [PK_CustWinLossLimit_Member]    Script Date: 6/29/2022 1:07:17 PM ******/
ALTER TABLE [dbo].[CustWinLossLimit_Member] DROP CONSTRAINT [PK_CustWinLossLimit_Member]
GO

ALTER TABLE [CustWinLossLimit_Member] ALTER COLUMN [BetType] SMALLINT NOT NULL
GO

/****** Object:  Index [PK_CustWinLossLimit_Member]    Script Date: 6/29/2022 1:07:17 PM ******/
ALTER TABLE [dbo].[CustWinLossLimit_Member] ADD  CONSTRAINT [PK_CustWinLossLimit_Member] PRIMARY KEY CLUSTERED 
(
	[CustId] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [CustWinLossLimit_Member_table]
GO

--step 3: add all subscriptions/articles relavant to tables ProductBetSetting
--CustWinLossLimit_Member,CustWinLossLimit_Agent,VRSettingReference,ProductStatusSiteCurrency
--ProductGlobalSetting