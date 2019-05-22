USE [bodb_CustomerLog]
GO

CREATE TABLE [dbo].[CS_UserLog_Credit](
	[LogID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[CustID] [int] NOT NULL,
	[SubAccID] [int] NOT NULL,
	[LogDate] [datetime] NOT NULL,
	[OldValue] [money] NULL,
	[NewValue] [money] NULL,
	[IP] [varchar](15) NULL,
	[Doing] [varchar](500) NULL,
	[ActionID] [int] NULL,
	[ActualRate] [float] NULL
) ON [ps_CS_CREDIT_monthly]([LogDate])

CREATE CLUSTERED INDEX [CIX_CS_UserLog_Credit] ON [dbo].[CS_UserLog_Credit]
(
	[LogDate] ASC,
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_CS_CREDIT_monthly]([LogDate])

ALTER TABLE [dbo].[CS_UserLog_Credit] ADD  CONSTRAINT [DF_CS_UserLog_Credit_LogDate]  DEFAULT (getdate()) FOR [LogDate]
GO

CREATE TABLE [dbo].[CS_UserLog_Login](
	[LogID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[RoleID] [tinyint] NOT NULL,
	[SubAccID] [int] NOT NULL,
	[ServerID] [int] NOT NULL,
	[IP] [varchar](15) NOT NULL,
	[LogDate] [datetime] NULL,
	[ActionID] [int] NULL,
	[Doing] [varchar](500) NULL,
	[DomainName] [nvarchar](255) NULL,
	[BrowserName] [nvarchar](255) NULL,
	[Platform] [nvarchar](255) NULL,
	[CountryCode] [varchar](64) NULL,
	[Duration] [int] NULL,
	[username2] [varchar](50) NULL
) ON [ps_CS_LOGIN_monthly]([LogDate])

CREATE CLUSTERED INDEX [CIX_CS_UserLog_Login] ON [dbo].[CS_UserLog_Login]
(
	[LogDate] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_CS_LOGIN_monthly]([LogDate])

ALTER TABLE [dbo].[CS_UserLog_Login] ADD  CONSTRAINT [DF_CS_UserLog_Login_LogDate]  DEFAULT (getdate()) FOR [LogDate]
GO

CREATE TABLE [dbo].[CS_UserLog_RunSP](
	[LogID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[LogDate] [datetime] NULL,
	[CustID] [int] NULL,
	[SubAccID] [int] NOT NULL,
	[ActionID] [int] NULL,
	[TrackingValue] [nvarchar](max) NULL,
	[Duration] [int] NULL,
	[TrackingValue2] [nvarchar](max) NULL
) ON [ps_CS_RUNSP_monthly]([LogDate])

CREATE CLUSTERED INDEX [CIX_CS_UserLog_RunSP] ON [dbo].[CS_UserLog_RunSP]
(
	[LogDate] ASC,
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_CS_RUNSP_monthly]([logdate])

ALTER TABLE [dbo].[CS_UserLog_RunSP] ADD  CONSTRAINT [DF_CS_UserLog_RunSP_LogDate]  DEFAULT (getdate()) FOR [LogDate]
GO

CREATE TABLE [dbo].[CS_UserLog_RunSP_MultiTarget](
	[LogID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[LogDate] [datetime] NULL,
	[ActionID] [int] NULL,
	[TrackingValue] [nvarchar](max) NULL,
	[Duration] [int] NULL,
	[TrackingValue2] [nvarchar](max) NULL,
	[MainLogID] [bigint]
) ON [ps_CS_RUNSP_monthly]([LogDate])

CREATE CLUSTERED INDEX [CIX_CS_UserLog_RunSP_MultiTarget] ON [dbo].[CS_UserLog_RunSP_MultiTarget]
(
	[LogDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_CS_RUNSP_monthly]([logdate])

CREATE NONCLUSTERED INDEX [IX_LogID] ON [dbo].[CS_UserLog_RunSP_MultiTarget]
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_CS_RUNSP_monthly]([logdate])

ALTER TABLE [dbo].[CS_UserLog_RunSP_MultiTarget] ADD  CONSTRAINT [DF_CS_UserLog_RunSP_MultiTarget_LogDate]  DEFAULT (getdate()) FOR [LogDate]
GO

CREATE TABLE [dbo].[CS_UserLog_RunSP_LogTarget](
	[LogID] [bigint] NOT NULL,
	[CustID] [int] NOT NULL
) ON [INDEX]

CREATE CLUSTERED INDEX [CIX_CS_UserLog_RunSP_LogTarget] ON [dbo].[CS_UserLog_RunSP_LogTarget]
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [INDEX]

CREATE NONCLUSTERED INDEX [IX_LogID] ON [dbo].[CS_UserLog_RunSP_LogTarget]
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [INDEX]
GO