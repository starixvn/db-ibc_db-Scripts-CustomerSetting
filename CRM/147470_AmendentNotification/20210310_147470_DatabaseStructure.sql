/*
	Created: Winfred
	Task : Database structure for Amendment Notification  CRM [redmine:#147470]
	DB: DBCRM/bodb_CRM
*/



USE [bodb_CRM]
GO

CREATE TABLE [dbo].[crmAmendmentNotiFeedbackInfo](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[TicketEventId] [int] NULL,
	[HeadlineID] [int] NULL,
	[HeadlineName] [varchar](50) NULL,
	[ProductID] [tinyint] NULL,
	[RetryCount] [tinyint] NULL,
	[affectedId] [varchar](max) NULL,
	[affectedName] [varchar](max) NULL,
	[UpdatedTime] [datetime] NULL,
	[Status] [varchar](20) NULL,
	[MatchId] [int] NULL,
	[MatchCode] [nvarchar](100) NULL,
	[EventType] [tinyint] NULL,
	[ActualResult] [nvarchar](max) NULL,
	[WrongResult] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[Listbettype] [varchar](max) NULL
) ON [DATA]

GO

CREATE CLUSTERED INDEX [CIX_crmAmendmentNotiFeedbackInfo] ON [dbo].[crmAmendmentNotiFeedbackInfo] 
(
	[LogID] ASC,
	[TicketEventId] ASC,
	[HeadlineID] ASC,
	[Status] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

CREATE NONCLUSTERED INDEX [IX_CreatedDate] ON [dbo].[crmAmendmentNotiFeedbackInfo] 
(
	[CreatedDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO


CREATE TABLE [dbo].[crmCustAmendment](
	[TicketId] [int] NOT NULL,
	[CustId] [int] NULL,
	[HeadlineID] [int] NULL,
	[LogID] [int] NULL,
	[TicketEventId] [int] NULL,
	[CreateDate] [datetime] NULL,
	[Bettype] [smallint] NULL,
 CONSTRAINT [PK_crmCustAmendment] PRIMARY KEY CLUSTERED 
(
	[TicketId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO
