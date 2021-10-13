/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20210908@Winfred
	Task : Database structure for voiding settle Amendment Notification CRM [redmine:#157481]
	DB: DBCRM/bodb_CRM
*/
USE [bodb_CRM]
GO
--DROP TABLE [dbo].[crmAutoFBVoiding]
--DROP TABLE [dbo].[crmAutoEventVoiding]
CREATE TABLE [dbo].[crmAutoFBVoiding](
	[LogVoidingID] [int] IDENTITY(1,1) NOT NULL,
	[MessageId] [int] NOT NULL,
	[HeadlineID] [int] NULL,
	[HeadlineName] [varchar](50) NULL,
	[ProductID] [varchar](max) NULL,
	[RetryCount] [tinyint] NULL,
	[affectedId] [varchar](max) NULL,
	[affectedName] [varchar](max) NULL,
	[ListMsgTargetId] [varchar](max) NULL,
	[Listbettype] [varchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedTime] [datetime] NULL,
	[Status] [varchar](20) NULL,
	[Description] [varchar](1000) NULL,
	[Environment] [varchar](20) NULL
) ON [DATA]

GO

CREATE CLUSTERED INDEX [CIX_crmAutoFBVoiding] ON [dbo].[crmAutoFBVoiding] 
(
	[LogVoidingID] ASC,
	[HeadlineID] ASC,
	[Status] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

CREATE NONCLUSTERED INDEX [IX_CreatedDate] ON [dbo].[crmAutoFBVoiding] 
(
	[CreatedDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

CREATE NONCLUSTERED INDEX [IX_TicketEventId] ON [dbo].[crmAutoFBVoiding] 
(
	[MessageId] ASC,
	[HeadlineID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO


CREATE TABLE [dbo].[crmAutoEventVoiding](
	[LogEventID] [int] IDENTITY(1,1) NOT NULL,
	[LogVoidingID] [int] NOT NULL,
	[MatchId] [int] NULL,
	[MatchCode] [nvarchar](max) NULL,
	[EventType] [tinyint] NULL,
	[EventDate] [datetime] NULL,
	[ProductID] [tinyint] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_crmAutoEventVoiding] PRIMARY KEY CLUSTERED 
(
	[LogEventID] ASC,
	[LogVoidingID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO

