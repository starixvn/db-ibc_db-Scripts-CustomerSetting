/*<info serverAlias="DBACC-bodb02 "></info>*/
/*
	Created: 20241008@Winfred
	DB: DBACC-bodb02
	Task: Apply Inhouse replication for Customer Class
	Revisions:
		- 20250121@Winfred: [NAP CM] Scale Out DBCUST - Apply Inhouse replication for Customer Class[Redmine: #214119]
*/
/***************************************************************************/
--DROP TABLE [dbo].[CustomerClassPolicyManagement]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassPolicyManagement]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CustomerClassPolicyManagement]
	(
		[PolicyID] [INT] IDENTITY(1,1) NOT NULL
		,[PolicyTitle] [VARCHAR](500) NOT NULL
		,[SportType] [SMALLINT] NOT NULL
		,[IsTest] [TINYINT] NOT NULL
		,[LastModifiedUser] [INT] NULL
		,[LastModifiedTime] [DATETIME] NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,CONSTRAINT [PK_CustomerClassPolicyManagement] PRIMARY KEY CLUSTERED ([PolicyID]) ON [DATA]
	) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassPolicyManagement exists!!!'
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassPolicyManagement]') AND name = N'CIX_CustomerClassPolicyManagement')
CREATE NONCLUSTERED INDEX [CIX_CustomerClassPolicyManagement] ON [dbo].[CustomerClassPolicyManagement]
(
	[SportType] ASC,
	[IsTest] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassPolicyManagement]') AND name = N'IX_CustomerClassPolicyManagement_RepUpdateTime')
