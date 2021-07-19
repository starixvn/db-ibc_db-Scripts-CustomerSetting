USE [bodb_CRM]
GO
/*
	Date: 2019-06-07
	Created: Elodie
	Task: ReCreate Index #112637
	DB: DB053/[bodb_CRM]
*/

/****** Object:  Index [IX_CRM_crmCustomer_UserName]    Script Date: 06/05/2019 15:03:11 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[crmFeedback]') AND name = N'IX_CRM_Feedback_FeedbackDate')
DROP INDEX [IX_CRM_Feedback_FeedbackDate] ON [dbo].[crmFeedback] WITH ( ONLINE = OFF )
GO

USE [bodb_CRM]
GO

CREATE NONCLUSTERED INDEX [IX_CRM_Feedback_FeedbackDate] ON [dbo].[crmFeedback]
(
	[FeedbackDate] ASC,
	[StatusID] ASC,
	[SiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [feedback_index]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[crmFeedback]') AND name = N'IX_CRM_Feedback_CustID')
DROP INDEX [IX_CRM_Feedback_CustID] ON [dbo].[crmFeedback] WITH ( ONLINE = OFF )
GO

USE [bodb_CRM]
GO

CREATE NONCLUSTERED INDEX [IX_CRM_Feedback_CustID] ON [dbo].[crmFeedback]
(
	[CustID] ASC
)
INCLUDE ([StatusID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [feedback_index]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[crmFeedbackCustomer]') AND name = N'IX_CRM_FeedbackCustomer_CustID')
DROP INDEX [IX_CRM_FeedbackCustomer_CustID] ON [dbo].[crmFeedbackCustomer] WITH ( ONLINE = OFF )
GO

USE [bodb_CRM]
GO

CREATE NONCLUSTERED INDEX [IX_CRM_FeedbackCustomer_CustID] ON [dbo].[crmFeedbackCustomer]
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [feedback_index]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[crmCustomerRemark]') AND name = N'IX_crmCustomerRemark_CustId')
DROP INDEX [IX_crmCustomerRemark_CustId] ON [dbo].[crmCustomerRemark] WITH ( ONLINE = OFF )
GO
CREATE NONCLUSTERED INDEX [IX_crmCustomerRemark_CustId] ON [dbo].[crmCustomerRemark]
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [customer_table]
GO