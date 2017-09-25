/*
Created: 20170925@Winnie
Task: CRM add new column RedmineID:#82040
DB: DBCRM.bodb_CRM
Revisions:

*/

USE bodb_CRM
GO

ALTER TABLE dbo.crmCustomer
ADD IntroducedBy NVARCHAR(50)