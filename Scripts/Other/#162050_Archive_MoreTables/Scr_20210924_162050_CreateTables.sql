/*<info serverAlias="DBARCCUST-bodb_Customer"></info>*/
/*
	Created: Eden@20210924
	Task: Include newly created tables into Archive Credit Dormant Account process [Redmine: #162050]   
	DB: DBARCCUST/bodb_Customer
*/
USE bodb_Customer
GO
--DROP TABLE [CustBetSetting_Agent_old]
--DROP TABLE [CustBetSetting_Member_old]
--DROP TABLE [CustMaster_old]
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CustBetSetting_Agent_old](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL CONSTRAINT [DF_CustBetSetting_Agent_old_MinBet]  DEFAULT ((0)),
	[MaxBet] [money] NULL CONSTRAINT [DF_CustBetSetting_Agent_old_MaxBet]  DEFAULT ((0)),
	[MaxPerMatch] [money] NULL CONSTRAINT [DF_CustBetSetting_Agent_old_MPM]  DEFAULT ((0)),
	[MaxPerNumber] [money] NULL CONSTRAINT [DF_CustBetSetting_Agent_old_MPN]  DEFAULT ((0)),
	[MaxPayoutPerMatch] [money] NULL CONSTRAINT [DF_CustBetSetting_Agent_old_MPPM]  DEFAULT ((0)),
 CONSTRAINT [PK_CustBetSetting_Agent_old] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [CustSetting_table]
) ON [CustSetting_table]

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CustBetSetting_Member_old](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL CONSTRAINT [DF_CustBetSetting_Member_old_MinBet]  DEFAULT ((0)),
	[MaxBet] [money] NULL CONSTRAINT [DF_CustBetSetting_Member_old_MaxBet]  DEFAULT ((0)),
	[MaxPerMatch] [money] NULL CONSTRAINT [DF_CustBetSetting_Member_old_MPM]  DEFAULT ((0)),
	[MaxPerNumber] [money] NULL CONSTRAINT [DF_CustBetSetting_Member_old_MPN]  DEFAULT ((0)),
	[MaxPayoutPerMatch] [money] NULL CONSTRAINT [DF_CustBetSetting_Member_old_MPPM]  DEFAULT ((0)),
 CONSTRAINT [PK_CustBetSetting_Member_old] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [CustSetting_table]
) ON [CustSetting_table]

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CustMaster_old](
	[custid] [int] NOT NULL,
	[DisableAutoMPT] [bit] NOT NULL CONSTRAINT [DF_CustMaster_old_DisableAutoMPT]  DEFAULT ((0)),
	[IsInternal] [bit] NOT NULL CONSTRAINT [DF_CustMaster_old_IsInternal]  DEFAULT ((0)),
	[TransferOption] [tinyint] NULL,
	[LimitPerIP] [tinyint] NOT NULL CONSTRAINT [DF_CustMaster_old_LimitPerIP]  DEFAULT ((0)),
	[SelectedBetting] [bit] NOT NULL CONSTRAINT [DF_CustMaster_old_SelectedBetting]  DEFAULT ((0)),
	[NicknameLoginOnly] [bit] NULL CONSTRAINT [DF_CustMaster_NicknameLoginOnly]  DEFAULT ((0)),
	[creationRemark] [nvarchar](300) NULL DEFAULT (NULL),
	[IsAllDayBalTransfer] [bit] NULL,
 CONSTRAINT [PK_CustMaster_old] PRIMARY KEY CLUSTERED 
(
	[custid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

ALTER TABLE [CustLoginInfo_Old] ADD FunctionInfo TINYINT ,ProtectionCode varchar(30), IsProtectedMode BIT
ALTER TABLE [CustLoginInfoSub_Old] ADD FunctionInfo TINYINT ,ProtectionCode varchar(30)
