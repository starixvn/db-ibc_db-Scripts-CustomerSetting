/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20220325@Winfred
	Task : CRM - Special remarks renovation history [redmine:#167941]
	DB: DBCRM/bodb_CRM
*/

USE [bodb_CRM]
GO

--DROP TABLE [dbo].[crmCustomerRemarkHistory]
CREATE TABLE [dbo].[crmCustomerRemarkHistory](
	[RemarkID] [INT],
	[CustID] [INT] NOT NULL,
	[Logdata] [NVARCHAR](MAX) NULL,
	[UpdaterID] [INT] NULL,
	[LastUpdate] [DATETIME] NULL
) ON [DATA]
GO

CREATE CLUSTERED INDEX [PK_crmCustomerRemarkHistory] ON [dbo].[crmCustomerRemarkHistory] 
(
	[RemarkID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

CREATE NONCLUSTERED INDEX [IX_crmCustomerRemarkHistory_CreatedDate] ON [dbo].[crmCustomerRemarkHistory] 
(
	[LastUpdate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO
