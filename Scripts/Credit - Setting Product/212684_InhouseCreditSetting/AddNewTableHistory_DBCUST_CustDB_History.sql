/*<info serverAlias="DBCUST-CustDB_History"></info>*/
/*
	Created: 20241105@Johnson
	Task: Add credit history tables [redmine:#212684]
	DB: DBCUST/CustDB_History
*/
USE CustDB_History
GO
--grant permission for Dot_Admin
CREATE USER [Dot_Admin] FOR LOGIN [Dot_Admin] WITH DEFAULT_SCHEMA=[dbo]
GO
GRANT CONNECT,INSERT TO [Dot_Admin]
GO

ALTER DATABASE [CustDB_History] ADD FILEGROUP [DATA] 
GO
ALTER DATABASE [CustDB_History] ADD FILE 
( NAME = N'DATA_01', FILENAME = N'/mnt/DiskG/CustDB_History/DATA_01.ndf' , SIZE = 4096MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB ), 
( NAME = N'DATA_02', FILENAME = N'/mnt/DiskG/CustDB_History/DATA_02.ndf' , SIZE = 4096MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB ), 
( NAME = N'DATA_03', FILENAME = N'/mnt/DiskG/CustDB_History/DATA_03.ndf' , SIZE = 4096MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB )
TO FILEGROUP [DATA]
GO

CREATE TABLE [dbo].[CustDiscount3rd_Agent_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[UpdateTime] [datetime] NULL CONSTRAINT [DF_CustDiscount3rd_Agent_history_UpdateTime]  DEFAULT (getdate()),
	[CustID] [int],
	[SportType] [smallint],
	[BetType] [smallint],
	[Discount] [decimal](9, 8) CONSTRAINT [DF_CustDiscount3rd_Agent_history_Discount] DEFAULT ((0)),
CONSTRAINT [PK_CustDiscount3rd_Agent_History] PRIMARY KEY CLUSTERED 
	(
		[rID] ASC
	)		
) ON [CustSetting_table]
GO


CREATE TABLE [dbo].[CustDiscount3rd_Member_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[UpdateTime] [datetime] NULL CONSTRAINT [DF_CustDiscount3rd_Member_History_UpdateTime]  DEFAULT (getdate()),
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[PlayerDiscount] [decimal](9, 8) NOT NULL CONSTRAINT [DF_CustDiscount3rd_Member_History_PlayerDiscount] DEFAULT ((0)),
	[AgentDiscount] [decimal](9, 8) NOT NULL CONSTRAINT [DF_CustDiscount3rd_Member_History_AgentDiscount] DEFAULT ((0)),
	[MasterDiscount] [decimal](9, 8) NOT NULL CONSTRAINT [DF_CustDiscount3rd_Member_History_MasterDiscount] DEFAULT ((0)),
	[SuperDiscount] [decimal](9, 8) NOT NULL CONSTRAINT [DF_CustDiscount3rd_Member_History_SuperDiscount] DEFAULT ((0)),
CONSTRAINT [PK_CustDiscount3rd_Member_History] PRIMARY KEY CLUSTERED 
	(
		[rID] ASC
	)
) ON [CustSetting_table]
GO


