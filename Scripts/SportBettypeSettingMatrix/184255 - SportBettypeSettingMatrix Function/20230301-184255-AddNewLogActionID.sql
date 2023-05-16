/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20230301@Tacy
	Task: Insert ActionID on table LogAction [redmine:#184255]
	DB: DBLOG.bodb_CustomerLog
*/

INSERT INTO LogAction ([ActionID], [ActionTypeID], [SPName], [ActionNameEN], [ActionNameCH], [ActionNameCS], [ActionNameJP], [ActionNameIT], [ActionNameTH], [ActionNameKO], [IsInternal], [ActionNameVI], [ActionNameCN])
VALUES	 (6064,NULL,'Acc_ReferenceSetting_Ins','Insert SportBettypeSettingMatrix','Insert SportBettypeSettingMatrix','Insert SportBettypeSettingMatrix','Insert SportBettypeSettingMatrix','Insert SportBettypeSettingMatrix','Insert SportBettypeSettingMatrix','Insert SportBettypeSettingMatrix',1,'Insert SportBettypeSettingMatrix','Insert SportBettypeSettingMatrix')
		,(6065,NULL,'Acc_ReferenceSetting_Upd','Update SportBettypeSettingMatrix','Update SportBettypeSettingMatrix','Update SportBettypeSettingMatrix','Update SportBettypeSettingMatrix','Update SportBettypeSettingMatrix','Update SportBettypeSettingMatrix','Update SportBettypeSettingMatrix',1,'Update SportBettypeSettingMatrix','Update SportBettypeSettingMatrix')
		,(6066,NULL,'Acc_ReferenceSetting_Del','Delete SportBettypeSettingMatrix','Delete SportBettypeSettingMatrix','Delete SportBettypeSettingMatrix','Delete SportBettypeSettingMatrix','Delete SportBettypeSettingMatrix','Delete SportBettypeSettingMatrix','Delete SportBettypeSettingMatrix',1,'Delete SportBettypeSettingMatrix','Delete SportBettypeSettingMatrix')
