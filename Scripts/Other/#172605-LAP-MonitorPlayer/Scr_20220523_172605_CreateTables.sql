/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20220523@Eden
	Task: Create new tables for LAP - Player Segmentation - Monitored Player [#RedmineID:#172605]
	DB: DBCUST-CustDB and CustDB_DR_Sync publication
*/
USE CustDB
GO
DROP TABLE [dbo].[Dep_WLMonitored_Player]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Dep_WLMonitored_Player](
	[CustID] [int] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[WinningThreshold] [money] NULL,
	[WinningUpdateTime] [datetime] NULL,
	[WinningUpdateType] [tinyint] NULL
	CONSTRAINT [PK_Dep_WLMonitored_Player] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[Sporttype] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO