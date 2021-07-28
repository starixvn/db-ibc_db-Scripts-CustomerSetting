/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20212607
	Task: Create new tables to store bet setting for Sportbooks and NumberGame - credit[Redmine: #154048]   
	DB: DBCUST/CUSTDB and all subscribers of CustDB_CustSetting publication
*/
USE [CustDB]
GO
--DROP TABLE [CustBetSetting_Agent]
--DROP TABLE [CustBetSetting_Member]
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CustBetSetting_Agent](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL CONSTRAINT [DF_CustBetSetting_Agent_MinBet]  DEFAULT ((0)),
	[MaxBet] [money] NULL CONSTRAINT [DF_CustBetSetting_Agent_MaxBet]  DEFAULT ((0)),
	[MaxPerMatch] [money] NULL CONSTRAINT [DF_CustBetSetting_Agent_MPM]  DEFAULT ((0)),
	[MaxPerNumber] [money] NULL CONSTRAINT [DF_CustBetSetting_Agent_MPN]  DEFAULT ((0)),
	[MaxPayoutPerMatch] [money] NULL CONSTRAINT [DF_CustBetSetting_Agent_MPPM]  DEFAULT ((0)),
 CONSTRAINT [PK_CustBetSetting_Agent] PRIMARY KEY CLUSTERED 
(
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

CREATE TABLE [dbo].[CustBetSetting_Member](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL CONSTRAINT [DF_CustBetSetting_Member_MinBet]  DEFAULT ((0)),
	[MaxBet] [money] NULL CONSTRAINT [DF_CustBetSetting_Member_MaxBet]  DEFAULT ((0)),
	[MaxPerMatch] [money] NULL CONSTRAINT [DF_CustBetSetting_Member_MPM]  DEFAULT ((0)),
	[MaxPerNumber] [money] NULL CONSTRAINT [DF_CustBetSetting_Member_MPN]  DEFAULT ((0)),
	[MaxPayoutPerMatch] [money] NULL CONSTRAINT [DF_CustBetSetting_Member_MPPM]  DEFAULT ((0)),
 CONSTRAINT [PK_CustBetSetting_Member] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [CustSetting_table]
) ON [CustSetting_table]

GO
