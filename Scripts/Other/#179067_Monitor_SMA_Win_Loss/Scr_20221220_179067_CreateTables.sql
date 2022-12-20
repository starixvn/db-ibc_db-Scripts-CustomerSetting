/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221220@Eden
	Task: Create new tables for Monitor SMA Win Loss [#RedmineID:#179067]
	DB: DBCUST-CustDB and CustDB_DR_Sync publication
*/
USE CustDB
GO
DROP TABLE [dbo].[WLMonitored_SMA]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WLMonitored_SMA](
	[CustID] [int] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[WinningThreshold] [money] NULL,
	[WinningUpdateTime] [datetime] NULL,
	[LosingThreshold] [money] NULL,
	[LosingUpdateTime] [datetime] NULL,
	[InitSettingTime] [datetime] NULL
	CONSTRAINT [PK_WLMonitored_SMA] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[Sporttype] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
