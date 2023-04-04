/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20221027@Tacy
	Task: Insert new ActionID on table LogAction [redmine:#171247]
	DB: DBLOG.bodb_CustomerLog
*/

INSERT INTO LogAction ([ActionID], [ActionTypeID], [SPName], [ActionNameEN], [ActionNameCH], [ActionNameCS], [ActionNameJP], [ActionNameIT], [ActionNameTH], [ActionNameKO], [IsInternal], [ActionNameVI], [ActionNameCN])
VALUES	 (6100,4,'Acc_ManageAPI_Ins','Created API key','Created API key','Created API key','Created API key','Created API key','Created API key','Created API key',0,'Created API key','Created API key')
		,(6101,4,'Acc_ManageAPI_Upd','Edited API key','Edited API key','Edited API key','Edited API key','Edited API key','Edited API key','Edited API key',0,'Edited API key','Edited API key')
		,(6102,4,'Acc_ManageAPI_Del','Revoked API key','Revoked API key','Revoked API key','Revoked API key','Revoked API key','Revoked API key','Revoked API key',0,'Revoked API key','Revoked API key')
