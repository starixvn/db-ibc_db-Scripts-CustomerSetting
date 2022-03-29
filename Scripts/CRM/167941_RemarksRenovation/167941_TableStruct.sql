/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20220325@Winfred
	Task : CRM - Special remarks renovation [redmine:#167941]
	DB: DBCRM/bodb_CRM
*/

USE [bodb_CRM]
GO


ALTER TABLE crmCustomerRemark ADD RemarkTitle INT NULL
ALTER TABLE crmCustomerRemark ADD RelatedPICs  NVARCHAR(MAX) NULL
ALTER TABLE crmCustomerRemark ADD Handler   NVARCHAR(500) NULL
ALTER TABLE crmCustomerRemark ADD Ext   NVARCHAR(500) NULL
ALTER TABLE crmCustomerRemark ADD Requester NVARCHAR(500) NULL
ALTER TABLE crmCustomerRemark ADD Approver INT NULL
ALTER TABLE crmCustomerRemark ADD Acknowledger INT NULL
ALTER TABLE crmCustomerRemark ADD Updater INT NULL
ALTER TABLE crmCustomerRemark ADD LastUpdate DATETIME NULL
ALTER TABLE crmCustomerRemark ADD CreateDate DATETIME NULL
ALTER TABLE crmCustomerRemark ADD CreatorID INT NULL
