/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20220325@Winfred
	Task : CRM - Special remarks renovation [redmine:#167941]
	DB: DBCRM/bodb_CRM
*/

USE [bodb_CRM]
GO

TRUNCATE TABLE crmCustomerRemarkNew
GO

TRUNCATE TABLE crmCustomerRemarkHistory
GO

DBCC CHECKIDENT ('crmCustomerRemarkNew', RESEED, 0);
GO

