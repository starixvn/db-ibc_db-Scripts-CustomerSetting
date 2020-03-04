USE [bodb_CustomerLog_Archive]
GO

--DROP TABLE dbo.UserLog_RunSP_LogTarget
--DROP TABLE dbo.UserLog_RunSP_MultiTarget

CREATE TABLE [dbo].[UserLog_RunSP_MultiTarget](
	[LogID] [bigint] NOT NULL,
	[UserID] [int] NULL,
	[LogDate] [datetime] NULL,
	[ActionID] [int] NULL,
	[TrackingValue] [nvarchar](max) NULL,
	[Duration] [int] NULL,
	[TrackingValue2] [nvarchar](max) NULL,
	[MainLogID] [bigint]
) ON [ps_RUNSPM_monthly]([LogDate])
WITH
(
DATA_COMPRESSION = PAGE
)

CREATE CLUSTERED INDEX [CIX_UserLog_RunSP_MultiTarget] ON [dbo].[UserLog_RunSP_MultiTarget]
(
	[LogDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [ps_RUNSPM_monthly]([logdate])

CREATE NONCLUSTERED INDEX [IX_LogID] ON [dbo].[UserLog_RunSP_MultiTarget]
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [ps_RUNSPM_monthly]([logdate])

ALTER TABLE [dbo].[UserLog_RunSP_MultiTarget] ADD  CONSTRAINT [DF_UserLog_RunSP_MultiTarget_LogDate]  DEFAULT (getdate()) FOR [LogDate]
GO

--[dbo].[UserLog_RunSP_LogTarget]
CREATE TABLE [dbo].[UserLog_RunSP_LogTarget](
	[LogID] [bigint] NOT NULL,	
	[CustID] [int] NOT NULL,
	[LogDate] [datetime] NULL
) ON [ps_RUNSPM_monthly]([LogDate])
WITH
(
DATA_COMPRESSION = PAGE
)

CREATE CLUSTERED INDEX [CIX_UserLog_RunSP_LogTarget] ON [dbo].[UserLog_RunSP_LogTarget]
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [ps_RUNSPM_monthly]([logdate])

CREATE NONCLUSTERED INDEX [IX_LogID] ON [dbo].[UserLog_RunSP_LogTarget]
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE) ON [ps_RUNSPM_monthly]([logdate])
GO