CREATE NONCLUSTERED INDEX [IX_CustomerClassPolicyManagement_RepUpdateTime] ON [dbo].[CustomerClassPolicyManagement]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/***************************************************************************/
--DROP TABLE [dbo].[CustomerClassPolicyRule]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassPolicyRule]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CustomerClassPolicyRule]
	(
		[PolicyID] [INT] NOT NULL
		,[RuleID] [INT] NOT NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,CONSTRAINT [PK_CustomerClassPolicyRule] PRIMARY KEY CLUSTERED ([PolicyID],[RuleID]) ON [DATA]
	) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassPolicyRule exists!!!'
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassPolicyRule]') AND name = N'IX_CustomerClassPolicyRule_RepUpdateTime')
CREATE NONCLUSTERED INDEX [IX_CustomerClassPolicyRule_RepUpdateTime] ON [dbo].[CustomerClassPolicyRule]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/***************************************************************************/
--DROP TABLE [dbo].[CustomerClassRule]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassRule]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CustomerClassRule]
	(
		[RuleID] [INT] IDENTITY(1,1) NOT NULL
		,[CustomerClass] [SMALLINT] NOT NULL
		,[RuleTitle] [VARCHAR](500) NOT NULL
		,[SportType] [SMALLINT] NOT NULL
		,[IsLive] [TINYINT] NOT NULL
		,[DiffBalanceRatio] [DECIMAL](9,2) NULL
		,[BetDelay] [DECIMAL](9,2) NULL
		,[NextBetInterval] [SMALLINT] NULL
		,[SuperBetInterval] [SMALLINT] NULL
		,[SiteBetInterval] [SMALLINT] NULL
		,[MinBet] [INT] NULL
		,[MaxBet] [INT] NULL
		,[MaxPerMatch] [INT] NULL
		,[RepeatedBets] [TINYINT] NULL
		,[SeizeBetTicket] [TINYINT] NULL
		,[PeakHourSpreadAdjustment] [SMALLINT] NULL
		,[AgentBetInterval] [SMALLINT] NULL
		,[Enable] [BIT] NOT NULL
		,[IsTest] [TINYINT] NOT NULL
		,[LastModifiedUser] [INT] NULL
		,[LastModifiedTime] [DATETIME] NULL
		,[DisableParlay] [BIT] NULL
		,[CustomerClassDetail] [SMALLINT] NULL
		,[TopPriority] [BIT] NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,CONSTRAINT [PK_CustomerClassRule] PRIMARY KEY NONCLUSTERED ([RuleID]) ON [DATA]
	) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassRule exists!!!'
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CustomerClassRule_DisableParlay]') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[CustomerClassRule] ADD  CONSTRAINT [DF_CustomerClassRule_DisableParlay]  DEFAULT ((0)) FOR [DisableParlay]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CustomerClassRule_TopPriority]') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[CustomerClassRule] ADD  CONSTRAINT [DF_CustomerClassRule_TopPriority]  DEFAULT ((0)) FOR [TopPriority]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassRule]') AND name = N'CIX_CustomerClassRule')
CREATE CLUSTERED INDEX [CIX_CustomerClassRule] ON [dbo].[CustomerClassRule]
(
	[CustomerClass] ASC,
	[SportType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassRule]') AND name = N'IX_CustomerClassRule_RepUpdateTime')
CREATE NONCLUSTERED INDEX [IX_CustomerClassRule_RepUpdateTime] ON [dbo].[CustomerClassRule]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/***************************************************************************/
--DROP TABLE [dbo].[CustomerClassRuleLeagueGroup]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassRuleLeagueGroup]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CustomerClassRuleLeagueGroup]
	(
		[RuleID] [INT] NOT NULL
		,[LeagueGroupID] [SMALLINT] NOT NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,CONSTRAINT [PK_CustomerClassRuleLeagueGroup] PRIMARY KEY CLUSTERED ([RuleID],[LeagueGroupID]) ON [DATA]
	) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassRuleLeagueGroup exists!!!'
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassRuleLeagueGroup]') AND name = N'IX_CustomerClassRuleLeagueGroup_RepUpdateTime')
CREATE NONCLUSTERED INDEX [IX_CustomerClassRuleLeagueGroup_RepUpdateTime] ON [dbo].[CustomerClassRuleLeagueGroup]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/***************************************************************************/
--DROP TABLE [dbo].[CustomerClassSetting]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSetting]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CustomerClassSetting]
	(
		[custid] [INT] NOT NULL
		,[SportType] [SMALLINT] NOT NULL
		,[CustomerClass] [SMALLINT] NULL
		,[ModifiedDate] [DATETIME] NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,CONSTRAINT [PK_CustomerClassSetting] PRIMARY KEY CLUSTERED ([custid],[SportType]) ON [DATA]
	) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassSetting exists!!!'
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSetting]') AND name = N'IX_CustomerClassSetting_RepUpdateTime')
CREATE NONCLUSTERED INDEX [IX_CustomerClassSetting_RepUpdateTime] ON [dbo].[CustomerClassSetting]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/***************************************************************************/
--DROP TABLE [dbo].[CustomerClassSiteManagement]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSiteManagement]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CustomerClassSiteManagement]
	(
		[PolicyID] [INT] NOT NULL
		,[Site] [NVARCHAR](50) NOT NULL
		,[Currency] [INT] NOT NULL
		,[Platform] [TINYINT] NOT NULL
		,[LastModifiedUser] [INT] NULL
		,[LastModifiedTime] [DATETIME] NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,CONSTRAINT [PK_CustomerClassSiteManagement] PRIMARY KEY CLUSTERED ([PolicyID],[Site],[Currency],[Platform]) ON [DATA]
	) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassSetting exists!!!'
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSiteManagement]') AND name = N'IX_CustomerClassSiteManagement_RepUpdateTime')
CREATE NONCLUSTERED INDEX [IX_CustomerClassSiteManagement_RepUpdateTime] ON [dbo].[CustomerClassSiteManagement]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSiteManagement]') AND name = N'IX_CustomerClassSiteManagement_Site')
CREATE NONCLUSTERED INDEX [IX_CustomerClassSiteManagement_Site] ON [dbo].[CustomerClassSiteManagement]
(
	[Site] ASC,
	[Currency] ASC,
	[Platform] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/***************************************************************************/
--DROP TABLE [dbo].[CustomerClassSpread]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSpread]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CustomerClassSpread]
	(
		[PolicyID] [INT] IDENTITY(1,1) NOT NULL
		,[PolicyTitle] [VARCHAR](500) NOT NULL
		,[Spread] [DECIMAL](4,2) NULL
		,[Enable] [BIT] NOT NULL
		,[IsTest] [TINYINT] NOT NULL
		,[LastModifiedUser] [INT] NULL
		,[LastModifiedTime] [DATETIME] NULL
		,[IsLive] [TINYINT] NULL
		,[Type] [TINYINT] NOT NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,CONSTRAINT [PK_CustomerClassSpread] PRIMARY KEY CLUSTERED ([PolicyID]) ON [DATA]
	) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassSpread exists!!!'
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CustomerClassSpread_Type]') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[CustomerClassSpread] ADD  CONSTRAINT [DF_CustomerClassSpread_Type]  DEFAULT ((1)) FOR [Type]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSpread]') AND name = N'IX_CustomerClassSpread_RepUpdateTime')
CREATE NONCLUSTERED INDEX [IX_CustomerClassSpread_RepUpdateTime] ON [dbo].[CustomerClassSpread]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSpread]') AND name = N'IX_CustomerClassSpread_Spread')
CREATE NONCLUSTERED INDEX [IX_CustomerClassSpread_Spread] ON [dbo].[CustomerClassSpread]
(
	[Spread] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/***************************************************************************/
--DROP TABLE [dbo].[CustomerClassSpreadClass]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSpreadClass]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CustomerClassSpreadClass]
	(
		[PolicyID] [INT] NOT NULL
		,[CustomerClass] [SMALLINT] NOT NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,CONSTRAINT [PK_CustomerClassSpreadClass] PRIMARY KEY CLUSTERED ([PolicyID],[CustomerClass]) ON [DATA]
	) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassSpreadClass exists!!!'
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSpreadClass]') AND name = N'IX_CustomerClassSpreadClass')
CREATE NONCLUSTERED INDEX [IX_CustomerClassSpreadClass] ON [dbo].[CustomerClassSpreadClass]
(
	[CustomerClass] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSpreadClass]') AND name = N'IX_CustomerClassSpreadClass_RepUpdateTime')
CREATE NONCLUSTERED INDEX [IX_CustomerClassSpreadClass_RepUpdateTime] ON [dbo].[CustomerClassSpreadClass]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/***************************************************************************/
--DROP TABLE [dbo].[CustomerClassSpreadDetail]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSpreadDetail]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CustomerClassSpreadDetail]
	(
		[PolicyID] [INT] NOT NULL
		,[SiteID] [INT] NOT NULL
		,[Currency] [INT] NOT NULL
		,[Platform] [TINYINT] NOT NULL
		,[SportType] [SMALLINT] NOT NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,CONSTRAINT [PK_CustomerClassSpreadDetail] PRIMARY KEY CLUSTERED ([PolicyID],[SiteID],[Currency],[Platform],[SportType]) ON [DATA]
	) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassSpreadDetail exists!!!'
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSpreadDetail]') AND name = N'IX_CustomerClassSpreadDetail_RepUpdateTime')
CREATE NONCLUSTERED INDEX [IX_CustomerClassSpreadDetail_RepUpdateTime] ON [dbo].[CustomerClassSpreadDetail]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSpreadDetail]') AND name = N'NIX_CustomerClassSpreadDetail')
CREATE NONCLUSTERED INDEX [NIX_CustomerClassSpreadDetail] ON [dbo].[CustomerClassSpreadDetail]
(
	[SiteID] ASC,
	[Currency] ASC,
	[Platform] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
