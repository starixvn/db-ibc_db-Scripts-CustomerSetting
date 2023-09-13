/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Helios
	Date: 2023/01/03
	Task: Create new Structure table SportsBook  [Redmine:#193083] 
	DB:	DBCUST-CustDB and all replicated server of pub: CustDB_CustSetting
*/


USE [CustDB]
GO

/****** Object:  Table [dbo].[CustPTSetting_Agent]    Script Date: 1/3/2024 9:14:19 AM ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CustPTSetting_Agent](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[IsAutoMasterPT] [bit] NOT NULL,
	[IsAutoSuperPT] [bit] NOT NULL,
	[SuperPT] [smallmoney] NOT NULL,
	[MasterPT] [smallmoney] NOT NULL,
	[AgentPT] [smallmoney] NOT NULL,
	[AutoSuperPT] [smallmoney] NOT NULL,
	[AutoMasterPT] [smallmoney] NOT NULL,
	[MinPT] [smallmoney] NOT NULL,
	[MaxPT] [smallmoney] NOT NULL,
 CONSTRAINT [PK_CustPTSetting_Agent] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC,
	[IsLive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CustPTSetting_Agent_Table]
) ON [CustPTSetting_Agent_Table]
GO

ALTER TABLE [dbo].[CustPTSetting_Agent] ADD  CONSTRAINT [DF_CustPTSetting_Agent_IsAutoMasterPT]  DEFAULT ((0)) FOR [IsAutoMasterPT]
GO

ALTER TABLE [dbo].[CustPTSetting_Agent] ADD  CONSTRAINT [DF_CustPTSetting_Agent_IsAutoSuperPT]  DEFAULT ((0)) FOR [IsAutoSuperPT]
GO

ALTER TABLE [dbo].[CustPTSetting_Agent] ADD  CONSTRAINT [DF_CustPTSetting_Agent_SuperPT]  DEFAULT ((0)) FOR [SuperPT]
GO

ALTER TABLE [dbo].[CustPTSetting_Agent] ADD  CONSTRAINT [DF_CustPTSetting_Agent_MasterPT]  DEFAULT ((0)) FOR [MasterPT]
GO

ALTER TABLE [dbo].[CustPTSetting_Agent] ADD  CONSTRAINT [DF_CustPTSetting_Agent_AgentPT]  DEFAULT ((0)) FOR [AgentPT]
GO

ALTER TABLE [dbo].[CustPTSetting_Agent] ADD  CONSTRAINT [DF_CustPTSetting_Agent_AutoSuperPT]  DEFAULT ((0)) FOR [AutoSuperPT]
GO

ALTER TABLE [dbo].[CustPTSetting_Agent] ADD  CONSTRAINT [DF_CustPTSetting_Agent_AutoMasterPT]  DEFAULT ((0)) FOR [AutoMasterPT]
GO

ALTER TABLE [dbo].[CustPTSetting_Agent] ADD  CONSTRAINT [DF_CustPTSetting_Agent_MinPT]  DEFAULT ((0)) FOR [MinPT]
GO

ALTER TABLE [dbo].[CustPTSetting_Agent] ADD  CONSTRAINT [DF_CustPTSetting_Agent_MaxPT]  DEFAULT ((90)) FOR [MaxPT]
GO


/****** Object:  Table [dbo].[CustPTSetting_Member]    Script Date: 1/3/2024 9:13:54 AM ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TABLE [dbo].[CustPTSetting_Member](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[IsAutoMasterPT] [bit] NOT NULL,
	[IsAutoSuperPT] [bit] NOT NULL,
	[SuperPT] [smallmoney] NOT NULL,
	[MasterPT] [smallmoney] NOT NULL,
	[AgentPT] [smallmoney] NOT NULL,
	[AutoSuperPT] [smallmoney] NOT NULL,
	[AutoMasterPT] [smallmoney] NOT NULL,
 CONSTRAINT [PK_CustPTSetting_Member] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC,
	[IsLive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CustPTSetting_Member_Table]
) ON [CustPTSetting_Member_Table]
GO

ALTER TABLE [dbo].[CustPTSetting_Member] ADD  CONSTRAINT [DF_CustPTSetting_Member_IsAutoMasterPT]  DEFAULT ((0)) FOR [IsAutoMasterPT]
GO

ALTER TABLE [dbo].[CustPTSetting_Member] ADD  CONSTRAINT [DF_CustPTSetting_Member_IsAutoSuperPT]  DEFAULT ((0)) FOR [IsAutoSuperPT]
GO

ALTER TABLE [dbo].[CustPTSetting_Member] ADD  CONSTRAINT [DF_CustPTSetting_Member_SuperPT]  DEFAULT ((0)) FOR [SuperPT]
GO

ALTER TABLE [dbo].[CustPTSetting_Member] ADD  CONSTRAINT [DF_CustPTSetting_Member_MasterPT]  DEFAULT ((0)) FOR [MasterPT]
GO

ALTER TABLE [dbo].[CustPTSetting_Member] ADD  CONSTRAINT [DF_CustPTSetting_Member_AgentPT]  DEFAULT ((0)) FOR [AgentPT]
GO

ALTER TABLE [dbo].[CustPTSetting_Member] ADD  CONSTRAINT [DF_CustPTSetting_Member_AutoSuperPT]  DEFAULT ((0)) FOR [AutoSuperPT]
GO

ALTER TABLE [dbo].[CustPTSetting_Member] ADD  CONSTRAINT [DF_CustPTSetting_Member_AutoMasterPT]  DEFAULT ((0)) FOR [AutoMasterPT]
GO



/****** Object:  Table [dbo].[CustDiscountSetting_Agent]    Script Date: 1/3/2024 9:13:54 AM ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CustDiscountSetting_Agent](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[Discount] [decimal](9, 8) NOT NULL,
 CONSTRAINT [PK_CustDiscountSetting_Agent] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CustDiscountSetting_Agent_Table]
) ON [CustDiscountSetting_Agent_Table]
GO

ALTER TABLE [dbo].[CustDiscountSetting_Agent] ADD  DEFAULT ((0)) FOR [Discount]
GO

/****** Object:  Table [dbo].[CustDiscountSetting_Member]    Script Date: 1/3/2024 9:14:19 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CustDiscountSetting_Member](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[PlayerDiscount] [decimal](9, 8) NOT NULL,
	[AgentDiscount] [decimal](9, 8) NOT NULL,
	[MasterDiscount] [decimal](9, 8) NOT NULL,
	[SuperDiscount] [decimal](9, 8) NOT NULL,
 CONSTRAINT [PK_CustDiscountSetting_Member] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [CustDiscountSetting_Member_Table]
) ON [CustDiscountSetting_Member_Table]
GO

ALTER TABLE [dbo].[CustDiscountSetting_Member] ADD  DEFAULT ((0)) FOR [PlayerDiscount]
GO

ALTER TABLE [dbo].[CustDiscountSetting_Member] ADD  DEFAULT ((0)) FOR [AgentDiscount]
GO

ALTER TABLE [dbo].[CustDiscountSetting_Member] ADD  DEFAULT ((0)) FOR [MasterDiscount]
GO

ALTER TABLE [dbo].[CustDiscountSetting_Member] ADD  DEFAULT ((0)) FOR [SuperDiscount]
GO