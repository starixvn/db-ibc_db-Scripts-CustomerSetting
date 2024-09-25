/*<info serverAlias="DBTP-bodb_CustHistory"></info>*/
/*
	Created: 20240604@Eden
	Task: Create table History [#204358]
		BetSetting3rd_Agent_History
		BetSetting3rd_Member_History 
	DB: DBTP-bodb_CustHistory
*/
/****** Object:  Table [dbo].[BetSetting3rd_Agent_History]  ******/
USE bodb_CustHistory
GO
IF OBJECT_ID ('BetSetting3rd_Agent_History') IS NOT NULL
BEGIN
	DROP TABLE [BetSetting3rd_Agent_History]
END

IF OBJECT_ID ('BetSetting3rd_Member_History') IS NOT NULL
BEGIN
	DROP TABLE [BetSetting3rd_Member_History]
END

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BetSetting3rd_Agent_History](
	[rID] [bigint] NOT NULL,
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[MaxPerNumber] [money] NULL,
	[SiteDBGroupID] [SMALLINT] NULL,
	[UpdateTime] [datetime] NOT NULL CONSTRAINT [DF_BetSetting3rd_Agent_History_UpdateTime]  DEFAULT (getdate()),
) ON [CustSetting_table]
GO
/****** Object:  Index [IX_BetSetting3rd_Agent_History]  ******/
CREATE CLUSTERED INDEX [IX_BetSetting3rd_Agent_History] ON [dbo].[BetSetting3rd_Agent_History]
(
	[UpdateTime] ASC,
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF, DATA_COMPRESSION =PAGE) ON [CustSetting_table]
GO
CREATE NONCLUSTERED INDEX [IX_BetSetting3rd_Agent_History2] ON [dbo].[BetSetting3rd_Agent_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF, DATA_COMPRESSION =PAGE) ON [CustSetting_table]
GO
/****** Object:  Table [dbo].[BetSetting3rd_Member_History] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BetSetting3rd_Member_History](
	[rID] [bigint] NOT NULL,
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[MaxPerNumber] [money] NULL,
	[SiteDBGroupID] [SMALLINT] NULL,
	[UpdateTime] [datetime] NOT NULL CONSTRAINT [DF_BetSetting3rd_Member_History_UpdateTime]  DEFAULT (getdate()),
) ON [CustSetting_table]
GO
/****** Object:  Index [IX_BetSetting3rd_Member_History] ******/
CREATE CLUSTERED INDEX [IX_BetSetting3rd_Member_History] ON [dbo].[BetSetting3rd_Member_History]
(
	[UpdateTime] ASC,
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF, DATA_COMPRESSION =PAGE) ON [CustSetting_table]
GO

CREATE NONCLUSTERED INDEX [IX_BetSetting3rd_Member_History2] ON [dbo].[BetSetting3rd_Member_History]
(
	[rID] ASC,
	[SiteDBGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF, DATA_COMPRESSION =PAGE) ON [CustSetting_table]
GO
