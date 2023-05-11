/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20230509@Tacy
	Task: Update SP name [redmine:#187957]
		https://nexdev.net/issues/184753
	DB: DBLOG.bodb_CustomerLog
*/

UPDATE LogAction WITH (ROWLOCK, UPDLOCK)
SET SPName = CASE WHEN ActionID=1051 THEN 'Acc_CRM_PersonalMessageIns'
				  WHEN ActionID=1052 THEN 'Acc_CRM_PersonalMessageUpd'
									 ELSE 'Acc_CRM_PersonalMessageDel'
			END
WHERE ActionID BETWEEN 1051 AND 1053