/*<info serverAlias="DBCustRepl-ReplCustDB"></info>*/
/*
	Created: 20240627@Johnson
	Task: Scale out dbcust for deposit settings [redmine: #207025]
	DB: DBCustRepl-ReplCustDB
*/ 
-------------------------------------------------------
--Dep_CustBAActive
CREATE TABLE [dbo].[Dep_CustBAActive](
	[CustId] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_CustBAActive_RepUpdateTime]  DEFAULT (sysdatetime()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_CustBAActive] PRIMARY KEY CLUSTERED 
(
	[CustId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

-------------------------------------------------------
--Dep_CustBetLimit_Special
CREATE TABLE [dbo].[Dep_CustBetLimit_Special](
	[Site] [varchar](10) NOT NULL,
	[CurrencyID] [int] NOT NULL,
	[SportType] [int] NOT NULL,
	[AgentID] [int] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[MaxPerBall] [money] NULL,
	[Bettype] [int] NOT NULL,
	[Keyid] [int] NOT NULL,
	[MaxPayoutPerMatch] [money] NULL,
	[MinBet] [money] NULL,
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_CustBetLimit_Special_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_CustBetLimit_Special] PRIMARY KEY NONCLUSTERED 
(
	[Keyid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

-------------------------------------------------------
--Dep_CustBetSetting_Agent
CREATE TABLE [dbo].[Dep_CustBetSetting_Agent](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL CONSTRAINT [DF_Dep_CustBetSetting_Agent_MinBet]  DEFAULT (0),
	[MaxBet] [money] NULL CONSTRAINT [DF_Dep_CustBetSetting_Agent_MaxBet]  DEFAULT (0),
	[MaxPerMatch] [money] NULL CONSTRAINT [DF_Dep_CustBetSetting_Agent_MPM]  DEFAULT (0),
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_CustBetSetting_Agent_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_CustBetSetting_Agent] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustBetSetting_Agent_table]
) ON [Dep_CustBetSetting_Agent_table]

GO
-------------------------------------------------------
--Dep_CustBetSetting_Member
CREATE TABLE [dbo].[Dep_CustBetSetting_Member](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL CONSTRAINT [DF_Dep_CustBetSetting_Member_MinBet]  DEFAULT (0),
	[MaxBet] [money] NULL CONSTRAINT [DF_Dep_CustBetSetting_Member_MaxBet]  DEFAULT (0),
	[MaxPerMatch] [money] NULL CONSTRAINT [DF_Dep_CustBetSetting_Member_MPM]  DEFAULT (0),
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_CustBetSetting_Member_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_CustBetSetting_Member] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustBetSetting_Member_table]
) ON [Dep_CustBetSetting_Member_table]

GO

-------------------------------------------------------
--Dep_CustBetSettingGame_Agent
CREATE TABLE [dbo].[Dep_CustBetSettingGame_Agent](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL CONSTRAINT [DF_Dep_CustBetSettingGame_Agent_MinBet]  DEFAULT ((0)),
	[MaxBet] [money] NULL CONSTRAINT [DF_Dep_CustBetSettingGame_Agent_MaxBet]  DEFAULT ((0)),
	[MaxPerMatch] [money] NULL CONSTRAINT [DF_Dep_CustBetSettingGame_Agent_MPM]  DEFAULT ((0)),
	[MaxPerNumber] [money] NULL CONSTRAINT [DF_Dep_CustBetSettingGame_Agent_MPN]  DEFAULT ((0)),
	[MaxPayoutPerMatch] [money] NULL CONSTRAINT [DF_Dep_CustBetSettingGame_Agent_MPPM]  DEFAULT ((0)),
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_CustBetSettingGame_Agent_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_CustBetSettingGame_Agent] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustBetSetting_Agent_table]
) ON [Dep_CustBetSetting_Agent_table]

GO
-------------------------------------------------------
--Dep_CustBetSettingGame_Member
CREATE TABLE [dbo].[Dep_CustBetSettingGame_Member](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL CONSTRAINT [DF_Dep_CustBetSettingGame_Member_MinBet]  DEFAULT ((0)),
	[MaxBet] [money] NULL CONSTRAINT [DF_Dep_CustBetSettingGame_Member_MaxBet]  DEFAULT ((0)),
	[MaxPerMatch] [money] NULL CONSTRAINT [DF_Dep_CustBetSettingGame_Member_MPM]  DEFAULT ((0)),
	[MaxPerNumber] [money] NULL CONSTRAINT [DF_Dep_CustBetSettingGame_Member_MPN]  DEFAULT ((0)),
	[MaxPayoutPerMatch] [money] NULL CONSTRAINT [DF_Dep_CustBetSettingGame_Member_MPPM]  DEFAULT ((0)),
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_CustBetSettingGame_Member_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_CustBetSettingGame_Member] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustBetSetting_Member_table]
) ON [Dep_CustBetSetting_Member_table]
GO

-------------------------------------------------------
--Dep_CustDiscountSetting_Agent
CREATE TABLE [dbo].[Dep_CustDiscountSetting_Agent](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[Discount] [decimal](9, 8) NOT NULL CONSTRAINT [DF_Dep_CustDiscountSetting_Agent_Discount]  DEFAULT ((0)),
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_CustDiscountSetting_Agent_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_CustDiscountSetting_Agent] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustDiscountSetting_Agent_table]
) ON [Dep_CustDiscountSetting_Agent_table]
GO

-------------------------------------------------------
--Dep_CustDiscountSetting_Member
CREATE TABLE [dbo].[Dep_CustDiscountSetting_Member](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[PlayerDiscount] [decimal](9, 8) NULL CONSTRAINT [DF_Dep_CustDiscountSetting_Member_PlayerDiscount]  DEFAULT ((0)),
	[AgentDiscount] [decimal](9, 8) NULL CONSTRAINT [DF_Dep_CustDiscountSetting_Member_AgentDiscount]  DEFAULT ((0)),
	[MasterDiscount] [decimal](9, 8) NULL CONSTRAINT [DF_Dep_CustDiscountSetting_Member_MasterDiscount]  DEFAULT ((0)),
	[SuperDiscount] [decimal](9, 8) NULL CONSTRAINT [DF_Dep_CustDiscountSetting_Member_SuperDiscount]  DEFAULT ((0)),
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_CustDiscountSetting_Member_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_CustDiscountSetting_Member] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustDiscount_Member_Table]
) ON [Dep_CustDiscount_Member_Table]
GO

-------------------------------------------------------
--Dep_Customer_Archived
CREATE TABLE [dbo].[Dep_Customer_Archived](
	[CustID] [int] NOT NULL,
	[ArchivedDate] [datetime] NULL,
	[Username] [varchar](50) NULL,
	[Username2] [varchar](50) NULL,
	[Recommend] [int] NULL,
	[ClosingBalance] [money] NULL,
	[CustIDBalanceDummy] [int] NULL,
	[Status] [varchar](50) NULL,
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_Customer_Archived_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_CustID] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [table_customer]
) ON [table_customer]
GO

-------------------------------------------------------
--Dep_CustomerClass
CREATE TABLE [dbo].[Dep_CustomerClass](
	[CustID] [int] NOT NULL,
	[CustomerClass] [smallint] NOT NULL,
	[CategoryID] [smallint] NULL,
	[ModifiedDate] [datetime] NULL,
	[OldCustomerClass] [smallint] NULL,
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_CustomerClass_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_CustomerClass] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

-------------------------------------------------------
--Dep_CustProductSetting
CREATE TABLE [dbo].[Dep_CustProductSetting](
	[CustID] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[IsEnabled] [bit] NULL,
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_CustProductSetting_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_CustProductSetting] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO
-------------------------------------------------------
--Dep_CustProductStatus
CREATE TABLE [dbo].[Dep_CustProductStatus](
	[CustID] [int] NOT NULL,
	[bitmapIsHidden] [binary](32) NOT NULL CONSTRAINT [DF_Dep_CustPRoductStatus_bitmapIsHidden]  DEFAULT (0x00),
	[bitmapIsDisabled] [binary](32) NOT NULL CONSTRAINT [DF_Dep_CustPRoductStatus_bitmapIsDisabled]  DEFAULT (0x00),
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_CustProductStatus_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [CIX_Dep_CustProductStatus_custid] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [table_customer]
) ON [table_customer]

