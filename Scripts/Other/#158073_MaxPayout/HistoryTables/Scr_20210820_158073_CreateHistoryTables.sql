/*<info serverAlias="DBTP-bodb_CustHistory"></info>*/
/*
	Created: Eden@20210820
	Task: Create new history tables [CustBetSetting_Agent_History], [CustBetSetting_Member_History] [Redmine: #158073]   
	DB: DBTP/bodb_CustHistory
*/
USE bodb_CustHistory
GO
--DROP TABLE [CustBetSetting_Agent_History]
--DROP TABLE [CustBetSetting_Member_History]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CustBetSetting_Agent_History](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[MaxPerNumber] [money] NULL,
	[MaxPayoutPerMatch] [money] NULL,
	[UpdateTime] [DATETIME] NOT NULL CONSTRAINT [DF_CustBetSetting_Agent_History_UpdateTime]  DEFAULT (GETDATE()),
 CONSTRAINT [PK_CustBetSetting_Agent_History] PRIMARY KEY CLUSTERED 
(
	[UpdateTime] ASC,
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [CustSetting_table]
) ON [CustSetting_table]

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CustBetSetting_Member_History](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[MaxPerNumber] [money] NULL,
	[MaxPayoutPerMatch] [money],
	[UpdateTime] [DATETIME] NOT NULL CONSTRAINT [DF_CustBetSetting_Member_History_UpdateTime]  DEFAULT (GETDATE()),
 CONSTRAINT [PK_CustBetSetting_Member_History] PRIMARY KEY CLUSTERED 
(
	[UpdateTime] ASC,
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [CustSetting_table]
) ON [CustSetting_table]

GO
