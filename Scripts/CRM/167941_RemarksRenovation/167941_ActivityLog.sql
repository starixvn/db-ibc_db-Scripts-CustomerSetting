/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20220325@Winfred
	Task : CRM - Write new Activity Log Special remarks renovation [redmine:#167941]
	DB: DBCRM/bodb_CRM
*/

USE [bodb_CRM]
GO
--DELETE FROM dbo.crmLogAction WHERE ActionID IN (601,602,603)
INSERT INTO dbo.crmLogAction(ActionID,SPName,ActionNameEN,IsInternal)
VALUES(601, 'Acc_CRM_CustomerRemarkNewIns','Create new Remark',0)
	,(602,'Acc_CRM_CustomerRemarkNewUpd','Update Remark',0)
	,(603	,'Acc_CRM_CustomerRemarkNewDel','Delete Remark',0)