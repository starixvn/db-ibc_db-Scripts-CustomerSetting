/*<info serverAlias="DBAGE-bodb02"></info>*/
/*
	Created: 20240415@Eden
	Task: Create alter tables: [#201733]
		WLMonitored_Global
		WLMonitored_Player
		WLMonitored_SMA
	DB: DBAGE-bodb02
*/
USE bodb02
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WLMonitored_Global]') AND type in (N'U'))
	DROP TABLE [dbo].[WLMonitored_Global]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[WLMonitored_Global](
	[AgentID] [int] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[WinningThreshold] [money] NULL,
	[WinningUpdateTime] [datetime] NULL,
	[LosingThreshold] [money] NULL,
	[LosingUpdateTime] [datetime] NULL,
	[InitSettingTime] [datetime] NULL,
	[RepUpdateTime] [datetime2](7) NULL
 CONSTRAINT [PK_WLMonitored_Global] PRIMARY KEY CLUSTERED 
(
	[AgentID] ASC,
	[Sporttype] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO
----------
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WLMonitored_Player]') AND type in (N'U'))
DROP TABLE [dbo].[WLMonitored_Player]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[WLMonitored_Player](
	[CustID] [int] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[AgentID] [int] NOT NULL,
	[WinningThreshold] [money] NULL,
	[WinningUpdateTime] [datetime] NULL,
	[LosingThreshold] [money] NULL,
	[LosingUpdateTime] [datetime] NULL,
	[InitSettingTime] [datetime] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_WLMonitored_Player] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[Sporttype] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

----------------
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WLMonitored_SMA]') AND type in (N'U'))
DROP TABLE [dbo].[WLMonitored_SMA]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[WLMonitored_SMA](
	[CustID] [int] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[WinningThreshold] [money] NULL,
	[WinningUpdateTime] [datetime] NULL,
	[LosingThreshold] [money] NULL,
	[LosingUpdateTime] [datetime] NULL,
	[InitSettingTime] [datetime] NULL,
	[RepUpdateTime] [datetime2](7) NULL
 CONSTRAINT [PK_WLMonitored_SMA] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[Sporttype] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO