/*<info serverAlias="DBARCCUST-bodb_Customer"></info>*/
/*
	Created: Helios@20241028
	Task: Create new tables to store bet setting for 3rd products - Credit [Redmine: #204358]
	DB: DBARCCUST-bodb_Customer
*/


USE bodb_Customer

--> Impact From: Simplify and Migrate


/****** Object:  Table [dbo].[BetSetting3rd_Agent_old]    Script Date: 10/28/2024 11:49:47 AM ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects o WITH (NOLOCK) WHERE o.type = 'U' AND o.name = 'BetSetting3rd_Agent_old' )
BEGIN
	CREATE TABLE [dbo].[BetSetting3rd_Agent_old](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[MaxPerNumber] [money] NULL,
	 CONSTRAINT [PK_BetSetting3rd_Agent_old] PRIMARY KEY CLUSTERED 
	(
		[CustID] ASC,
		[SportType] ASC,
		[BetType] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
	) ON [DATA]
END
ELSE
BEGIN
	PRINT 'Create Fail ! Exist Table BetSetting3rd_Agent_old'
END

GO

/****** Object:  Table [dbo].[BetSetting3rd_Member_old]    Script Date: 10/28/2024 11:49:47 AM ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects o WITH (NOLOCK) WHERE o.type = 'U' AND o.name = 'BetSetting3rd_Member_old' )
BEGIN
	CREATE TABLE [dbo].[BetSetting3rd_Member_old](
		[CustID] [int] NOT NULL,
		[SportType] [smallint] NOT NULL,
		[BetType] [smallint] NOT NULL,
		[MinBet] [money] NULL,
		[MaxBet] [money] NULL,
		[MaxPerMatch] [money] NULL,
		[MaxPerNumber] [money] NULL,
	 CONSTRAINT [PK_BetSetting3rd_Member_old] PRIMARY KEY CLUSTERED 
	(
		[CustID] ASC,
		[SportType] ASC,
		[BetType] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
	) ON [DATA]
END
ELSE
BEGIN
	PRINT 'Create Fail ! Exist Table BetSetting3rd_Member_old'
END

GO
/****** Object:  Table [dbo].[BetSetting_Agent_old]    Script Date: 10/28/2024 11:49:47 AM ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects o WITH (NOLOCK) WHERE o.type = 'U' AND o.name = 'BetSetting_Agent_old' )
BEGIN
	CREATE TABLE [dbo].[BetSetting_Agent_old](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[MaxPayoutPerMatch] [money] NULL,
	 CONSTRAINT [PK_BetSetting_Agent_old] PRIMARY KEY CLUSTERED 
	(
		[CustID] ASC,
		[SportType] ASC,
		[BetType] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[BetSetting_Agent_old] ADD  CONSTRAINT [DF_BetSetting_Agent_old_MinBet]  DEFAULT ((0)) FOR [MinBet]

	ALTER TABLE [dbo].[BetSetting_Agent_old] ADD  CONSTRAINT [DF_BetSetting_Agent_old_MaxBet]  DEFAULT ((0)) FOR [MaxBet]

	ALTER TABLE [dbo].[BetSetting_Agent_old] ADD  CONSTRAINT [DF_BetSetting_Agent_old_MPM]  DEFAULT ((0)) FOR [MaxPerMatch]

	ALTER TABLE [dbo].[BetSetting_Agent_old] ADD  CONSTRAINT [DF_BetSetting_Agent_old_MPPM]  DEFAULT ((0)) FOR [MaxPayoutPerMatch]
END
ELSE
BEGIN
	PRINT 'Create Fail ! Exist Table BetSetting_Agent_old'
END


GO
/****** Object:  Table [dbo].[BetSetting_Member_old]    Script Date: 10/28/2024 11:49:47 AM ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects o WITH (NOLOCK) WHERE o.type = 'U' AND o.name = 'BetSetting_Member_old' )
BEGIN
	CREATE TABLE [dbo].[BetSetting_Member_old](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[MaxPayoutPerMatch] [money] NULL,
	 CONSTRAINT [PK_BetSetting_Member_old] PRIMARY KEY CLUSTERED 
	(
		[CustID] ASC,
		[SportType] ASC,
		[BetType] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[BetSetting_Member_old] ADD  CONSTRAINT [DF_BetSetting_Member_old_MinBet]  DEFAULT ((0)) FOR [MinBet]

	ALTER TABLE [dbo].[BetSetting_Member_old] ADD  CONSTRAINT [DF_BetSetting_Member_old_MaxBet]  DEFAULT ((0)) FOR [MaxBet]

	ALTER TABLE [dbo].[BetSetting_Member_old] ADD  CONSTRAINT [DF_BetSetting_Member_old_MPM]  DEFAULT ((0)) FOR [MaxPerMatch]

	ALTER TABLE [dbo].[BetSetting_Member_old] ADD  CONSTRAINT [DF_BetSetting_Member_old_MPPM]  DEFAULT ((0)) FOR [MaxPayoutPerMatch]
END
ELSE
BEGIN
	PRINT 'Create Fail ! Exist Table BetSetting_Member_old'
END


--> Impact From: RedmineID 212684

GO
/****** Object:  Table [dbo].[CustPTTemplate_old]    Script Date: 10/28/2024 11:49:47 AM ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects o WITH (NOLOCK) WHERE o.type = 'U' AND o.name = 'CustPTTemplate_old' )
BEGIN
	CREATE TABLE [dbo].[CustPTTemplate_old](
	[TemplateID] [int] NOT NULL,
	[custid] [int] NOT NULL,
	[TemplateName] [nvarchar](50) NOT NULL,
	[IsDefault] [bit] NULL,
	 CONSTRAINT [PK_CustPTTemplate_old] PRIMARY KEY CLUSTERED 
	(
		[TemplateID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
	) ON [DATA]
END
ELSE
BEGIN
	PRINT 'Create Fail ! Exist Table CustPTTemplate_old'
END

GO

/****** Object:  Table [dbo].[CustPTTemplateDetail_old]    Script Date: 10/28/2024 11:49:47 AM ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects o WITH (NOLOCK) WHERE o.type = 'U' AND o.name = 'CustPTTemplateDetail_old' )
BEGIN
	CREATE TABLE [dbo].[CustPTTemplateDetail_old](
	[TemplateID] [int] NOT NULL,
	[GroupID] [tinyint] NOT NULL,
	[SubGroupID] [tinyint] NOT NULL,
	[PT] [smallmoney] NOT NULL,
	 CONSTRAINT [PK_CustPTTemplateDetail_old] PRIMARY KEY CLUSTERED 
	(
		[TemplateID] ASC,
		[GroupID] ASC,
		[SubGroupID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
	) ON [DATA]
END
ELSE
BEGIN
	PRINT 'Create Fail ! Exist Table CustPTTemplateDetail_old'
END

GO

/****** Object:  Table [dbo].[CustQRCode_old]    Script Date: 10/28/2024 11:49:47 AM ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects o WITH (NOLOCK) WHERE o.type = 'U' AND o.name = 'CustQRCode_old' )
BEGIN
	CREATE TABLE [dbo].[CustQRCode_old](
	[CustID] [int] NOT NULL,
	 CONSTRAINT [PK_CustQRCode_old] PRIMARY KEY CLUSTERED 
	(
		[CustID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
	) ON [DATA]
END
ELSE
BEGIN
	PRINT 'Create Fail ! Exist Table CustQRCode_old'
END

GO

/****** Object:  Table [dbo].[CustSuper_old]    Script Date: 10/28/2024 11:49:47 AM ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects o WITH (NOLOCK) WHERE o.type = 'U' AND o.name = 'CustSuper_old' )
BEGIN
	CREATE TABLE [dbo].[CustSuper_old](
	[custid] [int] NOT NULL,
	[AutoIBCPositionTaking_Tote] [smallmoney] NOT NULL,
	[AutoIBCPositionTaking_Fixed] [smallmoney] NOT NULL,
	[IsInternal] [bit] NOT NULL,
	[TransferOption] [tinyint] NULL,
	[LimitPerIP] [tinyint] NOT NULL,
	[SelectedBetting] [bit] NOT NULL,
	[AutoIBCPT151_AU] [smallmoney] NOT NULL,
	[AutoIBCPT152_UK] [smallmoney] NOT NULL,
	[AutoIBCPT152_AU] [smallmoney] NOT NULL,
	[AutoIBCPT153_AU] [smallmoney] NOT NULL,
	[NicknameLoginOnly] [bit] NULL,
	[creationRemark] [nvarchar](300) NULL,
	[IsMyanmarOdds] [bit] NULL,
	[IsAllDayBalTransfer] [bit] NULL,
	[MaxMember] [int] NULL,
	[MaxMemberRemark] [nvarchar](300) NULL,
	[UplineId] [int] NULL,
	[CurrencyModifier] [smallmoney] NOT NULL,
	[IsAutoEnableADBMaster] [bit] NOT NULL,
	[SiteDBGroupID] [smallint] NOT NULL,
	[IsSynced] [binary](2) NULL,
	 CONSTRAINT [PK_CustSuper_old] PRIMARY KEY CLUSTERED 
	(
		[custid] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[CustSuper_old] ADD  CONSTRAINT [DF_CustSuper_old_AutoIBCPositionTaking_Tote]  DEFAULT ((0)) FOR [AutoIBCPositionTaking_Tote]

	ALTER TABLE [dbo].[CustSuper_old] ADD  CONSTRAINT [DF_CustSuper_old_AutoIBCPositionTaking_Fixed]  DEFAULT ((0)) FOR [AutoIBCPositionTaking_Fixed]

	ALTER TABLE [dbo].[CustSuper_old] ADD  CONSTRAINT [DF_CustSuper_old_IsInternal]  DEFAULT ((0)) FOR [IsInternal]

	ALTER TABLE [dbo].[CustSuper_old] ADD  CONSTRAINT [DF_CustSuper_old_LimitPerIP]  DEFAULT ((0)) FOR [LimitPerIP]

	ALTER TABLE [dbo].[CustSuper_old] ADD  CONSTRAINT [DF_CustSuper_old_SelectedBetting]  DEFAULT ((0)) FOR [SelectedBetting]

	ALTER TABLE [dbo].[CustSuper_old] ADD  CONSTRAINT [DF_CustSuper_old_AutoIBCPT151_AU]  DEFAULT ((0)) FOR [AutoIBCPT151_AU]

	ALTER TABLE [dbo].[CustSuper_old] ADD  CONSTRAINT [DF_CustSuper_old_AutoIBCPT152_UK]  DEFAULT ((0)) FOR [AutoIBCPT152_UK]

	ALTER TABLE [dbo].[CustSuper_old] ADD  CONSTRAINT [DF_CustSuper_old_AutoIBCPT152_AU]  DEFAULT ((0)) FOR [AutoIBCPT152_AU]

	ALTER TABLE [dbo].[CustSuper_old] ADD  CONSTRAINT [DF_CustSuper_old_AutoIBCPT153_AU]  DEFAULT ((0)) FOR [AutoIBCPT153_AU]

	ALTER TABLE [dbo].[CustSuper_old] ADD  CONSTRAINT [DF__CustSuper_old__Nickn__6E66D941]  DEFAULT ((0)) FOR [NicknameLoginOnly]

	ALTER TABLE [dbo].[CustSuper_old] ADD  DEFAULT (NULL) FOR [creationRemark]
	
	ALTER TABLE [dbo].[CustSuper_old] ADD  CONSTRAINT [DF_CustSuper_old_IsMyanmarOdds]  DEFAULT ((0)) FOR [IsMyanmarOdds]

	ALTER TABLE [dbo].[CustSuper_old] ADD  CONSTRAINT [DF_CustSuper_old_IsAllDayBalTransfer]  DEFAULT ((0)) FOR [IsAllDayBalTransfer]

	ALTER TABLE [dbo].[CustSuper_old] ADD  DEFAULT ((-1)) FOR [MaxMember]

	ALTER TABLE [dbo].[CustSuper_old] ADD  CONSTRAINT [DF_CustSuper_old_CurrencyModifier]  DEFAULT ((1)) FOR [CurrencyModifier]

	ALTER TABLE [dbo].[CustSuper_old] ADD  CONSTRAINT [DF_CustSuper_old_IsAutoEnableADBMaster]  DEFAULT ((0)) FOR [IsAutoEnableADBMaster]

	ALTER TABLE [dbo].[CustSuper_old] ADD  CONSTRAINT [DF_CustSuper_old_SiteDBGroupID]  DEFAULT ((0)) FOR [SiteDBGroupID]

	ALTER TABLE [dbo].[CustSuper_old] ADD  CONSTRAINT [DF_CustSuper_old_IsSynced]  DEFAULT (0x00) FOR [IsSynced]

END
ELSE
BEGIN
	PRINT 'Create Fail ! Exist Table CustSuper_old'
END

GO 
/****** Object:  Table [dbo].[CustSuperProfile_old]    Script Date: 10/28/2024 1:27:46 PM ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects o WITH (NOLOCK) WHERE o.type = 'U' AND o.name = 'CustSuperProfile_old' )
BEGIN
	CREATE TABLE [dbo].[CustSuperProfile_old](
		[custid] [int] NOT NULL,
		[firstname] [nvarchar](50) NULL,
		[lastname] [nvarchar](50) NULL,
		[phone] [nvarchar](50) NULL,
		[mobilephone] [nvarchar](50) NULL,
		[fax] [nvarchar](50) NULL,
		[email] [nvarchar](50) NULL,
		[remark] [nvarchar](300) NULL,
	 CONSTRAINT [PK_CustSuperProfile_old] PRIMARY KEY CLUSTERED 
	(
		[custid] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
	) ON [DATA]
END
ELSE
BEGIN
	PRINT 'Create Fail ! Exist Table CustSuperProfile_old'
END

--> Impact From: Scan Table on Pro
GO
/****** Object:  Table [dbo].[VRCustSetting_old]    Script Date: 10/28/2024 1:27:46 PM ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects o WITH (NOLOCK) WHERE o.type = 'U' AND o.name = 'VRCustSetting_old' )
BEGIN
	CREATE TABLE [dbo].[VRCustSetting_old](
	[CustID] [int] NOT NULL,
	[LevelID] [int] NOT NULL,
	[ValueIDLIVE] [tinyint] NULL,
	[ValueIDNonLIVE] [tinyint] NULL,
	 CONSTRAINT [PK_VRCustSetting_old] PRIMARY KEY CLUSTERED 
	(
		[CustID] ASC,
		[LevelID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
	) ON [DATA]
END
ELSE
BEGIN
	PRINT 'Create Fail ! Exist Table VRCustSetting_old'
END

GO
/****** Object:  Table [dbo].[BetLimitControlCustSetting_old]    Script Date: 10/28/2024 1:27:46 PM ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects o WITH (NOLOCK) WHERE o.type = 'U' AND o.name = 'BetLimitControlCustSetting_old' )
BEGIN
	CREATE TABLE [dbo].[BetLimitControlCustSetting_old](
	[CustID] [int] NOT NULL,
	[BetLimitTypeID] [int] NOT NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[Mode] [tinyint] NOT NULL,
	PRIMARY KEY CLUSTERED 
	(
		[CustID] ASC,
		[BetLimitTypeID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[BetLimitControlCustSetting_old] ADD  CONSTRAINT [DF_BetLimitControlCustSetting_old_Mode]  DEFAULT ((1)) FOR [Mode]
END
ELSE
BEGIN
	PRINT 'Create Fail ! Exist Table BetLimitControlCustSetting_old'
END

GO
/****** Object:  Table [dbo].[WinLimit_CustGameStatus_old]    Script Date: 10/28/2024 1:27:46 PM ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects o WITH (NOLOCK) WHERE o.type = 'U' AND o.name = 'WinLimit_CustGameStatus_old' )
BEGIN
	CREATE TABLE [dbo].[WinLimit_CustGameStatus_old](
	[CustID] [int] NOT NULL,
	[ProductID] [tinyint] NOT NULL,
	[BettypeID] [smallint] NOT NULL,
	[IsBlockedPlaceBet] [bit] NOT NULL,
	[IsBlockedTransfer] [bit] NOT NULL,
	[ActionID] [tinyint] NULL,
	[ModifiedDate] [datetime] NOT NULL,
	 CONSTRAINT [PK_WinLimit_CustGameStatus_old] PRIMARY KEY CLUSTERED 
	(
		[CustID] ASC,
		[ProductID] ASC,
		[BettypeID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[WinLimit_CustGameStatus_old] ADD  CONSTRAINT [DF_WinLimit_CustGameStatus_old_IsBlockedPlaceBet]  DEFAULT ((0)) FOR [IsBlockedPlaceBet]

	ALTER TABLE [dbo].[WinLimit_CustGameStatus_old] ADD  CONSTRAINT [DF_WinLimit_CustGameStatus_old_IsBlockedTransfer]  DEFAULT ((0)) FOR [IsBlockedTransfer]

	ALTER TABLE [dbo].[WinLimit_CustGameStatus_old] ADD  CONSTRAINT [DF_WinLimit_CustGameStatus_old_ActionID]  DEFAULT ((0)) FOR [ActionID]
END
ELSE
BEGIN
	PRINT 'Create Fail ! Exist Table WinLimit_CustGameStatus_old'
END

GO
/****** Object:  Table [dbo].[VRCustLockStatus_old]    Script Date: 10/28/2024 1:27:46 PM ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects o WITH (NOLOCK) WHERE o.type = 'U' AND o.name = 'VRCustLockStatus_old' )
BEGIN	
	CREATE TABLE [dbo].[VRCustLockStatus_old](
	[CustID] [int] NOT NULL,
	[Type] [tinyint] NOT NULL,
	 CONSTRAINT [PK_VRCustLockStatus_old] PRIMARY KEY CLUSTERED 
	(
		[CustID] ASC,
		[Type] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
	) ON [DATA]
END
ELSE
BEGIN
	PRINT 'Create Fail ! Exist Table VRCustLockStatus_old'
END

GO
/****** Object:  Table [dbo].[VRCustAutoAdjustment_old]    Script Date: 10/28/2024 1:27:46 PM ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects o WITH (NOLOCK) WHERE o.type = 'U' AND o.name = 'VRCustAutoAdjustment_old' )
BEGIN	
	CREATE TABLE [dbo].[VRCustAutoAdjustment_old](
	[SportType] [smallint] NOT NULL,
	[CustID] [int] NOT NULL,
	[FirstBetDate] [date] NULL,
	[Status] [tinyint] NULL,
	 CONSTRAINT [PK_VRCustAutoAdjustment_old] PRIMARY KEY CLUSTERED 
	(
		[SportType] ASC,
		[CustID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
	) ON [DATA]
END
ELSE
BEGIN
	PRINT 'Create Fail ! Exist Table VRCustAutoAdjustment_old'
END

GO
/****** Object:  Table [dbo].[VRSettingManualUpdAcc_old]    Script Date: 10/28/2024 1:27:46 PM ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects o WITH (NOLOCK) WHERE o.type = 'U' AND o.name = 'VRSettingManualUpdAcc_old' )
BEGIN	
	CREATE TABLE [dbo].[VRSettingManualUpdAcc_old](
	[SportType] [smallint] NOT NULL,
	[CustID] [int] NOT NULL,
	 CONSTRAINT [PK_VRSettingManualUpdAcc_old] PRIMARY KEY CLUSTERED 
	(
		[SportType] ASC,
		[CustID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
	) ON [DATA]
END
ELSE
BEGIN
	PRINT 'Create Fail ! Exist Table VRSettingManualUpdAcc_old'
END

GO
/****** Object:  Table [dbo].[RobotList_old]    Script Date: 10/28/2024 1:27:46 PM ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects o WITH (NOLOCK) WHERE o.type = 'U' AND o.name = 'RobotList_old' )
BEGIN	
	CREATE TABLE [dbo].[RobotList_old](
	[custid] [int] NOT NULL,
	[isActive] [bit] NOT NULL,
	[creator] [int] NOT NULL,
	[createdate] [datetime] NOT NULL,
	[lastmodifytime] [smalldatetime] NULL,
	[lastmodifyuser] [int] NULL,
	[remark] [nvarchar](200) NULL,
	 CONSTRAINT [PK_RobotList_old] PRIMARY KEY CLUSTERED 
	(
		[custid] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
	) ON [DATA]
END
ELSE
BEGIN
	PRINT 'Create Fail ! Exist Table RobotList_old'
END

GO
/****** Object:  Table [dbo].[WinLimit_CustGameMonitoring_old]    Script Date: 10/28/2024 1:27:46 PM ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects o WITH (NOLOCK) WHERE o.type = 'U' AND o.name = 'WinLimit_CustGameMonitoring_old' )
BEGIN	
	CREATE TABLE [dbo].[WinLimit_CustGameMonitoring_old](
	[CustID] [int] NOT NULL,
	[ProductID] [tinyint] NOT NULL,
	[WinlostDate] [smalldatetime] NOT NULL,
	[LevelID] [tinyint] NOT NULL,
	[MaxWinLimit] [money] NOT NULL,
	[TotalWinAmt] [money] NOT NULL,
	[WinAmt] [money] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[IsNotified] [bit] NOT NULL,
	[ModifiedBy] [int] NULL,
	[CreatedBy] [int] NULL,
	[MaxWinLimitSetting] VARCHAR(MAX) NULL,
	[TotalWinAmt_RM] [money] NULL,
	[GroupID] [int] NOT NULL,
	[BettypeIDList] [varchar](1024) NULL,
	 CONSTRAINT [PK_WinLimit_CustGameMonitoring_old] PRIMARY KEY CLUSTERED 
	(
		[CustID] ASC,
		[ProductID] ASC,
		[GroupID] ASC,
		[WinlostDate] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[WinLimit_CustGameMonitoring_old] ADD  CONSTRAINT [DF_WinLimit_CustGameMonitoring_old_MaxWinLimit]  DEFAULT ((0)) FOR [MaxWinLimit]

	ALTER TABLE [dbo].[WinLimit_CustGameMonitoring_old] ADD  CONSTRAINT [DF_WinLimit_CustGameMonitoring_old_TotalWinAmt]  DEFAULT ((0)) FOR [TotalWinAmt]

	ALTER TABLE [dbo].[WinLimit_CustGameMonitoring_old] ADD  CONSTRAINT [DF_WinLimit_CustGameMonitoring_old_WinAmt]  DEFAULT ((0)) FOR [WinAmt]

END
ELSE
BEGIN
	PRINT 'Create Fail ! Exist Table WinLimit_CustGameMonitoring_old'
END

GO
/****** Object:  Table [dbo].[WinLimit_CustGameMonitoring_History_old]    Script Date: 10/28/2024 1:27:46 PM ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects o WITH (NOLOCK) WHERE o.type = 'U' AND o.name = 'WinLimit_CustGameMonitoring_History_old' )
BEGIN	
	CREATE TABLE [dbo].[WinLimit_CustGameMonitoring_History_old]
	(
		[LogID] [bigint] NOT NULL,
		[CustID] [int] NOT NULL,
		[ProductID] [tinyint] NOT NULL,
		[WinlostDate] [datetime] NOT NULL,
		[LevelID] [tinyint] NOT NULL,
		[MaxWinLimit] [money] NOT NULL,
		[TotalWinAmt] [money] NULL,
		[WinAmt] [money] NOT NULL,
		[ActionID] [tinyint] NOT NULL,
		[ModifiedDate] [datetime] NOT NULL,
		[IsNotified] [bit] NOT NULL,
		[ModifiedBy] [int] NULL,
		[CreatedBy] [int] NULL,
		[MaxWinLimitSetting] VARCHAR(MAX) NULL,
		[TotalWinAmt_RM] [money] NULL,
		[GroupID] [int] NOT NULL,
		[BettypeIDList] [varchar](1024) NULL,
		[TransID] [bigint] NULL,
	 CONSTRAINT [PK_WinLimit_CustGameMonitoring_History_old] PRIMARY KEY NONCLUSTERED 
	(
		[LogID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[WinLimit_CustGameMonitoring_History_old] ADD  CONSTRAINT [DF_WinLimit_CustGameMonitoring_History_old_MaxWinLimit]  DEFAULT ((0)) FOR [MaxWinLimit]

	ALTER TABLE [dbo].[WinLimit_CustGameMonitoring_History_old] ADD  CONSTRAINT [DF_WinLimit_CustGameMonitoring_History_old_TotalWinAmt]  DEFAULT ((0)) FOR [TotalWinAmt]

	ALTER TABLE [dbo].[WinLimit_CustGameMonitoring_History_old] ADD  CONSTRAINT [DF_WinLimit_CustGameMonitoring_History_old_WinAmt]  DEFAULT ((0)) FOR [WinAmt]

	ALTER TABLE [dbo].[WinLimit_CustGameMonitoring_History_old] ADD  CONSTRAINT [DF_WinLimit_CustGameMonitoring_History_old_ActionID]  DEFAULT ((0)) FOR [ActionID]
END
ELSE
BEGIN
	PRINT 'Create Fail ! Exist Table WinLimit_CustGameMonitoring_History_old'
END

GO

/****** Object:  Table [dbo].[VRAgentAutoAdjustment_old]    Script Date: 10/28/2024 1:27:46 PM ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects o WITH (NOLOCK) WHERE o.type = 'U' AND o.name = 'VRAgentAutoAdjustment_old' )
BEGIN	
	CREATE TABLE [dbo].[VRAgentAutoAdjustment_old](
	[AgentID] [int] NOT NULL,
	[Type] [tinyint] NOT NULL,
	[Status] [tinyint] NULL,
	[VR0_Date] [date] NULL,
	 CONSTRAINT [PK_VRAgentAutoAdjustment_old] PRIMARY KEY CLUSTERED 
	(
		[AgentID] ASC,
		[Type] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
	) ON [DATA]
END
ELSE
BEGIN
	PRINT 'Create Fail ! Exist Table VRAgentAutoAdjustment_old'
END

GO



/****** 

Check Table Created:

SELECT o.type_desc, o.name
FROM sys.objects o WITH (NOLOCK)
WHERE	o.type = 'U'
AND o.name IN ('CustPTTemplate_old' ,
		'CustPTTemplateDetail_old' ,
		'CustQRCode_old' ,
		'CustSuper_old' ,
		'CustSuperProfile_old' ,
		'VRCustSetting_old' ,
		'BetLimitControlCustSetting_old' ,
		'WinLimit_CustGameStatus_old' ,
		'VRCustLockStatus_old' ,
		'VRCustAutoAdjustment_old' ,
		'VRSettingManualUpdAcc_old' ,
		'RobotList_old' ,
		'WinLimit_CustGameMonitoring_old' ,
		'VRAgentAutoAdjustment_old' ,
		'BetSetting3rd_Member_old' ,
		'BetSetting3rd_Agent_old' ,
		'BetSetting_Member_old' ,
		'BetSetting_Agent_old',
		'WinLimit_CustGameMonitoring_History_old')
******/