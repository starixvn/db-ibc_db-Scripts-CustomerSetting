/*<info serverAlias="DBAGE-bodb02"></info>*/
/*
	Created: Elodie
	Date: 20240716
	Task: Create table CustLoginInfo, CustLoginInfo_Member, CustLoginInfoSub on DBAGE [RedmineID:#206738]
	DB: DBAGE-bodb02
*/
USE bodb02
GO

CREATE TABLE [dbo].[CustLoginInfo](
	[CustID] [int] NOT NULL,
	[OldUserPwd] [varchar](40) NULL,
	[LastChangedPwdDate] [datetime] NULL,
	[isFirstLogin] [bit] NULL,
	[SecurityCode] [varchar](50) NULL,
	[LastChangedSecurityCodeDate] [datetime] NULL,
	[SecurityCodeCount] [tinyint] NULL,
	[isLocked] [bit] NULL,
	[isForcedChangeSecurityCode] [bit] NULL,
	[VerifyOTPCount] [tinyint] NULL,
	[ClosedReason] [tinyint] NULL,
	[ProtectionCode] [varchar](30) NULL,
	[IsProtectedMode] [bit] NULL,
	[FunctionInfo] [tinyint] NULL,
	[LanguageUsage] [varchar](2) NULL,
 CONSTRAINT [PK_CustLoginInfo] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [table_customer]
) ON [table_customer]
GO

ALTER TABLE [dbo].[CustLoginInfo] ADD  CONSTRAINT [DF_CustLoginInfo_IsProtectedMode]  DEFAULT ((0)) FOR [IsProtectedMode]
GO

