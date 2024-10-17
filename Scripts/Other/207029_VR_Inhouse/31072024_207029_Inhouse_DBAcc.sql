/*<info serverAlias="DBACC-bodb02"></info>*/
/*
	Created: Winfred
	Date: 31072024
	Task: Scale Out DBCUST - Apply In-house Replication for Virtual Rate Setting  [redmine: #207029]
	DB: DBACC-bodb02
*/


IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VRSettingRuleDetail_NotApply]'))
BEGIN
 DROP VIEW [dbo].VRSettingRuleDetail_NotApply
END
GO

IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VRSettingRuleDetail]'))
BEGIN
	DROP VIEW [dbo].VRSettingRuleDetail
END
GO

IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VRSettingRule]'))
BEGIN
	DROP VIEW [dbo].VRSettingRule
END
GO

CREATE TABLE [dbo].[VRSettingRule](
	[RuleID] [int] NOT NULL,
	[RuleName] [varchar](100) NOT NULL,
	[SiteType] [tinyint] NOT NULL,
	[Betfrom] [varchar](3) NOT NULL,
	[StakeRM_From] [money] NOT NULL,
	[StakeRM_To] [money] NOT NULL,
	[VR_From] [smallmoney] NOT NULL,
	[VR_To] [smallmoney] NOT NULL,
	[VRStatus] [tinyint] NOT NULL,
	[BeginTime] [time](7) NULL,
	[EndTime] [time](7) NULL,
	[LiveIndicator] [tinyint] NOT NULL,
	[Adjustmenttype] [tinyint] NOT NULL,
	[AdjustmentValue] [smallmoney] NOT NULL,
	[Priority] [int] NOT NULL,
	[Status] [tinyint] NOT NULL,
	[CreatedDTS] [datetime] NULL,
	[CreatedBy] [varchar](30) NULL,
	[Enabled_Column] [varchar](200) NULL,
	[AccumulatedBalance] [bit] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_VRSettingRule] PRIMARY KEY CLUSTERED 
(
	[RuleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [virtualrate_table]
) ON [virtualrate_table]
GO

CREATE TABLE [dbo].[VRSettingRuleDetail](
	[DetailID] [int] NOT NULL,
	[RuleID] [int] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[SiteID] [int] NOT NULL,
	[CustomerClass] [smallint] NOT NULL,
	[DateOfWeek] [tinyint] NOT NULL,
	[LeagueGroupID] [int] NOT NULL,
	[LeagueID] [int] NOT NULL,
	[CurrencyID] [int] NOT NULL,
	[CCSporttype] [smallint] NOT NULL,
	[CustomerClassDetail] [smallint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_VRSettingRuleDetail] PRIMARY KEY NONCLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [virtualrate_table]
) ON [virtualrate_table]
GO

CREATE TABLE [dbo].[VRSettingRuleDetail_NotApply](
	[DetailID] [int] NOT NULL,
	[RuleID] [int] NOT NULL,
	[Sporttype] [smallint] NULL,
	[Bettype] [smallint] NULL,
	[SiteID] [int] NULL,
	[CustomerClass] [smallint] NULL,
	[DateOfWeek] [tinyint] NULL,
	[LeagueGroupID] [int] NULL,
	[LeagueID] [int] NULL,
	[CurrencyID] [int] NOT NULL,
	[CCSporttype] [smallint] NOT NULL,
	[CustomerClassDetail] [smallint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_VRSettingRuleDetail_NotApply] PRIMARY KEY NONCLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [virtualrate_table]
) ON [virtualrate_table]
GO

ALTER TABLE [dbo].[VRSettingRule] ADD  CONSTRAINT [DF_VRSettingRule_CreatedDTS]  DEFAULT (getdate()) FOR [CreatedDTS]
GO

ALTER TABLE [dbo].[VRSettingRule] ADD  CONSTRAINT [DF_VRSettingRule_AccumulatedBalance]  DEFAULT ((0)) FOR [AccumulatedBalance]
GO

ALTER TABLE [dbo].[VRSettingRuleDetail] ADD  CONSTRAINT [DF_VRSettingRuleDetail_CurrencyID]  DEFAULT ((0)) FOR [CurrencyID]
GO

ALTER TABLE [dbo].[VRSettingRuleDetail] ADD  CONSTRAINT [DF_VRSettingRuleDetail_CCSporttype]  DEFAULT ((0)) FOR [CCSporttype]
GO

ALTER TABLE [dbo].[VRSettingRuleDetail] ADD  CONSTRAINT [DF_VRSettingRuleDetail_CustomerClass]  DEFAULT ((0)) FOR [CustomerClassDetail]
GO

ALTER TABLE [dbo].[VRSettingRuleDetail_NotApply] ADD  CONSTRAINT [DF_VRSettingRuleDetail_NotApply_CurrencyID]  DEFAULT ((0)) FOR [CurrencyID]
GO

ALTER TABLE [dbo].[VRSettingRuleDetail_NotApply] ADD  CONSTRAINT [DF_VRSettingRuleDetail_NotApply_CCSporttype]  DEFAULT ((0)) FOR [CCSporttype]
GO

ALTER TABLE [dbo].[VRSettingRuleDetail_NotApply] ADD  CONSTRAINT [DF_VRSettingRuleDetail_NotApply_CustomerClass]  DEFAULT ((0)) FOR [CustomerClassDetail]
GO

ALTER TABLE [dbo].[VRSettingRule] ADD  CONSTRAINT [DF_VRSettingRule_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

ALTER TABLE [dbo].[VRSettingRuleDetail] ADD  CONSTRAINT [DF_VRSettingRuleDetail_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

ALTER TABLE [dbo].[VRSettingRuleDetail_NotApply] ADD  CONSTRAINT [DF_VRSettingRuleDetail_NotApply_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

--IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[VRSettingRule]') AND name = N'IX_VRSettingRule_RepUpdateTime')
--	CREATE NONCLUSTERED INDEX [IX_VRSettingRule_RepUpdateTime] ON [dbo].[VRSettingRule]
--	(
--		[RepUpdateTime] ASC
--	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
--GO

--IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[VRSettingRuleDetail]') AND name = N'IX_VRSettingRuleDetail_RepUpdateTime')
--	CREATE NONCLUSTERED INDEX [IX_VRSettingRuleDetail_RepUpdateTime] ON [dbo].[VRSettingRuleDetail]
--	(
--		[RepUpdateTime] ASC
--	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
--GO

--IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[VRSettingRuleDetail_NotApply]') AND name = N'IX_VRSettingRuleDetail_NotApply_RepUpdateTime')
--	CREATE NONCLUSTERED INDEX [IX_VRSettingRuleDetail_NotApply_RepUpdateTime] ON [dbo].[VRSettingRuleDetail_NotApply]
--	(
--		[RepUpdateTime] ASC
--	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
--GO