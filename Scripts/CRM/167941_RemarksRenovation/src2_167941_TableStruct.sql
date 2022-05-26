/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20220325@Winfred
	Task : CRM - Special remarks renovation [redmine:#167941]
	DB: DBCRM/bodb_CRM
*/

USE [bodb_CRM]
GO

--DROP TABLE [dbo].[crmCustomerRemarkNew]
CREATE TABLE [dbo].[crmCustomerRemarkNew](
	[RemarkID] [INT] IDENTITY(1,1) NOT NULL,
	[CustID] [INT] NOT NULL,
	[Remark] [NVARCHAR](MAX) NULL,
	[RemarkTitle] [INT] NULL,
	[RelatedPICs]  [VARCHAR](1000) NULL,
	[Ext]	[INT] NULL,
	[HandlerID] [INT] NULL,
	[ApproverID] [INT] NULL,
	[AcknowledgerID] [INT] NULL,
	[Requester] [NVARCHAR](500) NULL,
	[ModifierID] [INT] NULL,
	[LastUpdate] [DATETIME] NULL,
	[CreatedDate] [DATETIME] NULL,
	[CreatorID] [INT] NULL,
    PRIMARY KEY (RemarkID)
) ON [DATA]
GO

CREATE NONCLUSTERED INDEX [IX_crmCustomerRemarkNew_CreatedDate] ON [dbo].[crmCustomerRemarkNew] 
(
	[CreatedDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

CREATE NONCLUSTERED INDEX [IX_crmCustomerRemarkNew_CustId] ON [dbo].[crmCustomerRemarkNew] 
(
	[CustID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO