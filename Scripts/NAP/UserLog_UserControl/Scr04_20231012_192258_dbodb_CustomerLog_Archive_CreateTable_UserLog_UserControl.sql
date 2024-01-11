/*<info serverAlias="DBLOG-bodb_CustomerLog_Archive"></info>*/
/*
	Created by: Tacy@20231012
	Task: Archive table UserLog_UserControl
		https://nexdev.net/issues/192258
	DB: DBLOG-bodb_CustomerLog_Archive
*/
USE [bodb_CustomerLog_Archive]
GO

CREATE TABLE [dbo].[UserLog_UserControl](
	[LogID] [bigint] NOT NULL,
	[CustID] [int] NOT NULL,
	[LogDate] [datetime] NOT NULL,
	[UserID] [int] NOT NULL,
	[TypeID] [tinyint] NOT NULL,
	[ActionID] [int] NOT NULL,
	[Duration] [int] NOT NULL,
	[Doing] [nvarchar](max) NULL
) ON [ps_UserControl_monthly]([LogDate])
WITH
(
DATA_COMPRESSION = PAGE
)

CREATE CLUSTERED INDEX [CIX_UserLog_UserControl] ON [dbo].[UserLog_UserControl]
(
	[CustID] ASC,
	[LogDate] ASC,
	[ActionID] ASC,
	[TypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [ps_UserControl_monthly]([LogDate])
GO

CREATE NONCLUSTERED INDEX [IX_Logdate] ON [dbo].[UserLog_UserControl]
(
	[LogDate] ASC,
	[ActionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [ps_UserControl_monthly]([LogDate])
GO
