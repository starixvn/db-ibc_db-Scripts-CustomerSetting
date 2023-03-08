/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20230308@Tacy
	Task: Insert ActionID on table LogAction [redmine:#184753]
		https://nexdev.net/issues/184753
	DB: DBLOG.bodb_CustomerLog
*/

INSERT INTO LogAction ([ActionID], [ActionTypeID], [SPName], [ActionNameEN], [ActionNameCH], [ActionNameCS], [ActionNameJP], [ActionNameIT], [ActionNameTH], [ActionNameKO], [IsInternal], [ActionNameVI], [ActionNameCN])
VALUES	 (6073,NULL,'Acc_CRM_MessageIns','Insert message','Insert message','Insert message','Insert message','Insert message','Insert message','Insert message',1,'Insert message','Insert message')
		,(6074,NULL,'Acc_CRM_MessageUpd','Update message','Update message','Update message','Update message','Update message','Update message','Update message',1,'Update message','Update message')
		,(6075,NULL,'Acc_CRM_MessageDel','Delete message','Delete message','Delete message','Delete message','Delete message','Delete message','Delete message',1,'Delete message','Delete message')