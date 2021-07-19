/*
	Created: 20201125@Johnson
	Task: Database structure for TO Control auto FB service [redmine:#145274]
	DB: DBCRM/bodb_CRM
*/

USE [bodb_CRM]
GO

CREATE TABLE [dbo].[crmTOControlFeedbackInfo](
	[LogID] [int] NOT NULL,
	[CustID] [int] NOT NULL,
	[MatchID] [int] NOT NULL,
	[ProfileID] [int] NOT NULL,
	[HeadlineID] [int] NULL,
	[HeadlineName] [varchar](50) NULL,
	[RelatedCustID] [int] NULL,
	[ProfileName] [nvarchar](100) NULL,
	[BettypeList] [varchar](100) NULL,
	[EventInfo] [varchar](500) NULL,
	[Level] [tinyint] NULL,
	[TotalTurnover] [money] NULL,
	[MaxTurnover] [money] NULL,
	[HouseTurnover] [money] NULL,		
	[Status] [varchar](20) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedTime] [datetime] NULL,
	[Description] [varchar](1000) NULL,
	[RetryCount] [tinyint] NULL,
) ON [DATA]

GO


CREATE CLUSTERED INDEX [CIX_crmTOControlFeedbackInfo] ON [dbo].[crmTOControlFeedbackInfo] 
(	
	[LogID] ASC,	
	[CustID] ASC,	
	[Status] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

CREATE NONCLUSTERED INDEX [IX_CreatedDate] ON [dbo].[crmTOControlFeedbackInfo] 
(
	[CreatedDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

CREATE TABLE [dbo].[crmTOControlOutstandingInfo](
	[LogID] [int] NOT NULL,
	[CustID] [int] NULL,
	[MatchID] [int] NULL,
	[Outstanding] [money] NULL
 CONSTRAINT [PK_crmTOControlOutstandingInfo] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO
