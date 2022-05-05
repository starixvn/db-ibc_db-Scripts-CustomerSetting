/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20220325@Winfred
	Task : CRM - Special remarks renovation index for PIC [redmine:#167941]
	DB: DBCRM/bodb_CRM
*/

USE [bodb_CRM]
GO

CREATE CLUSTERED INDEX [PK_crmPicManagement_CustID] ON [dbo].[crmPicManagement] 
(
	[CustID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO
