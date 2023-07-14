/*<info serverAlias="DBTP-bodb_CustHistory"></info>*/
/*
	Created: Eden@20230714
	Task: Create new temp History tables to store trigger data [Redmine: #191243]   
	DB: DBTP-bodb_CustHistory
*/
USE bodb_CustHistory
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CustBetSetting_Agent_History_Tmp](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[MaxPerNumber] [money] NULL,
	[MaxPayoutPerMatch] [money] NULL,
	[UpdateTime] [datetime] NOT NULL
) ON [CustSetting_table]
GO

ALTER TABLE [dbo].[CustBetSetting_Agent_History_Tmp] ADD  CONSTRAINT [DF_CustBetSetting_Agent_History_Tmp_UpdateTime]  DEFAULT (getdate()) FOR [UpdateTime]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CustBetSetting_Member_History_Tmp](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[MaxPerNumber] [money] NULL,
	[MaxPayoutPerMatch] [money] NULL,
	[UpdateTime] [datetime] NOT NULL
) ON [CustSetting_table]
GO

ALTER TABLE [dbo].[CustBetSetting_Member_History_Tmp] ADD  CONSTRAINT [DF_CustBetSetting_Member_History_Tmp_UpdateTime]  DEFAULT (getdate()) FOR [UpdateTime]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Dep_CustBetSettingGame_Agent_History_Tmp](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[MaxPerNumber] [money] NULL,
	[MaxPayoutPerMatch] [money] NULL,
	[IsInserted] [bit] NULL,
	[UpdateTime] [datetime] NOT NULL
) ON [Dep_CustSetting_table]
GO

ALTER TABLE [dbo].[Dep_CustBetSettingGame_Agent_History_Tmp] ADD  CONSTRAINT [DF_Dep_CustBetSettingGame_Agent_History_Tmp_UpdateTime]  DEFAULT (getdate()) FOR [UpdateTime]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Dep_CustBetSettingGameGroup_Member_History_Tmp](
	[AgentID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[MaxPerNumber] [money] NULL,
	[MaxPayoutPerMatch] [money] NULL,
	[IsInserted] [bit] NULL,
	[UpdateTime] [datetime] NOT NULL
) ON [Dep_CustSetting_table]
GO

ALTER TABLE [dbo].[Dep_CustBetSettingGameGroup_Member_History_Tmp] ADD  CONSTRAINT [DF_Dep_CustBetSettingGameGroup_Member_History_Tmp_UpdateTime]  DEFAULT (getdate()) FOR [UpdateTime]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Dep_CustBetSettingGame_Member_History_Tmp](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[MaxPerNumber] [money] NULL,
	[MaxPayoutPerMatch] [money] NULL,
	[IsInserted] [bit] NULL,
	[UpdateTime] [datetime] NOT NULL
) ON [Dep_CustSetting_table]
GO

ALTER TABLE [dbo].[Dep_CustBetSettingGame_Member_History_Tmp] ADD  CONSTRAINT [DF_Dep_CustBetSettingGame_Member_History_Tmp_UpdateTime]  DEFAULT (getdate()) FOR [UpdateTime]
GO