GO
-------------------------------------------------------
--Dep_CustPTGroupSetting_Member
CREATE TABLE [dbo].[Dep_CustPTGroupSetting_Member](
	[AgentID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[SuperPT] [smallmoney] NULL CONSTRAINT [DF_Dep_CustPTGroupSetting_Member_SuperPT]  DEFAULT ((0)),
	[MasterPT] [smallmoney] NULL CONSTRAINT [DF_Dep_CustPTGroupSetting_Member_MasterPT]  DEFAULT ((0)),
	[AgentPT] [smallmoney] NULL CONSTRAINT [DF_Dep_CustPTGroupSetting_Member_AgentPT]  DEFAULT ((0)),
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_CustPTGroupSetting_Member_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_CustPTGroupSetting_Member] PRIMARY KEY CLUSTERED 
(
	[AgentID] ASC,
	[SportType] ASC,
	[BetType] ASC,
	[IsLive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustPTSetting_table]
) ON [Dep_CustPTSetting_table]
GO

-------------------------------------------------------
--Dep_CustPTSetting_Agent
CREATE TABLE [dbo].[Dep_CustPTSetting_Agent](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[SuperPT] [smallmoney] NULL CONSTRAINT [DF_Dep_CustPTSetting_Agent_SuperPT]  DEFAULT ((0)),
	[MasterPT] [smallmoney] NULL CONSTRAINT [DF_Dep_CustPTSetting_Agent_MasterPT]  DEFAULT ((0)),
	[AgentPT] [smallmoney] NULL CONSTRAINT [DF_Dep_CustPTSetting_Agent_AgentPT]  DEFAULT ((0)),
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_CustPTSetting_Agent_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_CustPTSetting_Agent] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC,
	[IsLive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustPTSetting_table]
) ON [Dep_CustPTSetting_table]

GO
-------------------------------------------------------
--Dep_CustPTSetting_Member
CREATE TABLE [dbo].[Dep_CustPTSetting_Member](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[SuperPT] [smallmoney] NULL CONSTRAINT [DF_Dep_CustPTSetting_Member_SuperPT]  DEFAULT ((0)),
	[MasterPT] [smallmoney] NULL CONSTRAINT [DF_Dep_CustPTSetting_Member_MasterPT]  DEFAULT ((0)),
	[AgentPT] [smallmoney] NULL CONSTRAINT [DF_Dep_CustPTSetting_Member_AgentPT]  DEFAULT ((0)),
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_CustPTSetting_Member_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_CustPTSetting_Member] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC,
	[IsLive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustPTSetting_table]
) ON [Dep_CustPTSetting_table]
GO

-------------------------------------------------------
--Dep_CustSetting_AGCasino
CREATE TABLE [dbo].[Dep_CustSetting_AGCasino](
	[CustID] [int] NOT NULL,
	[AGGroup] [varchar](20) NULL,
	[IsEnabled] [bit] NULL,
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_CustSetting_AGCasino_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_CustSetting_AGCasino] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustSettingGame_Table]
) ON [Dep_CustSettingGame_Table]

GO
-------------------------------------------------------
--Dep_CustSettingGame
CREATE TABLE [dbo].[Dep_CustSettingGame](
	[CustID] [int] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[apositiontaking] [smallmoney] NOT NULL CONSTRAINT [DF_Dep_CustSettingGame_apositiontaking]  DEFAULT ((0)),
	[mpositiontaking] [smallmoney] NOT NULL CONSTRAINT [DF_Dep_CustSettingGame_mpositiontaking]  DEFAULT ((0)),
	[spositiontaking] [smallmoney] NOT NULL CONSTRAINT [DF_Dep_CustSettingGame_spositiontaking]  DEFAULT ((0)),
	[playerdiscount] [decimal](9, 8) NOT NULL CONSTRAINT [DF_Dep_CustSettingGame_playerdiscount]  DEFAULT ((0)),
	[discount] [decimal](9, 8) NOT NULL CONSTRAINT [DF_Dep_CustSettingGame_discount]  DEFAULT ((0)),
	[adiscount] [decimal](9, 8) NOT NULL CONSTRAINT [DF_Dep_CustSettingGame_adiscount]  DEFAULT ((0)),
	[sdiscount] [decimal](9, 8) NOT NULL CONSTRAINT [DF_Dep_CustSettingGame_sdiscount]  DEFAULT ((0)),
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_CustSettingGame_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_CustSettingGame] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[Bettype] ASC,
	[Sporttype] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustSettingGame_Table]
) ON [Dep_CustSettingGame_Table]