ALTER TABLE [dbo].[CustLoginInfo] ADD  CONSTRAINT [DF_CustLoginInfo_FunctionInfo]  DEFAULT ((0)) FOR [FunctionInfo]
GO
CREATE TABLE [dbo].[CustLoginInfoSub](
	[SubAccID] [int] NOT NULL,
	[CustID] [int] NOT NULL,
	[OldUserPwd] [varchar](40) NULL,
	[PwdExpiry] [datetime] NULL,
	[LastChangedPwdDate] [datetime] NULL,
	[isFirstLogin] [bit] NULL,
	[SecurityCode] [varchar](50) NULL,
	[LastChangedSecurityCodeDate] [datetime] NULL,
	[SecurityCodeCount] [tinyint] NULL,
	[isLocked] [bit] NULL,
	[isForcedChangeSecurityCode] [bit] NULL,
	[VerifyOTPCount] [tinyint] NULL,
	[ProtectionCode] [varchar](30) NULL,
	[FunctionInfo] [tinyint] NULL,
	[LanguageUsage] [varchar](2) NULL,
 CONSTRAINT [PK_CustLoginInfoSub] PRIMARY KEY CLUSTERED 
(
	[SubAccID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [table_customer]
) ON [table_customer]
GO

ALTER TABLE [dbo].[CustLoginInfoSub] ADD  CONSTRAINT [DF_CustLoginInfoSub_FunctionInfo]  DEFAULT ((0)) FOR [FunctionInfo]
GO

CREATE TABLE [dbo].[CustLoginInfo_Member](
	[CustID] [int] NOT NULL,
	[SecurityCode] [varchar](40) NULL,
	[IP] [varchar](15) NULL,
	[LastChangedID] [int] NULL,
	[LastChangedDate] [datetime] NULL,
	[OddsType] [tinyint] NULL,
	[LayoutMode] [tinyint] NOT NULL,
	[BetStake] [money] NULL,
	[DefaultLanguage] [varchar](4) NOT NULL,
	[OddsSort] [tinyint] NOT NULL,
	[BetterOdds] [bit] NOT NULL,
	[ShowLiveCasino] [bit] NOT NULL,
	[SportSort] [varchar](512) NULL,
	[CusStake1] [money] NULL,
	[CusStake2] [money] NULL,
	[ShowScoreMap] [bit] NULL,
	[ShowBanner] [int] NULL,
	[AutoRefresh] [bit] NULL,
	[MarketType] [tinyint] NULL,
	[AutoRefreshMatch] [bit] NULL,
	[MobileOthersType] [varchar](512) NULL,
	[gesture] [varchar](40) NULL,
	[failedcount] [tinyint] NULL,
	[lastlogged] [smalldatetime] NULL,
	[OddsColorStyle] [tinyint] NULL,
	[ClosedReason] [tinyint] NULL,
	[notify] [bit] NOT NULL,
	[recommendation] [bit] NOT NULL,
	[OddsStyle] [tinyint] NOT NULL,
	[ConfirmBet] [bit] NULL,
	[AfterBetNotification] [bit] NULL,
	[AppOtherTypes] [varchar](50) NULL,
	[AutoAcceptAnyOddsForParlayBets] [bit] NOT NULL,
	[QuickStakeString] [varchar](50) NULL,
	[NonSportSetting] [int] NOT NULL,
	[Theme] [tinyint] NULL,
 CONSTRAINT [PK_CustLoginInfo_Member] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [table_customer]
) ON [table_customer]
GO

ALTER TABLE [dbo].[CustLoginInfo_Member] ADD  CONSTRAINT [DF_CustLoginInfo_Member_LayoutMode]  DEFAULT ((2)) FOR [LayoutMode]
GO

ALTER TABLE [dbo].[CustLoginInfo_Member] ADD  CONSTRAINT [DF_CustLoginInfo_Member_BetStake]  DEFAULT ((-1)) FOR [BetStake]
GO

ALTER TABLE [dbo].[CustLoginInfo_Member] ADD  CONSTRAINT [DF_CustLoginInfo_Member_DefaultLanguage]  DEFAULT ((-1)) FOR [DefaultLanguage]
GO

ALTER TABLE [dbo].[CustLoginInfo_Member] ADD  CONSTRAINT [DF_CustLoginInfo_Member_OddsSort]  DEFAULT ((1)) FOR [OddsSort]
GO

ALTER TABLE [dbo].[CustLoginInfo_Member] ADD  CONSTRAINT [DF_CustLoginInfo_Member_BetterOdds]  DEFAULT ((1)) FOR [BetterOdds]
GO

ALTER TABLE [dbo].[CustLoginInfo_Member] ADD  CONSTRAINT [DF_CustLoginInfo_Member_ShowLiveCasino]  DEFAULT ((1)) FOR [ShowLiveCasino]
GO

ALTER TABLE [dbo].[CustLoginInfo_Member] ADD  CONSTRAINT [DF_CustLoginInfo_Member_CusStake1]  DEFAULT ((-1)) FOR [CusStake1]
GO

ALTER TABLE [dbo].[CustLoginInfo_Member] ADD  CONSTRAINT [DF_CustLoginInfo_Member_CusStake2]  DEFAULT ((-1)) FOR [CusStake2]
GO

ALTER TABLE [dbo].[CustLoginInfo_Member] ADD  CONSTRAINT [DF_CustLoginInfo_Member_MarketType]  DEFAULT ((0)) FOR [MarketType]
GO

ALTER TABLE [dbo].[CustLoginInfo_Member] ADD  CONSTRAINT [DF_CustLoginInfo_Member_notify]  DEFAULT ((1)) FOR [notify]
GO

ALTER TABLE [dbo].[CustLoginInfo_Member] ADD  CONSTRAINT [DF_CustLoginInfo_Member_recommendation]  DEFAULT ((1)) FOR [recommendation]
GO

ALTER TABLE [dbo].[CustLoginInfo_Member] ADD  CONSTRAINT [DF_CustLoginInfo_Member_OddsStyle]  DEFAULT ((1)) FOR [OddsStyle]
GO

ALTER TABLE [dbo].[CustLoginInfo_Member] ADD  CONSTRAINT [DF_CustLoginInfo_Member_AutoAcceptAnyOddsForParlayBets]  DEFAULT ((0)) FOR [AutoAcceptAnyOddsForParlayBets]
GO

ALTER TABLE [dbo].[CustLoginInfo_Member] ADD  CONSTRAINT [DF_CustLoginInfo_Member_NonSportSetting]  DEFAULT ((0)) FOR [NonSportSetting]
GO