CREATE TABLE [dbo].[CustInfo_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[UpdateTime] [datetime] NULL CONSTRAINT [DF_CustInfo_history_UpdateTime]  DEFAULT (getdate()),
	[username] [nvarchar](50) NULL,
	[custid] [int] NULL,
	[currency] [int] NULL,
	[roleid] [tinyint] NULL,
	[srecommend] [int] NULL,
	[mrecommend] [int] NULL,
	[recommend] [int] NULL,
	[dangercust] [bit] NULL,
	[autosuspend] [bit] NULL,
	[reject] [bit] NULL,
	[credit] [money] NULL,
	[closed] [bit] NULL,
	[MatchLimit] [smallmoney] NULL,
	[VirtualMultiplier] [smallmoney] NULL,
	[Enabled] [bit] NULL,
	[danger] [tinyint] NULL,	
	[danger2] [tinyint] NULL,
	[danger3] [tinyint] NULL,
	[DisableOutright] [bit] NULL,	
	[Abnormal] [tinyint] NULL,
	[DoubleCommLosing] [bit] NULL,	
	[autosuspend2] [money] NULL CONSTRAINT [DF_custInfo_history_autosuspend2]  DEFAULT ((0)),	
	[DisableEsports] [bit] NULL,
	[DisableSuperLive] [bit] NULL CONSTRAINT [DF_custinfo_history_DisableSuperLive]  DEFAULT ((0)),
	[LockUpd] [bit] NULL CONSTRAINT [DF_custinfo_history_LockUpd]  DEFAULT ((0)),	
	[BonusWalletFlag] [tinyint] NULL,
	[DangerLevel] [int] NULL,
	[CustomerClass] [smallint] NULL CONSTRAINT [DF_CustInfo_History_CustomerClass]  DEFAULT ((0)),
	[Danger4] [tinyint] NULL CONSTRAINT [DF_custinfo_history_Danger4]  DEFAULT ((0)),
	[Danger5] [tinyint] NULL CONSTRAINT [DF_custinfo_history_Danger5]  DEFAULT ((0)),
	[CCSoccer] [smallint] NULL,
	[CCBasketball] [smallint] NULL,
	[CCEsports] [smallint] NULL,
	[CCOtherSports] [smallint] NULL,
	[CCNonSports] [smallint] NULL,
	[autosuspend3] [bit] NULL,
CONSTRAINT [PK_CustInfo_History] PRIMARY KEY CLUSTERED 
	(
		[rID] ASC
	)
) ON [DATA]

GO

CREATE TABLE [dbo].[CustMaxPayoutSetting_Agent_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[UpdateTime] [datetime] NULL CONSTRAINT [DF_CustMaxPayoutSetting_Agent_History_UpdateTime]  DEFAULT (getdate()),
	[CustID] [int] NULL,
	[SportType] [smallint] NULL,
	[BetType] [smallint] NULL,
	[SingleMatchParlay] [money] NULL  CONSTRAINT [DF_CustMaxPayoutSetting_Agent_History_SingleMatchParlay]  DEFAULT ((0)),
	[Combo2] [money] NULL CONSTRAINT [DF_CustMaxPayoutSetting_Agent_History_Combo2]  DEFAULT ((0)),
	[Combo35] [money] NULL CONSTRAINT [DF_CustMaxPayoutSetting_Agent_History_Combo35]  DEFAULT ((0)),
	[ComboOver6] [money] NULL CONSTRAINT [DF_CustMaxPayoutSetting_Agent_History_ComboOver6]  DEFAULT ((0)),
CONSTRAINT [PK_CustMaxPayoutSetting_Agent_History] PRIMARY KEY CLUSTERED 
	(
		[rID] ASC
	)	
) ON [CustSetting_table]

GO

CREATE TABLE [dbo].[CustMaxPayoutSetting_Member_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[UpdateTime] [datetime] NULL CONSTRAINT [DF_CustMaxPayoutSetting_Member_History_UpdateTime]  DEFAULT (getdate()),
	[CustID] [int] NULL,
	[SportType] [smallint] NULL,
	[BetType] [smallint] NULL,
	[SingleMatchParlay] [money] NULL CONSTRAINT [DF_CustMaxPayoutSetting_Member_History_SingleMatchParlay]  DEFAULT ((0)),
	[Combo2] [money] NULL CONSTRAINT [DF_CustMaxPayoutSetting_Member_History_Combo2]  DEFAULT ((0)),
	[Combo35] [money] NULL CONSTRAINT [DF_CustMaxPayoutSetting_Member_History_Combo35]  DEFAULT ((0)),
	[ComboOver6] [money] NULL CONSTRAINT [DF_CustMaxPayoutSetting_Member_History_ComboOver6]  DEFAULT ((0)),
CONSTRAINT [PK_CustMaxPayoutSetting_Member_History] PRIMARY KEY CLUSTERED 
	(
		[rID] ASC
	)		
) ON [CustSetting_table]

GO

