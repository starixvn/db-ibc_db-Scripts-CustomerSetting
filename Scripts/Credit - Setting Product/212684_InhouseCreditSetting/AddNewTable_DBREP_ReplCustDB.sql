/*<info serverAlias="DBRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241105@Johnson	
	Task: Add new tables on DBRepl for credit setting [redmine:#212684]
	DB: DBRepl-ReplCustDB
*/
------------------------------------------------------------------------
--CustAgent
CREATE TABLE [dbo].[CustAgent](
	[custid] [int] NOT NULL,
	[MaxCredit] [money] NOT NULL,
	[IsInternal] [bit] NOT NULL,
	[TransferOption] [tinyint] NULL,
	[LimitPerIP] [tinyint] NOT NULL,
	[SelectedBetting] [bit] NOT NULL,
	[NicknameLoginOnly] [bit] NULL,
	[site] [varchar](10) NULL,
	[creationRemark] [nvarchar](300) NULL,
	[IsMonitorPT] [bit] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[IsSynced] [binary](2) NULL,
	[isDeleted] [bit] NULL,
 CONSTRAINT [PK_CustAgent] PRIMARY KEY CLUSTERED 
(
	[custid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[CustAgent] ADD  CONSTRAINT [DF_CustAgent_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

ALTER TABLE [dbo].[CustAgent] ADD  CONSTRAINT [DF_CustAgent_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

CREATE NONCLUSTERED INDEX [IX_CustAgent_RepUpdateTime] ON [dbo].[CustAgent]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO
------------------------------------------------------------------------

------------------------------------------------------------------------
--custInfo
CREATE TABLE [dbo].[custInfo](
	[username] [nvarchar](50) NULL,
	[custid] [int] NOT NULL,
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
	[MatchLimit] [smallmoney] NOT NULL,
	[VirtualMultiplier] [smallmoney] NOT NULL,
	[Enabled] [bit] NOT NULL,
	[danger] [tinyint] NOT NULL,
	[danger2] [tinyint] NOT NULL,
	[danger3] [tinyint] NOT NULL,
	[DisableOutright] [bit] NOT NULL,
	[Abnormal] [tinyint] NOT NULL,
	[DoubleCommLosing] [bit] NOT NULL,
	[autosuspend2] [bit] NULL,
	[DisableEsports] [bit] NULL,
	[DisableSuperLive] [bit] NULL,
	[DisableColossusBet] [bit] NULL,
	[HideColossusBet] [bit] NULL,
	[LockUpd] [bit] NULL,
	[BonusWalletFlag] [bit] NULL,
	[CreditUpdatedDate] [smalldatetime] NULL,
	[DangerLevel] [bigint] NULL,
	[CustomerClass] [smallint] NULL,
	[Danger4] [tinyint] NULL,
	[Danger5] [tinyint] NULL,
	[CCSoccer] [smallint] NULL,
	[CCBasketball] [smallint] NULL,
	[CCEsports] [smallint] NULL,
	[CCOtherSports] [smallint] NULL,
	[CCNonSports] [smallint] NULL,
	[autosuspend3] [bit] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NULL,
 CONSTRAINT [PK_custinfo] PRIMARY KEY CLUSTERED 
(
	[custid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[custInfo] ADD  CONSTRAINT [DF_custInfo_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

ALTER TABLE [dbo].[custInfo] ADD  CONSTRAINT [DF_custInfo_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

CREATE NONCLUSTERED INDEX [IX_custInfo_RepUpdateTime] ON [dbo].[custInfo]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO
------------------------------------------------------------------------

------------------------------------------------------------------------
----CustMaster
CREATE TABLE [dbo].[CustMaster](
	[custid] [int] NOT NULL,
	[DisableAutoMPT] [bit] NOT NULL,
	[IsInternal] [bit] NOT NULL,
	[TransferOption] [tinyint] NULL,
	[LimitPerIP] [tinyint] NOT NULL,
	[SelectedBetting] [bit] NOT NULL,
	[NicknameLoginOnly] [bit] NULL,
	[creationRemark] [nvarchar](300) NULL,
	[IsAllDayBalTransfer] [bit] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[IsSynced] [binary](2) NULL,
	[isDeleted] [bit] NULL,
 CONSTRAINT [PK_CustMaster] PRIMARY KEY CLUSTERED 
(
	[custid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[CustMaster] ADD  CONSTRAINT [DF_CustMaster_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

ALTER TABLE [dbo].[CustMaster] ADD  CONSTRAINT [DF_CustMaster_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

CREATE NONCLUSTERED INDEX [IX_CustMaster_RepUpdateTime] ON [dbo].[CustMaster]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO
------------------------------------------------------------------------

------------------------------------------------------------------------
----Customer
CREATE TABLE [dbo].[Customer](
	[custid] [int] IDENTITY(1,1) NOT NULL,
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
	[creator] [int] NOT NULL,
	[username] [varchar](30) NOT NULL,
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
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY NONCLUSTERED 
(
	[custid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [DF_Customer_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [DF_Customer_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

CREATE NONCLUSTERED INDEX [IX_Customer_RepUpdateTime] ON [dbo].[Customer]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO
------------------------------------------------------------------------

------------------------------------------------------------------------
----CustProductStatus
CREATE TABLE [dbo].[CustProductStatus](
	[CustID] [int] NOT NULL,
	[bitmapHasSynced] [binary](32) NOT NULL,
	[bitmapIsHidden] [binary](32) NOT NULL,
	[bitmapIsDisabled] [binary](32) NOT NULL,
	[SuspendInfo] [tinyint] NULL,
	[Locked] [tinyint] NULL,
	[CloseInfo] [tinyint] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NULL,
 CONSTRAINT [CIX_custid] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[CustProductStatus] ADD  CONSTRAINT [DF_CustProductStatus_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

ALTER TABLE [dbo].[CustProductStatus] ADD  CONSTRAINT [DF_CustProductStatus_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

CREATE NONCLUSTERED INDEX [IX_CustProductStatus_RepUpdateTime] ON [dbo].[CustProductStatus]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO
------------------------------------------------------------------------

------------------------------------------------------------------------
--custSub
CREATE TABLE [dbo].[custSub](
	[subaccid] [int] IDENTITY(1,1) NOT NULL,
	[custid] [int] NOT NULL,
	[username] [varchar](30) NULL,
	[userpwd] [varchar](40) NULL,
	[PageAccess] [varchar](50) NULL,
	[createdate] [datetime] NULL,
	[firstname] [nvarchar](50) NULL,
	[lastname] [nvarchar](50) NULL,
	[closed] [bit] NULL,
	[LoginCount] [tinyint] NOT NULL,
	[UserName2] [varchar](50) NULL,
	[NicknameLoginOnly] [bit] NULL,
	[IsAllDownline] [bit] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_custsub] PRIMARY KEY CLUSTERED 
(
	[subaccid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO
ALTER TABLE [dbo].[CustSub] ADD  CONSTRAINT [DF_CustSub_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

ALTER TABLE [dbo].[CustSub] ADD  CONSTRAINT [DF_CustSub_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

CREATE NONCLUSTERED INDEX [IX_CustSub_RepUpdateTime] ON [dbo].[CustSub]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO
------------------------------------------------------------------------


------------------------------------------------------------------------
--CustSuper
CREATE TABLE [dbo].[CustSuper](
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
	[maxNewMemPerDay] [smallint] NULL,
	[IsMyanmarOdds] [bit] NULL,
	[IsAllDayBalTransfer] [bit] NULL,
	[MaxMember] [int] NULL,
	[MaxMemberRemark] [nvarchar](300) NULL,
	[UplineId] [int] NULL,
	[CurrencyModifier] [smallmoney] NOT NULL,
	[IsAutoEnableADBMaster] [bit] NOT NULL,
	[SiteDBGroupID] [smallint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[IsSynced] [binary](2) NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_CustSuper] PRIMARY KEY CLUSTERED 
(
	[custid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO
ALTER TABLE [dbo].[CustSuper] ADD  CONSTRAINT [DF_CustSuper_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

ALTER TABLE [dbo].[CustSuper] ADD  CONSTRAINT [DF_CustSuper_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

CREATE NONCLUSTERED INDEX [IX_CustSuper_RepUpdateTime] ON [dbo].[CustSuper]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO
------------------------------------------------------------------------

