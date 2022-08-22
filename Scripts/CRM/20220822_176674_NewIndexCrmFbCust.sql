/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20220822@Winfred
	Task :	 CRM - enhance code to avoid timeout issue RedmineID: #112637
	DB:		 DBCRM/bodb_CRM
*/



USE [bodb_CRM]
GO
	
DROP INDEX [IX_CRM_FeedbackCustomer_CustID] ON [dbo].[crmFeedbackCustomer]
GO
CREATE NONCLUSTERED INDEX IX_CRM_FeedbackCustomer_CustID ON crmFeedbackCustomer(CustID) INCLUDE (IsRelated) 
GO