CREATE TABLE [dbo].[Customer_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[UpdateTime] [datetime] NULL CONSTRAINT [DF_Customer_History_UpdateTime]  DEFAULT (getdate()),
	[custid] [int] NULL,
	[firstname] [nvarchar](50) NULL,
	[lastname] [nvarchar](50) NULL,
	[address] [nvarchar](80) NULL,
	[postal] [nvarchar](50) NULL,
	[city] [nvarchar](50) NULL,
	[state] [nvarchar](50) NULL,
	[country] [nvarchar](50) NULL,
	[phone] [nvarchar](50) NULL,
	[mobilephone] [nvarchar](50) NULL,
	[fax] [nvarchar](50) NULL,
	[email] [nvarchar](50) NULL,
	[birthday] [smalldatetime] NULL,
	[refcode1] [nvarchar](50) NULL,
	[refcode2] [nvarchar](50) NULL,
	[remark] [nvarchar](50) NULL,
	[creatdate] [smalldatetime] NULL,
	[creator] [int] NULL,
	[username] [varchar](30) NULL,
	[currency] [tinyint] NULL,
	[userpwd] [varchar](40) NULL,
	[lastlogged] [smalldatetime] NULL,
	[pwdexpiry] [datetime] NULL,
	[roleid] [tinyint] NULL,
	[mrecommend] [int] NULL,
	[recommend] [int] NULL,
	[ugroup] [varchar](3) NULL,
	[logincount] [tinyint] NULL,
	[on_sessionid] [int] NULL,
	[site] [varchar](10) NULL,
	[iplogin] [nvarchar](20) NULL,
	[important] [bit] NULL,
	[srecommend] [int] NULL,
	[username2] [varchar](50) NULL,
CONSTRAINT [PK_Customer_History] PRIMARY KEY CLUSTERED 
	(
		[rID] ASC
	)		
) ON [DATA]

GO


CREATE TABLE [dbo].[CustProductStatus_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[UpdateTime] [datetime] NULL CONSTRAINT [DF_CustProductStatus_history_UpdateTime]  DEFAULT (getdate()),
	[CustID] [int] NULL,
	[bitmapHasSynced] [binary](32) NULL CONSTRAINT [DF_CustProductStatus_history_bitmapHasSynced]  DEFAULT (0x00),
	[bitmapIsHidden] [binary](32) NULL CONSTRAINT [DF_CustProductStatus_history_bitmapIsHidden]  DEFAULT (0x00),
	[bitmapIsDisabled] [binary](32) NULL CONSTRAINT [DF_CustProductStatus_history_bitmapIsDisabled]  DEFAULT (0x00),
	[SuspendInfo] [tinyint] NULL CONSTRAINT [DF_CustProductStatus_History_SuspendInfo]  DEFAULT ((0)),
	[Locked] [tinyint] NULL CONSTRAINT [DF_CustProductStatus_Locked]  DEFAULT ((0)),
	[CloseInfo] [tinyint] NULL CONSTRAINT [DF_CustProductStatus_CloseInfo]  DEFAULT ((0)),
CONSTRAINT [PK_CustProductStatus_History] PRIMARY KEY CLUSTERED 
	(
		[rID] ASC
	)	
) ON [DATA]

GO