GO
-------------------------------------------------------
--Dep_CustSettingMode
CREATE TABLE [dbo].[Dep_CustSettingMode](
	[CustID] [int] NOT NULL,
	[IsGroupedPT] [bit] NOT NULL CONSTRAINT [DF_Dep_CustSettingMode_IsGroupedPT]  DEFAULT ((0)),
	[IsGroupedComm] [bit] NOT NULL CONSTRAINT [DF_Dep_CustSettingMode_IsGroupedComm]  DEFAULT ((0)),
	[IsGroupedBetLimit] [bit] NOT NULL CONSTRAINT [DF_Dep_CustSettingMode_IsGroupedBetLimit]  DEFAULT ((0)),
	[IsGroupedStakeLevel] [bit] NOT NULL CONSTRAINT [DF_Dep_CustSettingMode_IsGroupedStakeLevel]  DEFAULT ((0)),
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_CustSettingMode_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_CustSettingMode] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustPTSetting_table]
) ON [Dep_CustPTSetting_table]

GO
-------------------------------------------------------
--Dep_CustSpecialLevel
CREATE TABLE [dbo].[Dep_CustSpecialLevel](
	[custid] [int] NOT NULL,
	[SpecialLevel] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_CustSpecialLevel_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_CustSpecialLevel] PRIMARY KEY CLUSTERED 
(
	[custid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

-------------------------------------------------------
--Dep_CustStakeLevel_Agent
CREATE TABLE [dbo].[Dep_CustStakeLevel_Agent](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[StakeLevelList] [varchar](200) NULL,
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_CustStakeLevel_Agent_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_CustStakeLevel_Agent] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustStakeLevel_table]
) ON [Dep_CustStakeLevel_table]
GO

-------------------------------------------------------
--Dep_CustStakeLevel_Member
CREATE TABLE [dbo].[Dep_CustStakeLevel_Member](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[StakeLevelList] [varchar](200) NULL,
	[LastUpdated] [datetime] NULL,
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_CustStakeLevel_Member_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_CustStakeLevel_Member] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Dep_CustStakeLevel_table]
) ON [Dep_CustStakeLevel_table]
GO

-------------------------------------------------------
--Dep_CustSuper
CREATE TABLE [dbo].[Dep_CustSuper](
	[custid] [int] NOT NULL,
	[currency] [int] NULL,
	[username] [nvarchar](50) NULL,
	[site] [varchar](20) NULL,
	[CurrencyModifier] [smallmoney] NOT NULL CONSTRAINT [DF_Dep_CustSuper_CurrencyModifier]  DEFAULT ((1)),
	[SiteDBGroupID] [smallint] NOT NULL CONSTRAINT [DF_Dep_CustSuper_SiteDBGroupID]  DEFAULT ((0)),
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_CustSuper_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_CustSuper] PRIMARY KEY CLUSTERED 
(
	[custid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

-------------------------------------------------------
--Dep_CustVIP
CREATE TABLE [dbo].[Dep_CustVIP](
	[CustID] [int] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[UserID] [int] NULL,
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_CustVIP_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_CustVIP] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [table_customer]
) ON [table_customer]
GO

-------------------------------------------------------
--Dep_DefaultOddGroup
CREATE TABLE [dbo].[Dep_DefaultOddGroup](
	[AgentID] [int] NOT NULL,
	[Ugroup] [varchar](3) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UserId] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_DefaultOddGroup_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_DefaultOddGroup] PRIMARY KEY CLUSTERED 
