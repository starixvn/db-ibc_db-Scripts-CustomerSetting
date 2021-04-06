/*
	Created: 202010303@Winfred
	DB: DBCRM/bodb_CRM
	Task: Insert log action (107) for CRM [redmine:#147470]
*/

INSERT INTO crmLogAction(ActionID,SPName,ActionNameEN,IsInternal,ExcludedForCn88,ActionTypeID)
SELECT 107,'Acc_CRM_AmendmentNoti_MultiCustIns', N'Sync Multiple Related Customers',0,NULL	,NULL