CREATE TABLE [dbo].[CustPTGroupSetting3rd_Member_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[UpdateTime] [datetime] NULL CONSTRAINT [DF_CustPTGroupSetting3rd_Member_history_UpdateTime]  DEFAULT (getdate()),
	[AgentID] [int] NULL,
	[SportType] [smallint] NULL,
	[BetType] [smallint] NULL,
	[IsLive] [bit] NULL,
	[SuperPT] [smallmoney] NULL CONSTRAINT [DF_CustPTGroupSetting3rd_Member_SuperPT]  DEFAULT ((0)),
	[MasterPT] [smallmoney] NULL CONSTRAINT [DF_CustPTGroupSetting3rd_Member_MasterPT]  DEFAULT ((0)),
	[AgentPT] [smallmoney] NULL CONSTRAINT [DF_CustPTGroupSetting3rd_Member_AgentPT]  DEFAULT ((0)),
	[IsAutoMasterPT] [bit] NULL CONSTRAINT [DF_CustPTGroupSetting3rd_Member_IsAutoMasterPT]  DEFAULT ((0)),
	[AutoMasterPT] [smallmoney] NULL CONSTRAINT [DF_CustPTGroupSetting3rd_Member_AutoMasterPT]  DEFAULT ((0)),
	[IsAutoSuperPT] [bit] NULL CONSTRAINT [DF_CustPTGroupSetting3rd_Member_IsAutoSuperPT]  DEFAULT ((0)),
	[AutoSuperPT] [smallmoney] NULL CONSTRAINT [DF_CustPTGroupSetting3rd_Member_AutoSuperPT]  DEFAULT ((0)),
CONSTRAINT [PK_CustPTGroupSetting3rd_Member_History] PRIMARY KEY CLUSTERED 
	(
		[rID] ASC
	)
) ON [CustSetting_table]

GO

CREATE TABLE [dbo].[CustPTSetting3rd_Agent_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[UpdateTime] [datetime] NULL CONSTRAINT [DF_CustPTSetting3rd_Agent_history_UpdateTime]  DEFAULT (getdate()),
	[CustID] [int] NULL,
	[SportType] [smallint] NULL,
	[BetType] [smallint] NULL,
	[IsLive] [bit] NULL,
	[IsAutoMasterPT] [bit] NULL CONSTRAINT [DF_CustPTSetting3rd_Agent_IsAutoMasterPT]  DEFAULT ((0)),
	[IsAutoSuperPT] [bit] NULL CONSTRAINT [DF_CustPTSetting3rd_Agent_IsAutoSuperPT]  DEFAULT ((0)),
	[SuperPT] [smallmoney] NULL CONSTRAINT [DF_CustPTSetting3rd_Agent_SuperPT]  DEFAULT ((0)),
	[MasterPT] [smallmoney] NULL CONSTRAINT [DF_CustPTSetting3rd_Agent_MasterPT]  DEFAULT ((0)),
	[AgentPT] [smallmoney] NULL CONSTRAINT [DF_CustPTSetting3rd_Agent_AgentPT]  DEFAULT ((0)),
	[AutoSuperPT] [smallmoney] NULL CONSTRAINT [DF_CustPTSetting3rd_Agent_AutoSuperPT]  DEFAULT ((0)),
	[AutoMasterPT] [smallmoney] NULL CONSTRAINT [DF_CustPTSetting3rd_Agent_AutoMasterPT]  DEFAULT ((0)),
	[MinPT] [smallmoney] NULL CONSTRAINT [DF_CustPTSetting3rd_Agent_MinPT]  DEFAULT ((0)),
	[MaxPT] [smallmoney] NULL CONSTRAINT [DF_CustPTSetting3rd_Agent_MaxPT]  DEFAULT ((90)),
CONSTRAINT [PK_CustPTSetting3rd_Agent_History] PRIMARY KEY CLUSTERED 
	(
		[rID] ASC
	)
) ON [CustSetting_table]

GO

CREATE TABLE [dbo].[CustPTSetting3rd_Member_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[UpdateTime] [datetime]  NULL CONSTRAINT [DF_CustPTSetting3rd_Member_history_UpdateTime]  DEFAULT (getdate()),
	[CustID] [int] NULL,
	[SportType] [smallint] NULL,
	[BetType] [smallint] NULL,
	[IsLive] [bit] NULL,
	[IsAutoMasterPT] [bit] NULL CONSTRAINT [DF_CustPTSetting3rd_Member_IsAutoMasterPT]  DEFAULT ((0)),
	[IsAutoSuperPT] [bit] NULL CONSTRAINT [DF_CustPTSetting3rd_Member_IsAutoSuperPT]  DEFAULT ((0)),
	[SuperPT] [smallmoney] NULL CONSTRAINT [DF_CustPTSetting3rd_Member_SuperPT]  DEFAULT ((0)),
	[MasterPT] [smallmoney] NULL CONSTRAINT [DF_CustPTSetting3rd_Member_MasterPT]  DEFAULT ((0)),
	[AgentPT] [smallmoney] NULL CONSTRAINT [DF_CustPTSetting3rd_Member_AgentPT]  DEFAULT ((0)),
	[AutoSuperPT] [smallmoney] NULL CONSTRAINT [DF_CustPTSetting3rd_Member_AutoSuperPT]  DEFAULT ((0)),
	[AutoMasterPT] [smallmoney] NULL CONSTRAINT [DF_CustPTSetting3rd_Member_AutoMasterPT]  DEFAULT ((0)),
CONSTRAINT [PK_CustPTSetting3rd_Member_History] PRIMARY KEY CLUSTERED 
	(
		[rID] ASC
	)	
) ON [CustSetting_table]

