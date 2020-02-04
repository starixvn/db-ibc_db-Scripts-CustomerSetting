/*
	Created by: Eden
	Date: 20200116
	Task: Create New History tables For SB - Deposit DCS & Number Games DCS [Redmine:#123750]		
	DB: DBTP/bodb_CustHistory
*/
USE bodb_CustHistory
GO
DROP TABLE [dbo].[DSB_CustBetSetting_Member_History] 
GO

DROP TABLE [dbo].[DSB_CustBetSetting_Agent_History]
GO

DROP TABLE [dbo].[DSB_CustGroupBetSetting_Member_History]
GO

DROP TABLE [dbo].[DSB_CustDiscount_Agent_History]
GO

DROP TABLE [dbo].[DSB_CustDiscount_Member_History]
GO

DROP TABLE [dbo].[DSB_CustGroupDiscount_Member_History]
GO

DROP TABLE [dbo].[DSB_CustPTSetting_Agent_History]
GO

DROP TABLE [dbo].[DSB_CustPTSetting_Member_History]
GO

DROP TABLE [dbo].[DSB_CustPTGroupSetting_Member_History]
GO

DROP TABLE [dbo].[DSB_CustSettingMode_History]
GO

DROP TABLE [dbo].[Dep_CustBetSettingGame_Agent_History]
GO

DROP TABLE [dbo].[Dep_CustBetSettingGame_Member_History]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

----> BET SETTING
CREATE TABLE [dbo].[DSB_CustBetSetting_Member_History](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL DEFAULT ((0)),
	[MaxBet] [money] NULL DEFAULT ((0)),
	[MaxPerMatch] [money] NULL DEFAULT ((0)),
	[UpdateTime] [datetime] NOT NULL  DEFAULT (getdate())
) ON [Dep_CustSetting3rd_table]

GO
CREATE CLUSTERED INDEX [DSB_CustBetSetting_Member_History_Index] ON [dbo].[DSB_CustBetSetting_Member_History]
(
	[UpdateTime] ASC,
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustSetting3rd_table]
GO

CREATE TABLE [dbo].[DSB_CustBetSetting_Agent_History](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL DEFAULT ((0)),
	[MaxBet] [money] NULL DEFAULT ((0)),
	[MaxPerMatch] [money] NULL DEFAULT ((0)),
	[UpdateTime] [datetime] NOT NULL  DEFAULT (getdate())
) ON [Dep_CustSetting3rd_table]

GO
CREATE CLUSTERED INDEX [DSB_CustBetSetting_Agent_History_Index] ON [dbo].[DSB_CustBetSetting_Agent_History]
(
	[UpdateTime] ASC,
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustSetting3rd_table]
GO

