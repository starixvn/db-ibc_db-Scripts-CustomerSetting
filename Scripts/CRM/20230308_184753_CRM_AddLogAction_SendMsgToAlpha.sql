/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20230308@Tacy
	Task: Insert ActionID on table LogAction [redmine:#184753]
		https://nexdev.net/issues/184753
	DB: DBLOG.bodb_CustomerLog
*/

INSERT INTO LogAction ([ActionID], [ActionTypeID], [SPName], [ActionNameEN], [ActionNameCH], [ActionNameCS], [ActionNameJP], [ActionNameIT], [ActionNameTH], [ActionNameKO], [IsInternal], [ActionNameVI], [ActionNameCN])
VALUES	 (1051,NULL,'Acc_CRM_MessageIns','Add new SMA message','Add new SMA message','Add new SMA message','Add new SMA message','Add new SMA message','Add new SMA message','Add new SMA message',1,'Add new SMA message','Add new SMA message')
		,(1052,NULL,'Acc_CRM_MessageUpd','Update SMA message','Update SMA message','Update SMA message','Update SMA message','Update SMA message','Update SMA message','Update SMA message',1,'Update SMA message','Update SMA message')
		,(1053,NULL,'Acc_CRM_MessageDel','Delete SMA message','Delete SMA message','Delete SMA message','Delete SMA message','Delete SMA message','Delete SMA message','Delete SMA message',1,'Delete SMA message','Delete SMA message')