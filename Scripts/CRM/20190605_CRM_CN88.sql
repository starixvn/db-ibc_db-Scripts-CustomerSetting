USE [bodb_CRM]
GO
/*
	Date: 2019-06-05
	Created: Winnie
	Task: ReCreate Index #112637
	DB: DB053/[bodb_CRM]
*/
USE [bodb_CRM]
GO

/****** Object:  Index [IX_CRM_crmCustomer_UserName]    Script Date: 06/05/2019 15:03:11 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[crmCustomer]') AND name = N'IX_CRM_crmCustomer_UserName')
DROP INDEX [IX_CRM_crmCustomer_UserName] ON [dbo].[crmCustomer] WITH ( ONLINE = OFF )
GO

USE [bodb_CRM]
GO

/****** Object:  Index [IX_CRM_crmCustomer_UserName]    Script Date: 06/05/2019 15:03:11 ******/
CREATE NONCLUSTERED INDEX [IX_CRM_crmCustomer_UserName] ON [dbo].[crmCustomer] 
(
	[SiteID] ASC,
	[UserName] ASC	
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [customer_index]
GO