(
	[AgentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [DATA]
) ON [DATA]
GO

-------------------------------------------------------
--Dep_LicenseeProductSetting
CREATE TABLE [dbo].[Dep_LicenseeProductSetting](
	[CustID] [int] NOT NULL,
	[ProductSettingID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_LicenseeProductSetting_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_LicenseeProductSetting] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[ProductSettingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

-------------------------------------------------------
--Dep_ProductBetSetting
CREATE TABLE [dbo].[Dep_ProductBetSetting](
	[Sporttype] [int] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[Currency] [tinyint] NOT NULL,
	[MinBet] [money] NULL CONSTRAINT [DF_Dep_ProductBetSetting_Minbet]  DEFAULT ((0)),
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[DefaultMinBet] [money] NULL,
	[DefaultMaxBet] [money] NULL,
	[DefaultMaxPerMatch] [money] NULL,
	[MaxPerBall] [decimal](19, 8) NULL,
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_ProductBetSetting_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_ProductBetSetting] PRIMARY KEY CLUSTERED 
(
	[Sporttype] ASC,
	[Bettype] ASC,
	[Currency] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

-------------------------------------------------------
--Dep_ProductSettingDetail
CREATE TABLE [dbo].[Dep_ProductSettingDetail](
	[ProductSettingID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[MaxDefaultValue] [decimal](19, 8) NULL CONSTRAINT [DF_Dep_ProductSettingDetail_MaxDefaultValue]  DEFAULT ((0)),
	[SettingStatus] [tinyint] NULL,
	[MinDefaultValue] [decimal](19, 8) NULL,
	[IsApplyBA] [bit] NOT NULL CONSTRAINT [DF_Dep_ProductSettingDetail_IsApplyBA]  DEFAULT ((0)),
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_ProductSettingDetail_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_ProductSettingDetail] PRIMARY KEY CLUSTERED 
(
	[ProductSettingID] ASC,
	[SportType] ASC,
	[BetType] ASC,
	[IsLive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

-------------------------------------------------------
--Dep_ProductStatusProfile
CREATE TABLE [dbo].[Dep_ProductStatusProfile](
	[Sporttype] [smallint] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[bitmapOrder] [tinyint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_ProductStatusProfile_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_ProductStatusProfile] PRIMARY KEY NONCLUSTERED 
(
	[Sporttype] ASC,
	[Bettype] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

-------------------------------------------------------
--Dep_StakeLevel
CREATE TABLE [dbo].[Dep_StakeLevel](
	[StakeLevelID] [int] NOT NULL,
	[GameTypeID] [smallint] NOT NULL,
	[GameGroupID] [smallint] NOT NULL CONSTRAINT [DF_Dep_StakeLevel_GameGroupID]  DEFAULT ((0)),
	[MinLabel] [nvarchar](50) NULL,
	[MaxLabel] [nvarchar](50) NULL,
	[MinStake] [decimal](19, 8) NULL,
	[MaxStake] [decimal](19, 8) NULL,
	[ExchangeID] [int] NULL,
	[ResourceId] [varchar](20) NULL,
	[SiteID] [int] NULL,
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_StakeLevel_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_StakeLevel] PRIMARY KEY CLUSTERED 
(
	[StakeLevelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

-------------------------------------------------------
--Dep_StakeLevelGroupDetail
CREATE TABLE [dbo].[Dep_StakeLevelGroupDetail](
	[StakeLevelID] [int] NOT NULL,
	[GameTypeID] [smallint] NOT NULL,
	[MinLabel] [nvarchar](50) NULL,
	[MaxLabel] [nvarchar](50) NULL,
	[MinStake] [decimal](19, 8) NULL,
	[MaxStake] [decimal](19, 8) NULL,
	[ParentTypeID] [int] NULL,
	[MaxGameStake] [decimal](19, 8) NULL,
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_StakeLevelGroupDetail_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_StakeLevelGroupDetail] PRIMARY KEY CLUSTERED 
(
	[StakeLevelID] ASC,
	[GameTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

-------------------------------------------------------
--Dep_SuperSetting_AGCasino
CREATE TABLE [dbo].[Dep_SuperSetting_AGCasino](
	[CustID] [int] NOT NULL,
	[CheckedGroup] [varchar](500) NULL,
	[DefaultGroup] [varchar](20) NULL,
	[IsEnabled] [bit] NULL,
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_SuperSetting_AGCasino_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_SuperSetting_AGCasino] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

-------------------------------------------------------
--Dep_SupperProductSetting
CREATE TABLE [dbo].[Dep_SupperProductSetting](
	[CustID] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[IsEnabled] [bit] NULL,
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Dep_SupperProductSetting_RepUpdateTime]  DEFAULT (SYSDATETIME()),
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Dep_SupperProductSetting] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO
