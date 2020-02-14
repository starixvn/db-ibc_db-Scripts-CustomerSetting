/*
	Created by: Eden
	Date: 20191212
	Task: Create New tables For SB - Deposit DCS & Number Games DCS [Redmine:#123750]		
	DB: DBCUST/CustDB
	Replication : add to CustDB_Custsetting publication
*/
USE [CustDB]
GO
DROP TABLE [dbo].[DSB_CustBetSetting_Member]
GO

DROP TABLE [dbo].[DSB_CustBetSetting_Agent]
GO

DROP TABLE [dbo].[DSB_CustGroupBetSetting_Member]
GO

DROP TABLE [dbo].[DSB_CustDiscount_Agent]
GO

DROP TABLE [dbo].[DSB_CustDiscount_Member]
GO

DROP TABLE [dbo].[DSB_CustGroupDiscount_Member]
GO

DROP TABLE [dbo].[DSB_CustPTSetting_Agent]
GO

DROP TABLE [dbo].[DSB_CustPTSetting_Member]
GO

DROP TABLE [dbo].[DSB_CustPTGroupSetting_Member]
GO

DROP TABLE [dbo].[DSB_CustSettingMode]
GO

DROP TABLE [dbo].[DSB_ProductSetting]
GO

DROP TABLE [dbo].[DSB_ProductSettingDetail]
GO

DROP TABLE [dbo].[DSB_ByteSeq]
GO

DROP TABLE [dbo].[CommissionTemplate]
GO

DROP TABLE [dbo].[PositionTakingTemplate]
GO

DROP TABLE [dbo].[Dep_CustBetSettingGame_Agent]
GO

DROP TABLE [dbo].[Dep_CustBetSettingGame_Member]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

----> BET SETTING
CREATE TABLE [dbo].[DSB_CustBetSetting_Member](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL DEFAULT ((0)),
	[MaxBet] [money] NULL DEFAULT ((0)),
	[MaxPerMatch] [money] NULL DEFAULT ((0)),
	CONSTRAINT [PK_DSB_CustBetSetting_Member] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DSB_CustBetSetting_table]
) ON [DSB_CustBetSetting_table]

GO

CREATE TABLE [dbo].[DSB_CustBetSetting_Agent](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL DEFAULT ((0)),
	[MaxBet] [money] NULL DEFAULT ((0)),
	[MaxPerMatch] [money] NULL DEFAULT ((0)),
	CONSTRAINT [PK_DSB_CustBetSetting_Agent] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DSB_CustBetSetting_table]
) ON [DSB_CustBetSetting_table]

GO

