/*
	Created: 20210201@Johnson
	Task: change datatype for column Remark on table Acc_CRM_InformHeadlineUpd [redmine:#149364]
	DB: DBCRM/bodb_CRM
*/

ALTER TABLE crmInformHeadline_New ALTER COLUMN Remark NVARCHAR(MAX)