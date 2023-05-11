/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20230509@Tacy
	Task: Insert ActionID on table crmLogAction [redmine:#187957]
		https://nexdev.net/issues/187957
	DB: DBCRM.bodb_CRM
*/

INSERT INTO crmLogAction ([ActionID], [SPName], [ActionNameEN], [IsInternal])
SELECT 1015, 'Acc_CRM_PersonalMessageIns', 'Add new SMA message', 0 
UNION
SELECT 1016, 'Acc_CRM_PersonalMessageUpd', 'Update SMA message', 0 
UNION
SELECT 1017, 'Acc_CRM_PersonalMessageDel', 'Delete SMA message', 0 