CREATE TABLE [dbo].[DSB_CustGroupBetSetting_Member_History](
	[AgentID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL DEFAULT ((0)),
	[MaxBet] [money] NULL DEFAULT ((0)),
	[MaxPerMatch] [money] NULL DEFAULT ((0)),
	[UpdateTime] [datetime] NOT NULL  DEFAULT (getdate())
) ON [Dep_CustSetting3rd_table]

GO
CREATE CLUSTERED INDEX [DSB_CustGroupBetSetting_Member_History_Index] ON [dbo].[DSB_CustGroupBetSetting_Member_History]
(
	[UpdateTime] ASC,
	[AgentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustSetting3rd_table]
GO

--> Commission
CREATE TABLE [dbo].[DSB_CustDiscount_Agent_History](
	[CustId] [int] NOT NULL,
	[Discount] [binary](10) NOT NULL,
	[UpdateTime] [datetime] NOT NULL  DEFAULT (getdate())
) ON [Dep_CustSetting3rd_table]

GO
CREATE CLUSTERED INDEX [DSB_CustDiscount_Agent_History_Index] ON [dbo].[DSB_CustDiscount_Agent_History]
(
	[UpdateTime] ASC,
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustSetting3rd_table]
GO

CREATE TABLE [dbo].[DSB_CustDiscount_Member_History](
	[CustId] [int] NOT NULL,
	[PlayerDiscount] [binary](10) NOT NULL,
	[AgentDiscount] [binary](10) NOT NULL,
	[MasterDiscount] [binary](10) NOT NULL,
	[SuperDiscount] [binary](10) NOT NULL,
	[UpdateTime] [datetime] NOT NULL  DEFAULT (getdate())
) ON [Dep_CustSetting3rd_table]

GO
CREATE CLUSTERED INDEX [DSB_CustDiscount_Member_History_Index] ON [dbo].[DSB_CustDiscount_Member_History]
(
	[UpdateTime] ASC,
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustSetting3rd_table]
GO

CREATE TABLE [dbo].[DSB_CustGroupDiscount_Member_History](
	[AgentId] [int] NOT NULL,
	[PlayerDiscount] [binary](10) NOT NULL,
	[AgentDiscount] [binary](10) NOT NULL,
	[MasterDiscount] [binary](10) NOT NULL,
	[SuperDiscount] [binary](10) NOT NULL,
	[UpdateTime] [datetime] NOT NULL  DEFAULT (getdate())
) ON [Dep_CustSetting3rd_table]

GO
CREATE CLUSTERED INDEX [DSB_CustGroupDiscount_Member_History_Index] ON [dbo].[DSB_CustGroupDiscount_Member_History]
(
	[UpdateTime] ASC,
	[AgentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustSetting3rd_table]
GO

--> PT
CREATE TABLE [dbo].[DSB_CustPTSetting_Agent_History](
	[CustId] [int] NOT NULL,
	[SuperPT] [binary](10) NULL,
	[MasterPT] [binary](10) NULL,
	[AgentPT] [binary](10) NULL,
	[UpdateTime] [datetime] NOT NULL  DEFAULT (getdate())
) ON [Dep_CustSetting3rd_table]

GO
CREATE CLUSTERED INDEX [DSB_CustPTSetting_Agent_History_Index] ON [dbo].[DSB_CustPTSetting_Agent_History]
(
	[UpdateTime] ASC,
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustSetting3rd_table]
GO

CREATE TABLE [dbo].[DSB_CustPTSetting_Member_History](
	[CustId] [int] NOT NULL,
	[SuperPT] [binary](10) NULL,
	[MasterPT] [binary](10) NULL,
	[AgentPT] [binary](10) NULL,
	[UpdateTime] [datetime] NOT NULL  DEFAULT (getdate())
) ON [Dep_CustSetting3rd_table]

GO
CREATE CLUSTERED INDEX [DSB_CustPTSetting_Member_History_Index] ON [dbo].[DSB_CustPTSetting_Member_History]
(
	[UpdateTime] ASC,
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustSetting3rd_table]
GO

CREATE TABLE [dbo].[DSB_CustPTGroupSetting_Member_History](
	[AgentID] [int] NOT NULL,
	[SuperPT] [binary](10) NULL,
	[MasterPT] [binary](10) NULL,
	[AgentPT] [binary](10) NULL,
	[UpdateTime] [datetime] NOT NULL  DEFAULT (getdate())
) ON [Dep_CustSetting3rd_table]

GO
CREATE CLUSTERED INDEX [DSB_CustPTGroupSetting_Member_History_Index] ON [dbo].[DSB_CustPTGroupSetting_Member_History]
(
	[UpdateTime] ASC,
	[AgentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustSetting3rd_table]
GO

--> Setting
CREATE TABLE [dbo].[DSB_CustSettingMode_History](
	[CustID] [int] NOT NULL,
	[IsGroupedPT] [bit] NOT NULL DEFAULT ((0)),
	[IsGroupedComm] [bit] NOT NULL DEFAULT ((0)),
	[IsGroupedBetLimit] [bit] NOT NULL  DEFAULT ((0)),
	[UpdateTime] [datetime] NOT NULL  DEFAULT (getdate())
) ON [Dep_CustSetting3rd_table]


GO
CREATE CLUSTERED INDEX [DSB_CustSettingMode_History_Index] ON [dbo].[DSB_CustSettingMode_History]
(
	[UpdateTime] ASC,
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustSetting3rd_table]
GO

--> Bet setting table for Number games
CREATE TABLE [dbo].[Dep_CustBetSettingGame_Member_History](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL DEFAULT ((0)),
	[MaxBet] [money] NULL DEFAULT ((0)),
	[MaxPerMatch] [money] NULL DEFAULT ((0)),
	[MaxPerBall] [money] NULL DEFAULT ((0)),
	[UpdateTime] [datetime] NOT NULL  DEFAULT (getdate())
) ON [Dep_CustSetting3rd_table]


GO
CREATE CLUSTERED INDEX [Dep_CustBetSettingGame_Member_History_Index] ON [dbo].[Dep_CustBetSettingGame_Member_History]
(
	[UpdateTime] ASC,
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustSetting3rd_table]
GO

CREATE TABLE [dbo].[Dep_CustBetSettingGame_Agent_History](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL DEFAULT ((0)),
	[MaxBet] [money] NULL DEFAULT ((0)),
	[MaxPerMatch] [money] NULL DEFAULT ((0)),
	[MaxPerBall] [money] NULL DEFAULT ((0)),
	[UpdateTime] [datetime] NOT NULL  DEFAULT (getdate())
) ON [Dep_CustSetting3rd_table]

GO
CREATE CLUSTERED INDEX [Dep_CustBetSettingGame_Agent_History_Index] ON [dbo].[Dep_CustBetSettingGame_Agent_History]
(
	[UpdateTime] ASC,
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustSetting3rd_table]
GO