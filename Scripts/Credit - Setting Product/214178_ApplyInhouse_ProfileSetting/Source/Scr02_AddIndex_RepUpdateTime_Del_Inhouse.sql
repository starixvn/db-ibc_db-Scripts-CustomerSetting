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

/****** Object:  Index [CIX_GameLaunchPerCurrency_Del_InHouse] ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'CIX_GameLaunchPerCurrency_Del_InHouse')
BEGIN
	CREATE CLUSTERED INDEX [CIX_GameLaunchPerCurrency_Del_InHouse] ON [dbo].[GameLaunchPerCurrency_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END

/****** Object:  Index [CIX_GameLaunchPerSite_Del_InHouse] ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'CIX_GameLaunchPerSite_Del_InHouse')
BEGIN
	CREATE CLUSTERED INDEX [CIX_GameLaunchPerSite_Del_InHouse] ON [dbo].[GameLaunchPerSite_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END


/****** Object:  Index [CIX_PlayCurrencySetting_Del_InHouse] ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'CIX_PlayCurrencySetting_Del_InHouse')
BEGIN
	CREATE CLUSTERED INDEX [CIX_PlayCurrencySetting_Del_InHouse] ON [dbo].[PlayCurrencySetting_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END

/****** Object:  Index [CIX_ProductGlobalSetting_Del_InHouse] ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'CIX_ProductGlobalSetting_Del_InHouse')
BEGIN
	CREATE CLUSTERED INDEX [CIX_ProductGlobalSetting_Del_InHouse] ON [dbo].[ProductGlobalSetting_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END

/****** Object:  Index [CIX_ProductLaunchedSiteCurrency_Del_InHouse] ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'CIX_ProductLaunchedSiteCurrency_Del_InHouse')
BEGIN
	CREATE CLUSTERED INDEX [CIX_ProductLaunchedSiteCurrency_Del_InHouse] ON [dbo].[ProductLaunchedSiteCurrency_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END
/****** Object:  Index [CIX_ProductSettingSystemDisplay_Del_InHouse] ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'CIX_ProductSettingSystemDisplay_Del_InHouse')
BEGIN
	CREATE CLUSTERED INDEX [CIX_ProductSettingSystemDisplay_Del_InHouse] ON [dbo].[ProductSettingSystemDisplay_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END

/****** Object:  Index [CIX_ProductSettingUpdateRestriction_Del_InHouse] ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'CIX_ProductSettingUpdateRestriction_Del_InHouse')
BEGIN
	CREATE CLUSTERED INDEX [CIX_ProductSettingUpdateRestriction_Del_InHouse] ON [dbo].[ProductSettingUpdateRestriction_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END

/****** Object:  Index [CIX_CategoryConfig_Del_InHouse] ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'CIX_CategoryConfig_Del_InHouse')
BEGIN
	CREATE CLUSTERED INDEX [CIX_CategoryConfig_Del_InHouse] ON [dbo].[CategoryConfig_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END

/****** Object:  Index [CIX_GameGroup_Del_InHouse] ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'CIX_GameGroup_Del_InHouse')
BEGIN
	CREATE CLUSTERED INDEX [CIX_GameGroup_Del_InHouse] ON [dbo].[GameGroup_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END

/****** Object:  Index [CIX_ProductBetSetting_Del_InHouse] ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'CIX_ProductBetSetting_Del_InHouse')
BEGIN
	CREATE CLUSTERED INDEX [CIX_ProductBetSetting_Del_InHouse] ON [dbo].[ProductBetSetting_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END
/****** Object:  Index [CIX_StakeLevel_Del_InHouse] ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'CIX_StakeLevel_Del_InHouse')
BEGIN
	CREATE CLUSTERED INDEX [CIX_StakeLevel_Del_InHouse] ON [dbo].[StakeLevel_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END

/****** Object:  Index [CIX_StakeLevelGroupDetail_Del_InHouse] ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'CIX_StakeLevelGroupDetail_Del_InHouse')
BEGIN
	CREATE CLUSTERED INDEX [CIX_StakeLevelGroupDetail_Del_InHouse] ON [dbo].[StakeLevelGroupDetail_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END


/****** Object:  Index [CIX_ProductProfileSiteCurrency_Del_InHouse] ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'CIX_ProductProfileSiteCurrency_Del_InHouse')
BEGIN
	CREATE CLUSTERED INDEX [CIX_ProductProfileSiteCurrency_Del_InHouse] ON [dbo].[ProductProfileSiteCurrency_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END

/****** Object:  Index [CIX_ProductProfileSiteCurrency_UAT_Del_InHouse] ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'CIX_ProductProfileSiteCurrency_UAT_Del_InHouse')
BEGIN
	CREATE CLUSTERED INDEX [CIX_ProductProfileSiteCurrency_UAT_Del_InHouse] ON [dbo].[ProductProfileSiteCurrency_UAT_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END

/****** Object:  Index [CIX_ProductSettingProfile_Del_InHouse] ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'CIX_ProductSettingProfile_Del_InHouse')
BEGIN
	CREATE CLUSTERED INDEX [CIX_ProductSettingProfile_Del_InHouse] ON [dbo].[ProductSettingProfile_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END
/****** Object:  Index [CIX_ProductSettingProfile_UAT_Del_InHouse] ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'CIX_ProductSettingProfile_UAT_Del_InHouse')
BEGIN
	CREATE CLUSTERED INDEX [CIX_ProductSettingProfile_UAT_Del_InHouse] ON [dbo].[ProductSettingProfile_UAT_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END

/****** Object:  Index [CIX_ProductStatusProfile_Del_InHouse] ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'CIX_ProductStatusProfile_Del_InHouse')
BEGIN
	CREATE CLUSTERED INDEX [CIX_ProductStatusProfile_Del_InHouse] ON [dbo].[ProductStatusProfile_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END

/****** Object:  Index [CIX_ProductStatusSiteCurrency_Del_InHouse] ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'CIX_ProductStatusSiteCurrency_Del_InHouse')
BEGIN
	CREATE CLUSTERED INDEX [CIX_ProductStatusSiteCurrency_Del_InHouse] ON [dbo].[ProductStatusSiteCurrency_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END

/****** Object:  Index [CIX_SportNonOfferedSiteCurrency_Del_InHouse] ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'CIX_SportNonOfferedSiteCurrency_Del_InHouse')
BEGIN
	CREATE CLUSTERED INDEX [CIX_SportNonOfferedSiteCurrency_Del_InHouse] ON [dbo].[SportNonOfferedSiteCurrency_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END

/****** Object:  Index [CIX_ProductSiteConfig_Del_InHouse] ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes i WITH (NOLOCK) WHERE i.name = 'CIX_ProductSiteConfig_Del_InHouse')
BEGIN
	CREATE CLUSTERED INDEX [CIX_ProductSiteConfig_Del_InHouse] ON [dbo].[ProductSiteConfig_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
END