CREATE TABLE [dbo].[DSB_CustGroupBetSetting_Member](
	[AgentID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL DEFAULT ((0)),
	[MaxBet] [money] NULL DEFAULT ((0)),
	[MaxPerMatch] [money] NULL DEFAULT ((0)),
	CONSTRAINT [PK_DSB_CustGroupBetSetting_Member] PRIMARY KEY CLUSTERED 
(
	[AgentID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DSB_CustBetSetting_table]
) ON [DSB_CustBetSetting_table]

GO

--> Commission
CREATE TABLE [dbo].[DSB_CustDiscount_Agent](
	[CustId] [int] NOT NULL,
	[Discount] [binary](30) NOT NULL,
	CONSTRAINT [PK_DSB_CustDiscount_Agent] PRIMARY KEY CLUSTERED 
(
	[CustId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DSB_CustDiscountSetting_table]
) ON [DSB_CustDiscountSetting_table]

GO

CREATE TABLE [dbo].[DSB_CustDiscount_Member](
	[CustId] [int] NOT NULL,
	[PlayerDiscount] [binary](30) NOT NULL,
	[AgentDiscount] [binary](30) NOT NULL,
	[MasterDiscount] [binary](30) NOT NULL,
	[SuperDiscount] [binary](30) NOT NULL,
	CONSTRAINT [PK_DSB_CustDiscount_Member] PRIMARY KEY CLUSTERED 
(
	[CustId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DSB_CustDiscountSetting_table]
) ON [DSB_CustDiscountSetting_table]

GO

CREATE TABLE [dbo].[DSB_CustGroupDiscount_Member](
	[AgentId] [int] NOT NULL,
	[PlayerDiscount] [binary](30) NOT NULL,
	[AgentDiscount] [binary](30) NOT NULL,
	[MasterDiscount] [binary](30) NOT NULL,
	[SuperDiscount] [binary](30) NOT NULL,
	CONSTRAINT [PK_DSB_CustGroupDiscount_Member] PRIMARY KEY CLUSTERED 
(
	[AgentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DSB_CustDiscountSetting_table]
) ON [DSB_CustDiscountSetting_table]

GO

--> PT
CREATE TABLE [dbo].[DSB_CustPTSetting_Agent](
	[CustId] [int] NOT NULL,
	[SuperPT] [binary](10) NULL,
	[MasterPT] [binary](10) NULL,
	[AgentPT] [binary](10) NULL,
	CONSTRAINT [PK_DSB_CustPTSetting_Agent] PRIMARY KEY CLUSTERED 
(
	[CustId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DSB_CustPTSetting_table]
) ON [DSB_CustPTSetting_table]

GO

CREATE TABLE [dbo].[DSB_CustPTSetting_Member](
	[CustId] [int] NOT NULL,
	[SuperPT] [binary](10) NULL,
	[MasterPT] [binary](10) NULL,
	[AgentPT] [binary](10) NULL,
	CONSTRAINT [PK_DSB_CustPTSetting_Member] PRIMARY KEY CLUSTERED 
(
	[CustId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DSB_CustPTSetting_table]
) ON [DSB_CustPTSetting_table]

GO

CREATE TABLE [dbo].[DSB_CustPTGroupSetting_Member](
	[AgentID] [int] NOT NULL,
	[SuperPT] [binary](10) NULL,
	[MasterPT] [binary](10) NULL,
	[AgentPT] [binary](10) NULL,
	CONSTRAINT [PK_DSB_CustPTGroupSetting_Member] PRIMARY KEY CLUSTERED 
(
	[AgentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DSB_CustPTSetting_table]
) ON [DSB_CustPTSetting_table]

GO

--> Setting
CREATE TABLE [dbo].[DSB_CustSettingMode](
	[CustID] [int] NOT NULL,
	[IsGroupedPT] [bit] NOT NULL DEFAULT ((0)),
	[IsGroupedComm] [bit] NOT NULL DEFAULT ((0)),
	[IsGroupedBetLimit] [bit] NOT NULL  DEFAULT ((0)),
	CONSTRAINT [PK_DSB_CustSettingMode] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DSB_CustSettingMode_table]
) ON [DSB_CustSettingMode_table]

GO

CREATE TABLE [dbo].[DSB_ProductSetting](
	[ProductSettingID] [int] NOT NULL,
	[ProductID] [smallint] NOT NULL,
	[SettingType] [tinyint] NOT NULL,
	[TemplateID] [tinyint] NOT NULL DEFAULT ((0)),
	[DisplayOrder] [tinyint] NOT NULL,
	[SettingLevel] [tinyint] NOT NULL,
	CONSTRAINT [PK_DSB_ProductSetting] PRIMARY KEY CLUSTERED 
(
	[ProductSettingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO
	
CREATE TABLE [dbo].[DSB_ProductSettingDetail](
	[ProductSettingID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[DisplayOrder] [tinyint] NOT NULL,
	[MaxDefaultValue] [decimal](19, 8) NULL DEFAULT ((0)),
	[SettingStatus] [tinyint] NULL,
	[MinDefaultValue] [decimal](19, 8) NULL
	CONSTRAINT [PK_DSB_ProductSettingDetail] PRIMARY KEY CLUSTERED 
(
	[ProductSettingID] ASC,
	[SportType] ASC,
	[BetType] ASC,
	[IsLive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

CREATE TABLE [dbo].[DSB_ByteSeq](
	[Type] [varchar](50) NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[ByteOrder] [smallint] NOT NULL,
	CONSTRAINT [PK_DSB_ByteSeq] PRIMARY KEY CLUSTERED 
(
	[Type] ASC,
	[SportType] ASC,
	[BetType] ASC,
	[IsLive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

CREATE TABLE [dbo].[CommissionTemplate](
	[ValueId] [smallint] NOT NULL,
	[Value] [decimal](9, 8) NOT NULL,
	CONSTRAINT [PK_CommissionTemplate] PRIMARY KEY CLUSTERED 
(
	[ValueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

CREATE TABLE [dbo].[PositionTakingTemplate](
	[ValueId] [tinyint] NOT NULL,
	[Value] [smallmoney] NOT NULL,
	CONSTRAINT [PK_PositionTakingTemplate] PRIMARY KEY CLUSTERED 
(
	[ValueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

--> Bet setting table for Number games
CREATE TABLE [dbo].[Dep_CustBetSettingGame_Member](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL DEFAULT ((0)),
	[MaxBet] [money] NULL DEFAULT ((0)),
	[MaxPerMatch] [money] NULL DEFAULT ((0)),
	[MaxPerBall] [money] NULL DEFAULT ((0)),
	CONSTRAINT [PK_Dep_CustBetSettingGame_Member] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustBetSetting_Member_table]
) ON [Dep_CustBetSetting_Member_table]

GO

CREATE TABLE [dbo].[Dep_CustBetSettingGame_Agent](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL DEFAULT ((0)),
	[MaxBet] [money] NULL DEFAULT ((0)),
	[MaxPerMatch] [money] NULL DEFAULT ((0)),
	[MaxPerBall] [money] NULL DEFAULT ((0)),
	CONSTRAINT [PK_Dep_CustBetSettingGame_Agent] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustBetSetting_Agent_table]
) ON [Dep_CustBetSetting_Agent_table]

GO