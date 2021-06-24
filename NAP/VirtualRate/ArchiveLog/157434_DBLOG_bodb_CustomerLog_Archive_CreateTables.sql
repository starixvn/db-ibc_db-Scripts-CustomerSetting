USE [bodb_CustomerLog_Archive]
GO

--DROP TABLE dbo.VRCustLog

CREATE TABLE [dbo].[VRCustLog](
	[LogId] [bigint] IDENTITY(1,1) NOT NULL,
	[SportType] [smallint] NOT NULL,
	[CustID] [int] NOT NULL,
	[ActionID] [smallint] NULL,
	[TrackingValue1] [varchar](max) NOT NULL,
	[TrackingValue2] [varchar](max) NOT NULL,
	[UserID] [int] NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[Duration] [int] NOT NULL,
	[IP] [varchar](15) NULL
) ON [ps_VRLOG_monthly]([LogTime])
WITH
(
DATA_COMPRESSION = PAGE
)

CREATE CLUSTERED INDEX [CIX_CustID] ON [dbo].[VRCustLog]
(
	[CustID] ASC,
	[LogTime] ASC,
	[SportType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_VRLOG_monthly]([LogTime])
GO

