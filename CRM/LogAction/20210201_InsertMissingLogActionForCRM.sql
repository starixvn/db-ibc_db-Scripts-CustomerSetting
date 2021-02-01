/*
	Created: 20210201@Johnson
	DB: DBCRM/bodb_CRM
	Task: insert missing log action (204) for CRM [redmine:#149205]
*/

INSERT INTO crmLogAction(ActionID,SPName,ActionNameEN,IsInternal,ExcludedForCn88,ActionTypeID)
SELECT 204,'Acc_CRM_UpdMultipleReviewAndStatus', N'Multiple Review and Update Status',0,NULL	,NULL