GO

CREATE TABLE [dbo].[CustSettingMode3rd_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[UpdateTime] [datetime] NULL CONSTRAINT [DF_CustSettingMode3rd_history_UpdateTime]  DEFAULT (getdate()),
	[CustID] [int] NULL,
	[IsGrouped] [bit] NULL CONSTRAINT [DF_CustSettingMode3rd_history_IsGrouped]  DEFAULT ((1)),
CONSTRAINT [PK_CustSettingMode3rd_History] PRIMARY KEY CLUSTERED 
	(
		[rID] ASC
	)	
) ON [DATA]

GO

CREATE TABLE [dbo].[CustStakeLevel_Agent_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[UpdateTime] [datetime] NULL CONSTRAINT [DF_CustStakeLevel_Agent_history_UpdateTime]  DEFAULT (getdate()),
	[CustID] [int] NULL,
	[SportType] [smallint] NULL,
	[BetType] [int] NULL,
	[StakeLevelList] [varchar](200) NULL,
CONSTRAINT [PK_CustStakeLevel_Agent_History] PRIMARY KEY CLUSTERED 
	(
		[rID] ASC
	)	
) ON [CustSetting_table]

GO

CREATE TABLE [dbo].[CustStakeLevel_Member_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[UpdateTime] [datetime] NULL CONSTRAINT [DF_CustStakeLevel_Member_history_UpdateTime]  DEFAULT (getdate()),
	[CustID] [int] NULL,
	[SportType] [smallint] NULL,
	[BetType] [int] NULL,
	[StakeLevelList] [varchar](200) NULL,	
	[LastUpdated] [datetime] NULL CONSTRAINT [DF_CustStakeLevel_Member_history_LastUpdate]  DEFAULT (getdate()),
CONSTRAINT [PK_CustStakeLevel_Member_History] PRIMARY KEY CLUSTERED 
	(
		[rID] ASC
	)	
) ON [CustSetting_table]

GO

CREATE TABLE [dbo].[CustWinLossLimit_Agent_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[UpdateTime] [datetime] NULL CONSTRAINT [DF_CustWinLossLimit_Agent_history_UpdateTime]  DEFAULT (getdate()),
	[CustId] [int] NULL,
	[SportType] [smallint] NULL,
	[BetType] [int] NULL,
	[MaxWinLimit] [smallmoney] NULL,
	[MaxLossLimit] [money] NULL,
	[IsAutoReset] [bit] NULL,
CONSTRAINT [PK_CustWinLossLimit_Agent_History] PRIMARY KEY CLUSTERED 
	(
		[rID] ASC
	)		
) ON [CustSetting_table]

GO

CREATE TABLE [dbo].[CustWinLossLimit_Member_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[UpdateTime] [datetime] NULL CONSTRAINT [DF_CustWinLossLimit_Member_history_UpdateTime]  DEFAULT (getdate()),
	[CustId] [int] NULL,
	[SportType] [smallint] NULL,
	[BetType] [int] NULL,
	[MaxWinLimit] [smallmoney] NULL,
	[MaxLossLimit] [money] NULL,
	[IsAutoReset] [bit] NULL,
CONSTRAINT [PK_CustWinLossLimit_Member_History] PRIMARY KEY CLUSTERED 
	(
		[rID] ASC
	)	
) ON [CustSetting_table]

GO
