/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20220325@Winfred
	Task : CRM - Write new Activity Log Special remarks renovation [redmine:#167941]
	DB: DBCRM/bodb_CRM
*/

USE [bodb_CRM]
GO

INSERT INTO dbo.crmLogAction(ActionID,SPName,ActionNameEN,IsInternal)
VALUES(601, 'Acc_CRM_CustomerRemarkNew_Ins','Create new Remark',0)
	,(602,'Acc_CRM_CustomerRemarkNew_Upd','Update Remark',0)
	,(603	,'Acc_CRM_CustomerRemarkNew_Del','Delete Remark',0)