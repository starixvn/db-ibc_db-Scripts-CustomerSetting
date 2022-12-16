/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
USE bodb_CRM
GO

/*
	Created: 20221123@Winfred
	DB: DBCRM.bodb_CRM
	Task:  Create table feadback Archiving Dormant Accounts
	Revisions:
		- 20221123@Winfred:  Create table feadback Archiving Dormant Accounts [RedmineID: #158258]
*/

--DROP TABLE [dbo].[crmArchiveAccountFeedbackInfo]
--DROP TABLE [dbo].[crmArchivedAccount]

CREATE TABLE [dbo].[crmArchivedAccount](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[LogFeedbackId] [int]  NULL,
	[CustId] [int] NULL,
	[ArchivedDate] [date] NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK_crmArchivedAccount] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]

GO

CREATE TABLE [dbo].[crmServiceFeedbackInfo](
	[LogFeedbackId] [int] IDENTITY(1,1) NOT NULL,
	[HeadlineID] [int] NULL,
	[HeadlineName] [varchar](50) NULL,
	[RetryCount] [tinyint] NULL,
	[AffectedId] [varchar](max) NULL,
	[AffectedName] [varchar](max) NULL,
	[ArchivedDate] [date] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[Status] [varchar](20) NULL,
	[Description] [varchar](1000) NULL,
	[Environment] [varchar](20) NULL,
	[ServiceID] [tinyint] NULL,
) ON [DATA]

GO

CREATE CLUSTERED INDEX [CIX_crmServiceFeedbackInfo] ON [dbo].[crmServiceFeedbackInfo] 
(
	[LogFeedbackId] ASC,
	[Status] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO