/*<info serverAlias="DBCustRepl-ReplCustDB"></info>*/
/*
	Created: 20240913@Johnson
	Task: Database structure change on DBCustRepl for Bet Limit Control [redmine: #209892]
	DB: DBCustRepl-ReplCustDB
*/ 
-----------------------------------------------
--BetLimitControlCustSetting
CREATE TABLE [dbo].[BetLimitControlCustSetting](
	[CustID] [int] NOT NULL,
	[BetLimitTypeID] [int] NOT NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[Mode] [tinyint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NULL,
 CONSTRAINT [PK_BetLimitControlCustSetting] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[BetLimitTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

ALTER TABLE [dbo].[BetLimitControlCustSetting] ADD  CONSTRAINT [DF_BetLimitControlCustSetting_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

ALTER TABLE [dbo].[BetLimitControlCustSetting] ADD  CONSTRAINT [DF_BetLimitControlCustSetting_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

CREATE NONCLUSTERED INDEX [IX_BetLimitControlCustSetting_RepUpdateTime] ON [dbo].[BetLimitControlCustSetting]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO

-----------------------------------------------
--BetLimitControlDefaultSetting
CREATE TABLE [dbo].[BetLimitControlDefaultSetting](
	[CustID] [int] NOT NULL,
	[BetLimitTypeID] [int] NOT NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NULL,
 CONSTRAINT [PK_BetLimitControlDefaultSetting] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[BetLimitTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

ALTER TABLE [dbo].[BetLimitControlDefaultSetting] ADD  CONSTRAINT [DF_BetLimitControlDefaultSetting_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

ALTER TABLE [dbo].[BetLimitControlDefaultSetting] ADD  CONSTRAINT [DF_BetLimitControlDefaultSetting_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

CREATE NONCLUSTERED INDEX [IX_BetLimitControlDefaultSetting_RepUpdateTime] ON [dbo].[BetLimitControlDefaultSetting]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO

-----------------------------------------------
--BetLimitControlProduct
CREATE TABLE [dbo].[BetLimitControlProduct](
	[ProductID] [tinyint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NULL,
 CONSTRAINT [PK_BetLimitControlProduct] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

ALTER TABLE [dbo].[BetLimitControlProduct] ADD  CONSTRAINT [DF_BetLimitControlProduct_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

ALTER TABLE [dbo].[BetLimitControlProduct] ADD  CONSTRAINT [DF_BetLimitControlProduct_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

CREATE NONCLUSTERED INDEX [IX_BetLimitControlProduct_RepUpdateTime] ON [dbo].[BetLimitControlProduct]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO
-----------------------------------------------
--BetLimitControlType
CREATE TABLE [dbo].[BetLimitControlType](
	[BetLimitTypeID] [int] IDENTITY(1,1) NOT NULL,
	[BetLimitType] [varchar](50) NOT NULL,
	[BeginTime] [time](7) NULL,
	[EndTime] [time](7) NULL,
	[LiveIndicator] [tinyint] NOT NULL,
	[RestrictVIP] [bit] NOT NULL,
	[ExcludedLeagueGroupList] [varchar](4000) NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NULL,
 CONSTRAINT [PK_BetLimitControlType] PRIMARY KEY CLUSTERED 
(
	[BetLimitTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

ALTER TABLE [dbo].[BetLimitControlType] ADD  CONSTRAINT [DF_BetLimitControlType_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

ALTER TABLE [dbo].[BetLimitControlType] ADD  CONSTRAINT [DF_BetLimitControlType_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

CREATE NONCLUSTERED INDEX [IX_BetLimitControlType_RepUpdateTime] ON [dbo].[BetLimitControlType]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO
-----------------------------------------------
--BetLimitControlTypeDetails
CREATE TABLE [dbo].[BetLimitControlTypeDetails](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BetLimitTypeID] [int] NOT NULL,
	[ProductID] [tinyint] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[LeagueGroupID] [int] NOT NULL,
	[LeagueID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NULL,
CONSTRAINT PK_BetLimitControlTypeDetails PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

ALTER TABLE [dbo].[BetLimitControlTypeDetails] ADD  CONSTRAINT [DF_BetLimitControlTypeDetails_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

ALTER TABLE [dbo].[BetLimitControlTypeDetails] ADD  CONSTRAINT [DF_BetLimitControlTypeDetails_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

CREATE NONCLUSTERED INDEX [IX_BetLimitControlTypeDetails_RepUpdateTime] ON [dbo].[BetLimitControlTypeDetails]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO
-----------------------------------------------
--BetRestriction_Currency
CREATE TABLE [dbo].[BetRestriction_Currency](
	[ExchangeID] [int] NOT NULL,
	[Type] [tinyint] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[LiveBetAccept] [smallint] NULL,
	[SeizeBetTicket] [tinyint] NULL,
	[FollowAccount] [int] NULL,
	[AccumulateBalance] [bit] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NULL,
 CONSTRAINT [PK_BetRestriction_Currency] PRIMARY KEY CLUSTERED 
(
	[ExchangeID] ASC,
	[SportType] ASC,
	[Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

ALTER TABLE [dbo].[BetRestriction_Currency] ADD  CONSTRAINT [DF_BetRestriction_Currency_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

ALTER TABLE [dbo].[BetRestriction_Currency] ADD  CONSTRAINT [DF_BetRestriction_Currency_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

CREATE NONCLUSTERED INDEX [IX_BetRestriction_Currency_RepUpdateTime] ON [dbo].[BetRestriction_Currency]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO
-----------------------------------------------
--BetRestriction_Customer
CREATE TABLE [dbo].[BetRestriction_Customer](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[LiveBetAccept] [smallint] NULL,
	[SeizeBetTicket] [tinyint] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[FollowAccount] [int] NULL,
	[LeagueGroupID] [varchar](4000) NULL,
	[AccumulateBalance] [bit] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NULL,
 CONSTRAINT [PK_BetRestriction_Customer] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

ALTER TABLE [dbo].[BetRestriction_Customer] ADD  CONSTRAINT [DF_BetRestriction_Customer_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

ALTER TABLE [dbo].[BetRestriction_Customer] ADD  CONSTRAINT [DF_BetRestriction_Customer_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

CREATE NONCLUSTERED INDEX [IX_BetRestriction_Customer_RepUpdateTime] ON [dbo].[BetRestriction_Customer]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO
-----------------------------------------------
--BetRestriction_Setting
CREATE TABLE [dbo].[BetRestriction_Setting](
	[SettingID] [smallint] IDENTITY(1,1) NOT NULL,
	[SportType] [smallint] NOT NULL,
	[RestrictionLevel] [varchar](30) NOT NULL,
	[IsLicensee] [bit] NOT NULL,
	[BackEndStatus] [tinyint] NOT NULL,
	[LiveBetAcceptStatus] [bit] NOT NULL,
	[SeizeBetTicketStatus] [bit] NOT NULL,
	[BetLimitStatus] [bit] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NULL,
 CONSTRAINT [PK_BetRestriction_Setting] PRIMARY KEY CLUSTERED 
(
	[SettingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[BetRestriction_Setting] ADD  CONSTRAINT [DF_BetRestriction_Setting_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

ALTER TABLE [dbo].[BetRestriction_Setting] ADD  CONSTRAINT [DF_BetRestriction_Setting_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

CREATE NONCLUSTERED INDEX [IX_BetRestriction_Setting_RepUpdateTime] ON [dbo].[BetRestriction_Setting]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO
-----------------------------------------------
--BetRestriction_Site
CREATE TABLE [dbo].[BetRestriction_Site](
	[SiteID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[LiveBetAccept] [smallint] NULL,
	[SeizeBetTicket] [tinyint] NULL,
	[FollowAccount] [int] NULL,
	[AccumulateBalance] [bit] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NULL,
 CONSTRAINT [PK_BetRestriction_Site] PRIMARY KEY CLUSTERED 
(
	[SiteID] ASC,
	[SportType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[BetRestriction_Site] ADD  CONSTRAINT [DF_BetRestriction_Site_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

ALTER TABLE [dbo].[BetRestriction_Site] ADD  CONSTRAINT [DF_BetRestriction_Site_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

CREATE NONCLUSTERED INDEX [IX_BetRestriction_Site_RepUpdateTime] ON [dbo].[BetRestriction_Site]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO