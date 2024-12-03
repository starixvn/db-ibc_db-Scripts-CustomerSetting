/*<info serverAlias="DBCUST-CustDB_History"></info>*/
/*
	Created: 20240718@Johnson
	Task: Add deposit history tables [redmine:#207025]
	DB: DBCUST/CustDB_History
*/

USE CustDB_History
GO
ALTER DATABASE [CustDB_History] ADD FILEGROUP [Dep_CustSetting_table] 
GO
ALTER DATABASE [CustDB_History] ADD FILE 
( NAME = N'Dep_CustSetting_table01', FILENAME = N'/mnt/DiskG/CustDB_History/Dep_CustSetting_table01.ndf' , SIZE = 4096MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB ), 
( NAME = N'Dep_CustSetting_table02', FILENAME = N'/mnt/DiskG/CustDB_History/Dep_CustSetting_table02.ndf' , SIZE = 4096MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB ), 
( NAME = N'Dep_CustSetting_table03', FILENAME = N'/mnt/DiskG/CustDB_History/Dep_CustSetting_table03.ndf' , SIZE = 4096MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB )
TO FILEGROUP [Dep_CustSetting_table]
GO

CREATE TABLE [dbo].[Dep_CustBetSetting_Agent_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[UpdateTime] [datetime] NOT NULL CONSTRAINT [DF_Dep_CustBetSetting_Agent_UpdateTime]  DEFAULT (getdate()),
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL CONSTRAINT [DF_Dep_CustBetSetting_Agent_MinBet]  DEFAULT ((0)),
	[MaxBet] [money] NULL CONSTRAINT [DF_Dep_CustBetSetting_Agent_MaxBet]  DEFAULT ((0)),
	[MaxPerMatch] [money] NULL CONSTRAINT [DF_Dep_CustBetSetting_Agent_MaxPerMatch]  DEFAULT ((0)),
CONSTRAINT [PK_Dep_CustBetSetting_Agent_History] PRIMARY KEY CLUSTERED 
(
	[rID] ASC
)		
) ON [Dep_CustSetting_table]

GO

CREATE TABLE [dbo].[Dep_CustBetSetting_Member_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[UpdateTime] [datetime] NOT NULL CONSTRAINT [DF_Dep_CustBetSetting_Member_UpdateTime]  DEFAULT (getdate()),
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL CONSTRAINT [DF_Dep_CustBetSetting_Member_MinBet]  DEFAULT ((0)),
	[MaxBet] [money] NULL CONSTRAINT [DF_Dep_CustBetSetting_Member_MaxBet]  DEFAULT ((0)),
	[MaxPerMatch] [money] NULL CONSTRAINT [DF_Dep_CustBetSetting_Member_MaxPerMatch]  DEFAULT ((0)),
CONSTRAINT [PK_Dep_CustBetSetting_Member_History] PRIMARY KEY CLUSTERED 
(
	[rID] ASC
)	
) ON [Dep_CustSetting_table]

GO

CREATE TABLE [dbo].[Dep_CustBetSettingGame_Agent_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[MaxPerNumber] [money] NULL,
	[MaxPayoutPerMatch] [money] NULL,
	[IsInserted] [bit] NULL,
	[UpdateTime] [datetime] NOT NULL CONSTRAINT [DF_Dep_CustBetSettingGame_Agent_History_UpdateTime]  DEFAULT (getdate()),
CONSTRAINT [PK_Dep_CustBetSettingGame_Agent_History] PRIMARY KEY CLUSTERED 
(
	[rID] ASC
)		
) ON [Dep_CustSetting_table]

GO

CREATE TABLE [dbo].[Dep_CustBetSettingGame_Member_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[MaxPerNumber] [money] NULL,
	[MaxPayoutPerMatch] [money] NULL,
	[IsInserted] [bit] NULL,
	[UpdateTime] [datetime] NOT NULL CONSTRAINT [DF_Dep_CustBetSettingGame_Member_History_UpdateTime]  DEFAULT (getdate()),
CONSTRAINT [PK_Dep_CustBetSettingGame_Member_History] PRIMARY KEY CLUSTERED 
(
	[rID] ASC
)			
) ON [Dep_CustSetting_table]

GO

CREATE TABLE [dbo].[Dep_CustBetSettingGameGroup_Member_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[AgentID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[MaxPerNumber] [money] NULL,
	[MaxPayoutPerMatch] [money] NULL,
	[IsInserted] [bit] NULL,
	[UpdateTime] [datetime] NOT NULL CONSTRAINT [DF_Dep_CustBetSettingGameGroup_Member_History_UpdateTime]  DEFAULT (getdate()),
CONSTRAINT [PK_Dep_CustBetSettingGameGroup_Member_History] PRIMARY KEY CLUSTERED 
(
	[rID] ASC
)		
) ON [Dep_CustSetting_table]

GO

CREATE TABLE [dbo].[Dep_CustDiscountGroupSetting_Member_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[UpdateTime] [datetime] NOT NULL CONSTRAINT [DF_Dep_CustDiscountGroupSetting_Member_History]  DEFAULT (getdate()),
	[AgentID] [int] NOT NULL,
	[SportType] [smallint] NULL,
	[BetType] [smallint] NULL,
	[PlayerDiscount] [decimal](9, 8) NULL,
	[AgentDiscount] [decimal](9, 8) NULL,
	[MasterDiscount] [decimal](9, 8) NULL,
	[SuperDiscount] [decimal](9, 8) NULL,
CONSTRAINT [PK_Dep_CustDiscountGroupSetting_Member_History] PRIMARY KEY CLUSTERED 
(
	[rID] ASC
)		
) ON [Dep_CustSetting_table]

GO

CREATE TABLE [dbo].[Dep_CustDiscountSetting_Agent_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[UpdateTime] [datetime] NOT NULL CONSTRAINT [DF_Dep_CustDiscountSetting_Agent_History_UpdateTime]  DEFAULT (getdate()),
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[Discount] [decimal](9, 8) NOT NULL CONSTRAINT [DF_Dep_CustDiscountSetting_Agent_History_Discount]  DEFAULT (0),
CONSTRAINT [PK_Dep_CustDiscountSetting_Agent_History] PRIMARY KEY CLUSTERED 
(
	[rID] ASC
)	
) ON [Dep_CustSetting_table]

GO

CREATE TABLE [dbo].[Dep_CustDiscountSetting_Member_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[UpdateTime] [datetime] NOT NULL CONSTRAINT [DF_Dep_CustDiscountSetting_Member_History_UpdateTime]  DEFAULT (getdate()),
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NULL,
	[BetType] [smallint] NULL,
	[PlayerDiscount] [decimal](9, 8) NULL,
	[AgentDiscount] [decimal](9, 8) NULL,
	[MasterDiscount] [decimal](9, 8) NULL,
	[SuperDiscount] [decimal](9, 8) NULL,
CONSTRAINT [PK_Dep_CustDiscountSetting_Member_History] PRIMARY KEY CLUSTERED 
(
	[rID] ASC
)	
) ON [Dep_CustSetting_table]

GO

CREATE TABLE [dbo].[Dep_CustProductStatus_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[UpdateTime] [datetime] NOT NULL CONSTRAINT [DF_Dep_CustProductStatus_History_UpdateTime]  DEFAULT (getdate()),
	[CustID] [int] NOT NULL,
	[bitmapIsHidden] [binary](32) NOT NULL CONSTRAINT [DF_Dep_CustPRoductStatus_bitmapIsHidden]  DEFAULT (0x00),
	[bitmapIsDisabled] [binary](32) NOT NULL CONSTRAINT [DF_Dep_CustPRoductStatus_bitmapIsDisabled]  DEFAULT (0x00),
CONSTRAINT [PK_Dep_CustProductStatus_History] PRIMARY KEY CLUSTERED 
(
	[rID] ASC
)	
) ON [Dep_CustSetting_table]

GO

CREATE TABLE [dbo].[Dep_CustPTGroupSetting_Member_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[UpdateTime] [datetime] NOT NULL CONSTRAINT [DF_CustPTGroupSetting_Member_History_UpdateTime]  DEFAULT (getdate()),
	[AgentID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[SuperPT] [smallmoney] NULL CONSTRAINT [DF_Dep_CustPTGroupSetting_Member_History_SuperPT]  DEFAULT ((0)),
	[MasterPT] [smallmoney] NULL CONSTRAINT [DF_Dep_CustPTGroupSetting_Member_History_MasterPT]  DEFAULT ((0)),
	[AgentPT] [smallmoney] NULL CONSTRAINT [DF_Dep_CustPTGroupSetting_Member_History_AgentPT]  DEFAULT ((0)),
CONSTRAINT [PK_Dep_CustPTGroupSetting_Member_History] PRIMARY KEY CLUSTERED 
(
	[rID] ASC
)		
) ON [Dep_CustSetting_table]

GO

CREATE TABLE [dbo].[Dep_CustPTSetting_Member_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[UpdateTime] [datetime] NOT NULL CONSTRAINT [DF_Dep_CustPTSetting_Member_History_UpdateTime]  DEFAULT (getdate()),
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[SuperPT] [smallmoney] NULL CONSTRAINT [DF_Dep_CustPTSetting_Member_History_SuperPT]  DEFAULT ((0)),
	[MasterPT] [smallmoney] NULL CONSTRAINT [DF_Dep_CustPTSetting_Member_History_MasterPT]  DEFAULT ((0)), 
	[AgentPT] [smallmoney] NULL CONSTRAINT [DF_Dep_CustPTSetting_Member_History_AgentPT]  DEFAULT ((0)),
CONSTRAINT [PK_Dep_CustPTSetting_Member_History] PRIMARY KEY CLUSTERED 
(
	[rID] ASC
)		
) ON [Dep_CustSetting_table]

GO

CREATE TABLE [dbo].[Dep_CustPTSetting_Agent_History](
	[rID] [bigint] IDENTITY(1,1) NOT NULL,
	[UpdateTime] [datetime] NOT NULL CONSTRAINT [DF_Dep_CustPTSetting_Agent_history_UpdateTime]  DEFAULT (getdate()),
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[SuperPT] [smallmoney] NULL CONSTRAINT [DF_Dep_CustPTSetting_Agent_history_SuperPT]  DEFAULT ((0)),
	[MasterPT] [smallmoney] NULL CONSTRAINT [DF_Dep_CustPTSetting_Agent_history_MasterPT]  DEFAULT ((0)),
	[AgentPT] [smallmoney] NULL CONSTRAINT [DF_Dep_CustPTSetting_Agent_history_AgentPT]  DEFAULT ((0)),
CONSTRAINT [PK_Dep_CustPTSetting_Agent_History] PRIMARY KEY CLUSTERED 
(
	[rID] ASC
)	
) ON [Dep_CustSetting_table]

GO

CREATE TABLE [dbo].[Dep_CustSettingGame_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[UpdateTime] [datetime] NOT NULL CONSTRAINT [Dep_CustSettingGame_History_UpdateTime]  DEFAULT (getdate()),
	[CustID] [int] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[apositiontaking] [smallmoney] NOT NULL CONSTRAINT [Dep_CustSettingGame_History_apositiontaking]  DEFAULT ((0)),
	[mpositiontaking] [smallmoney] NOT NULL CONSTRAINT [Dep_CustSettingGame_History_mpositiontaking]  DEFAULT ((0)),
	[spositiontaking] [smallmoney] NOT NULL CONSTRAINT [Dep_CustSettingGame_History_spositiontaking]  DEFAULT ((0)),
	[playerdiscount] [decimal](9, 8) NOT NULL CONSTRAINT [Dep_CustSettingGame_History_playerdiscount]  DEFAULT ((0)),
	[discount] [decimal](9, 8) NOT NULL CONSTRAINT [Dep_CustSettingGame_History_discount]  DEFAULT ((0)),
	[adiscount] [decimal](9, 8) NOT NULL CONSTRAINT [Dep_CustSettingGame_History_adiscount]  DEFAULT ((0)),
	[sdiscount] [decimal](9, 8) NOT NULL CONSTRAINT [Dep_CustSettingGame_History_sdiscount]  DEFAULT ((0)),
CONSTRAINT [PK_Dep_CustSettingGame_History] PRIMARY KEY CLUSTERED 
(
	[rID] ASC
)
) ON [Dep_CustSetting_table]

GO

CREATE TABLE [dbo].[Dep_CustSettingMode_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[UpdateTime] [datetime] NOT NULL CONSTRAINT [DF_Dep_CustSettingMode_History_UpdateTime]  DEFAULT (getdate()),
	[CustID] [int] NOT NULL,
	[IsGroupedPT] [bit] NOT NULL CONSTRAINT [DF_Dep_CustSettingMode_History_IsGroupedPT] DEFAULT ((0)),
	[IsGroupedComm] [bit] NOT NULL CONSTRAINT [DF_Dep_CustSettingMode_History_IsGroupedComm] DEFAULT ((0)),
	[IsGroupedBetLimit] [bit] NOT NULL CONSTRAINT [DF_Dep_CustSettingMode_History_IsGroupedBetLimit] DEFAULT ((0)),
	[IsGroupedStakeLevel] [bit] NOT NULL CONSTRAINT [DF_Dep_CustSettingMode_History_IsGroupedStakeLevel] DEFAULT ((0)),
CONSTRAINT [PK_Dep_CustSettingMode_History] PRIMARY KEY CLUSTERED 
(
	[rID] ASC
)
) ON [Dep_CustSetting_table]

GO

CREATE TABLE [dbo].[Dep_CustStakeLevel_Agent_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[UpdateTime] [datetime] NOT NULL CONSTRAINT [DF_Dep_CustStakeLevel_Agent_History_UpdateTime]  DEFAULT (getdate()),
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[StakeLevelList] [varchar](200) NULL,
CONSTRAINT [PK_Dep_CustStakeLevel_Agent_History] PRIMARY KEY CLUSTERED 
(
	[rID] ASC
)	
) ON [Dep_CustSetting_table]

GO


CREATE TABLE [dbo].[Dep_CustStakeLevel_Member_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[UpdateTime] [datetime] NOT NULL CONSTRAINT [DF_Dep_CustStakeLevel_Member_History_UpdateTime]  DEFAULT (getdate()),
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[StakeLevelList] [varchar](200) NULL,
	[LastUpdated] [datetime] NULL,
CONSTRAINT [PK_Dep_CustStakeLevel_Member_History] PRIMARY KEY CLUSTERED 
(
	[rID] ASC
)	
) ON [Dep_CustSetting_table]

GO

