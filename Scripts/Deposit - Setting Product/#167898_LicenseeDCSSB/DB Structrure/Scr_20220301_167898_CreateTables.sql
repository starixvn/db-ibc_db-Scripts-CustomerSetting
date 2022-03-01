/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Eden@20220301
	Task: Create New tables For SB - Deposit DCS & Number Games DCS [Redmine:#167898]		
	DB: DBCUST/CustDB
	Replication : add to CustDB_Custsetting publication
*/

DROP TABLE [dbo].[Dep_CustBetSettingGame_Agent]
GO

DROP TABLE [dbo].[Dep_CustBetSettingGame_Member]
GO

DROP TABLE [dbo].[Dep_CustGroupBetSettingGame_Member]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Dep_CustBetSettingGame_Member](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL CONSTRAINT [DF_Dep_CustBetSettingGame_Member_MinBet]  DEFAULT ((0)),
	[MaxBet] [money] NULL CONSTRAINT [DF_Dep_CustBetSettingGame_Member_MaxBet]  DEFAULT ((0)),
	[MaxPerMatch] [money] NULL CONSTRAINT [DF_Dep_CustBetSettingGame_Member_MPM]  DEFAULT ((0)),
	[MaxPerNumber] [money] NULL CONSTRAINT [DF_Dep_CustBetSettingGame_Member_MPN]  DEFAULT ((0)),
	[MaxPayoutPerMatch] [money] NULL CONSTRAINT [DF_Dep_CustBetSettingGame_Member_MPPM]  DEFAULT ((0))
	CONSTRAINT [PK_Dep_CustBetSettingGame_Member] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustBetSetting_Member_table]
) ON [Dep_CustBetSetting_Member_table]

GO

CREATE TABLE [dbo].[Dep_CustBetSettingGame_Agent](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL CONSTRAINT [DF_Dep_CustBetSettingGame_Agent_MinBet]  DEFAULT ((0)),
	[MaxBet] [money] NULL CONSTRAINT [DF_Dep_CustBetSettingGame_Agent_MaxBet]  DEFAULT ((0)),
	[MaxPerMatch] [money] NULL CONSTRAINT [DF_Dep_CustBetSettingGame_Agent_MPM]  DEFAULT ((0)),
	[MaxPerNumber] [money] NULL CONSTRAINT [DF_Dep_CustBetSettingGame_Agent_MPN]  DEFAULT ((0)),
	[MaxPayoutPerMatch] [money] NULL CONSTRAINT [DF_Dep_CustBetSettingGame_Agent_MPPM]  DEFAULT ((0))
	CONSTRAINT [PK_Dep_CustBetSettingGame_Agent] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustBetSetting_Agent_table]
) ON [Dep_CustBetSetting_Agent_table]

GO

CREATE TABLE [dbo].[Dep_CustGroupBetSettingGame_Member](
	[AgentID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL CONSTRAINT [DF_Dep_CustGroupBetSettingGame_Member_MinBet]  DEFAULT ((0)),
	[MaxBet] [money] NULL CONSTRAINT [DF_Dep_CustGroupBetSettingGame_Member_MaxBet]  DEFAULT ((0)),
	[MaxPerMatch] [money] NULL CONSTRAINT [DF_Dep_CustGroupBetSettingGame_Member_MPM]  DEFAULT ((0)),
	[MaxPerNumber] [money] NULL CONSTRAINT [DF_Dep_CustGroupBetSettingGame_Member_MPN]  DEFAULT ((0)),
	[MaxPayoutPerMatch] [money] NULL CONSTRAINT [DF_Dep_CustGroupBetSettingGame_Member_MPPM]  DEFAULT ((0))
	CONSTRAINT [PK_Dep_CustGroupBetSettingGame_Member] PRIMARY KEY CLUSTERED 
(
	[AgentID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustBetSetting_Agent_table]
) ON [Dep_CustBetSetting_Member_table]

GO