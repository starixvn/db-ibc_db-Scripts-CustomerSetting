/*<info serverAlias="DBTP-bodb_CustHistory"></info>*/
/*
	Created by: Eden@20220301
	Task: Create New tables For SB - Deposit DCS & Number Games DCS [Redmine:#167898]		
	DB: DBTP-bodb_CustHistory
*/
USE bodb_CustHistory 
GO

DROP TABLE [dbo].[Dep_CustBetSettingGame_Agent_History]
GO

DROP TABLE [dbo].[Dep_CustBetSettingGame_Member_History]
GO

DROP TABLE [dbo].[Dep_CustBetSettingGameGroup_Member_History]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Dep_CustBetSettingGame_Member_History](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[MaxPerNumber] [money] NULL,
	[MaxPayoutPerMatch] [money] NULL,
	[IsInserted] [BIT] NULL,
	[UpdateTime] [DATETIME] NOT NULL CONSTRAINT [DF_Dep_CustBetSettingGame_Member_History_UpdateTime]  DEFAULT (GETDATE()),
	CONSTRAINT [PK_Dep_CustBetSettingGame_Member_History] PRIMARY KEY CLUSTERED 
(
	[UpdateTime] ASC,
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON Dep_CustBetSetting_table
) ON Dep_CustBetSetting_table

GO

CREATE TABLE [dbo].[Dep_CustBetSettingGame_Agent_History](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[MaxPerNumber] [money] NULL,
	[MaxPayoutPerMatch] [money] NULL,
	[IsInserted] [BIT] NULL,
	[UpdateTime] [DATETIME] NOT NULL CONSTRAINT [DF_Dep_CustBetSettingGame_Agent_History_UpdateTime]  DEFAULT (GETDATE()),
	CONSTRAINT [PK_Dep_CustBetSettingGame_Agent_History] PRIMARY KEY CLUSTERED 
(
	[UpdateTime] ASC,
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON Dep_CustBetSetting_table
) ON Dep_CustBetSetting_table

GO

CREATE TABLE [dbo].[Dep_CustBetSettingGameGroup_Member_History](
	[AgentID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[MaxPerNumber] [money] NULL,
	[MaxPayoutPerMatch] [money] NULL,
	[IsInserted] [BIT] NULL,
	[UpdateTime] [DATETIME] NOT NULL CONSTRAINT [DF_Dep_CustBetSettingGameGroup_Member_History_UpdateTime]  DEFAULT (GETDATE()),
	CONSTRAINT [PK_Dep_CustBetSettingGameGroup_Member_History] PRIMARY KEY CLUSTERED 
(
	[UpdateTime] ASC,
	[AgentID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON Dep_CustBetSetting_table
) ON Dep_CustBetSetting_table

GO