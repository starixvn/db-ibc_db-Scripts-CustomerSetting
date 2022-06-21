/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20220523@Eden
	Task: Create new tables for Alpha - My Monitor Accounts for Risk & Control [#RedmineID:#170467]
	DB: DBCUST-CustDB and CustDB_DR_Sync publication
*/
USE CustDB
GO
DROP TABLE [dbo].[WLMonitored_Player]
GO
DROP TABLE [dbo].[WLMonitored_PersonalPreset]
GO
DROP TABLE [dbo].[WLMonitored_Global]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WLMonitored_Player](
	[CustID] [int] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[AgentID] [int] NOT NULL,
	[WinningThreshold] [money] NULL,
	[WinningUpdateTime] [datetime] NULL,
	[LosingThreshold] [money] NULL,
	[LosingUpdateTime] [datetime] NULL,
	[InitSettingTime] [datetime] NULL
	CONSTRAINT [PK_WLMonitored_Player] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[Sporttype] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO
CREATE TABLE [dbo].[WLMonitored_Global](
	[AgentID] [int] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[WinningThreshold] [money] NULL,
	[WinningUpdateTime] [datetime] NULL,
	[LosingThreshold] [money] NULL,
	[LosingUpdateTime] [datetime] NULL,
	[InitSettingTime] [datetime] NULL
	CONSTRAINT [PK_WLMonitored_Global] PRIMARY KEY CLUSTERED 
(
	[AgentID] ASC,
	[Sporttype] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO
CREATE TABLE [dbo].[WLMonitored_PersonalPreset](
	[ID] [int] NOT NULL IDENTITY(1,1) NOT FOR REPLICATION,
	[AgentID] [int] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[PresetTitle] [varchar](50) NOT NULL,
	[WinningThreshold] [money] NULL,
	[LosingThreshold] [money] NULL
	CONSTRAINT [PK_WLMonitored_PersonalPreset] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO