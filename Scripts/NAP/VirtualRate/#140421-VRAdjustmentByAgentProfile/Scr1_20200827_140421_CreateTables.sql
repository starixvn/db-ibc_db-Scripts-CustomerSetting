/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20200827@Eden
	Task: Create table VRAgentAutoAdjustment, VRAgentProfile [RM#140421]
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO
--DROP TABLE [dbo].[VRAgentAutoAdjustment]
--DROP TABLE [dbo].[VRAgentProfile]
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VRAgentAutoAdjustment](
	[AgentID] [int] NOT NULL,
	[Type] [tinyint] NOT NULL,
	[FirstBetDate] [date] NULL,
	[Status] [TINYINT] NULL
 CONSTRAINT [PK_VRAgentAutoAdjustment] PRIMARY KEY CLUSTERED 
(
	[AgentID] ASC,
	[Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [virtualrate_table]
) ON [virtualrate_table]

GO
CREATE NONCLUSTERED INDEX [IX_FirstBetDate] ON [dbo].[VRAgentAutoAdjustment]
(
	[FirstBetDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [virtualrate_table]
GO

GO
CREATE TABLE [dbo].[VRAgentProfile](
	[SiteID] [int] NOT NULL,
	[Type] [tinyint] NOT NULL,
	[AgentCredit] [MONEY] NULL,
	[AVGMemCredit] [MONEY] NULL,
	[AVGMemMaxBet] [MONEY] NULL,
	[AVGMemMaxPerMatch] [MONEY] NULL,
	[ReleaseDate] [datetime] NOT NULL
 CONSTRAINT [PK_VRAgentProfile] PRIMARY KEY CLUSTERED 
(
	[SiteID] ASC,
	[Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [virtualrate_table]
) ON [virtualrate_table]