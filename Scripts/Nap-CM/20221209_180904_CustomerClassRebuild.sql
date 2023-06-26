/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20221209@Winfred
	DB: DBCUST/CustDB, DBACC-bodb02 and add pub CustDB_CustSetting
	Task:  Create table Build Customer Class Management
	Revisions:
		- 20221209@Winfred:  Create table Build Customer Class Management [RedmineID: #180904]
*/

--DROP TABLE [dbo].[CustomerClassRule]
--DROP TABLE [dbo].[CustomerClassRuleLeagueGroup]
--DROP TABLE [dbo].[CustomerClassPolicyManagement]
--DROP TABLE [dbo].[CustomerClassPolicyRule]
--DROP TABLE [dbo].[CustomerClassSiteManagement]

--DROP TABLE [dbo].[CustomerClassRule_UAT]
--DROP TABLE [dbo].[CustomerClassRuleLeagueGroup_UAT]
--DROP TABLE [dbo].[CustomerClassPolicyManagement_UAT]
--DROP TABLE [dbo].[CustomerClassPolicyRule_UAT]
--DROP TABLE [dbo].[CustomerClassSiteManagement_UAT]

CREATE TABLE [dbo].[CustomerClassRule](
	[RuleID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerClass] [smallint]  NOT NULL,
	[RuleTitle] [varchar](500)  NOT NULL,
	[SportType] [smallint]  NOT NULL,
	[IsLive] [tinyint]  NOT NULL,
	[DiffBalanceRatio] [decimal](9, 2) NULL,
	[BetDelay] [decimal](9, 2) NULL,
	[NextBetInterval] [smallint] NULL,
	[SuperBetInterval] [smallint] NULL,
	[SiteBetInterval] [smallint] NULL,
	[MinBet] [int] NULL,
	[MaxBet] [int] NULL,
	[MaxPerMatch] [int] NULL,
	[RepeatedBets] [tinyint] NULL,
	[SeizeBetTicket] [tinyint] NULL,
	[EnableParlay] [bit]  NOT NULL,
	[PeakHourSpreadAdjustment] [smallint] NULL,
	[AgentBetInterval] [smallint] NULL,
	[Enable] [bit]  NOT NULL,
	[IsTest] [TINYINT]  NOT NULL,
	[LastModifiedUser] [int] NULL,
	[LastModifiedTime] [datetime] NULL,
 CONSTRAINT [PK_CustomerClassRule] PRIMARY KEY NONCLUSTERED
(
	[RuleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]

GO

CREATE CLUSTERED  INDEX [CIX_CustomerClassRule] ON [dbo].[CustomerClassRule] 
(
	[CustomerClass] ASC,
	[SportType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

CREATE TABLE [dbo].[CustomerClassRuleLeagueGroup](
	[RuleID] [int] NOT NULL,
	[LeagueGroupID] [smallint] NOT NULL,
 CONSTRAINT [PK_CustomerClassRuleLeagueGroup] PRIMARY KEY CLUSTERED 
(
	[RuleID] ASC,
	[LeagueGroupID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO

--==================================================================
CREATE TABLE [dbo].[CustomerClassPolicyManagement](
	[PolicyID] [int] IDENTITY(1,1) NOT NULL,
	[PolicyTitle] [varchar](500)  NOT NULL,
	[SportType] [smallint]  NOT NULL,
	[IsTest] [TINYINT]  NOT NULL,
	[LastModifiedUser] [int] NULL,
	[LastModifiedTime] [datetime] NULL,
 CONSTRAINT [PK_CustomerClassPolicyManagement] PRIMARY KEY CLUSTERED 
(
	[PolicyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]

GO

CREATE NONCLUSTERED INDEX [CIX_CustomerClassPolicyManagement] ON [dbo].[CustomerClassPolicyManagement] 
(
	[SportType] ASC,
	[IsTest] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

CREATE TABLE [dbo].[CustomerClassPolicyRule](
	[PolicyID] [int] NOT NULL,
	[RuleID] [int] NOT NULL,
 CONSTRAINT [PK_CustomerClassPolicyRule] PRIMARY KEY CLUSTERED 
(
	[RuleID] ASC,
	[PolicyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO

CREATE TABLE [dbo].[CustomerClassSiteManagement](
	[PolicyID] [int] NOT NULL,
	[Site] [nvarchar](50) NOT NULL,
	[Currency] [tinyint] NOT NULL,
	[Platform] [tinyint] NOT NULL,
	[LastModifiedUser] [int] NULL,
	[LastModifiedTime] [datetime] NULL,
 CONSTRAINT [PK_CustomerClassSiteManagement] PRIMARY KEY CLUSTERED 
(
	[PolicyID] ASC,
	[Site] ASC,
	[Currency] ASC,
	[Platform] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO

CREATE NONCLUSTERED INDEX [IX_CustomerClassSiteManagement_Site] ON [dbo].[CustomerClassSiteManagement] 
(
	[Site] ASC,
	[Currency] ASC,
	[Platform] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

--================================= UAT

CREATE TABLE [dbo].[CustomerClassRule_UAT](
	[RuleID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerClass] [smallint]  NOT NULL,
	[RuleTitle] [varchar](500)  NOT NULL,
	[SportType] [smallint]  NOT NULL,
	[IsLive] [tinyint]  NOT NULL,
	[DiffBalanceRatio] [decimal](9, 2) NULL,
	[BetDelay] [decimal](9, 2) NULL,
	[NextBetInterval] [smallint] NULL,
	[SuperBetInterval] [smallint] NULL,
	[SiteBetInterval] [smallint] NULL,
	[MinBet] [int] NULL,
	[MaxBet] [int] NULL,
	[MaxPerMatch] [int] NULL,
	[RepeatedBets] [tinyint] NULL,
	[SeizeBetTicket] [tinyint] NULL,
	[EnableParlay] [bit]  NOT NULL,
	[PeakHourSpreadAdjustment] [smallint] NULL,
	[AgentBetInterval] [smallint] NULL,
	[Enable] [bit]  NOT NULL,
	[IsTest] [TINYINT]  NOT NULL,
	[LastModifiedUser] [int] NULL,
	[LastModifiedTime] [datetime] NULL,
 CONSTRAINT [PK_CustomerClassRule_UAT] PRIMARY KEY NONCLUSTERED 
(
	[RuleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO

CREATE CLUSTERED INDEX [CIX_CustomerClassRule_UAT] ON [dbo].[CustomerClassRule_UAT] 
(
	[CustomerClass] ASC,
	[SportType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

CREATE TABLE [dbo].[CustomerClassRuleLeagueGroup_UAT](
	[RuleID] [int] NOT NULL,
	[LeagueGroupID] [smallint] NOT NULL,
 CONSTRAINT [PK_CustomerClassRuleLeagueGroup_UAT] PRIMARY KEY CLUSTERED 
(
	[RuleID] ASC,
	[LeagueGroupID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO

--==================================================================
CREATE TABLE [dbo].[CustomerClassPolicyManagement_UAT](
	[PolicyID] [int] IDENTITY(1,1) NOT NULL,
	[PolicyTitle] [varchar](500)  NOT NULL,
	[SportType] [smallint]  NOT NULL,
	[IsTest] [TINYINT]  NOT NULL,
	[LastModifiedUser] [int] NULL,
	[LastModifiedTime] [datetime] NULL,
 CONSTRAINT [PK_CustomerClassPolicyManagement_UAT] PRIMARY KEY CLUSTERED 
(
	[PolicyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]

GO

CREATE NONCLUSTERED INDEX [CIX_CustomerClassPolicyManagement_UAT] ON [dbo].[CustomerClassPolicyManagement_UAT] 
(
	[SportType] ASC,
	[IsTest] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

CREATE TABLE [dbo].[CustomerClassPolicyRule_UAT](
	[PolicyID] [int] NOT NULL,
	[RuleID] [int] NOT NULL,
 CONSTRAINT [PK_CustomerClassPolicyRule_UAT] PRIMARY KEY CLUSTERED 
(
	[RuleID] ASC,
	[PolicyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO

CREATE TABLE [dbo].[CustomerClassSiteManagement_UAT](
	[PolicyID] [int] NOT NULL,
	[Site] [nvarchar](50) NOT NULL,
	[Currency] [tinyint] NOT NULL,
	[Platform] [tinyint] NOT NULL,
	[LastModifiedUser] [int] NULL,
	[LastModifiedTime] [datetime] NULL,
 CONSTRAINT [PK_CustomerClassSiteManagement_UAT] PRIMARY KEY CLUSTERED 
(
	[PolicyID] ASC,
	[Site] ASC,
	[Currency] ASC,
	[Platform] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO

CREATE NONCLUSTERED INDEX [IX_CustomerClassSiteManagement_UAT_Site] ON [dbo].[CustomerClassSiteManagement_UAT] 
(
	[Site] ASC,
	[Currency] ASC,
	[Platform] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

