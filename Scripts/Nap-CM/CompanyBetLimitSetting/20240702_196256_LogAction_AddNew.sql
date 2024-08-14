/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20240702@Tacy
	Task: insert new actionID into table LogAction [redmine:#196256]
	DB: DBLOG.bodb_CustomerLog
*/
INSERT INTO LogAction 
		(ActionID,ActionTypeID,SPName,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
VALUES	(31770,NULL,N'NAP_GlobalStakeLevelGroup_Ins',N'Update global stake level group',N'Update global stake level group',N'Update global stake level group',N'Update global stake level group',N'Update global stake level group',N'Update global stake level group',1,'Update global stake level group')
	,	(31771,NULL,N'NAP_GlobalStakeLevelGroup_Del',N'Delete global stake level group',N'Delete global stake level group',N'Delete global stake level group',N'Delete global stake level group',N'Delete global stake level group',N'Delete global stake level group',1,'Delete global stake level group')
	,	(31777,NULL,N'NAP_CurrencyGroup_Ins',N'Add new currency group',N'Add new currency group',N'Add new currency group',N'Add new currency group',N'Add new currency group',N'Add new currency group',1,'Add new currency group')
	,	(31778,NULL,N'NAP_CurrencyGroup_Upd',N'Update currency group',N'Update currency group',N'Update currency group',N'Update currency group',N'Update currency group',N'Update currency group',1,'Update currency group')
	,	(31779,NULL,N'NAP_CurrencyGroup_Del',N'Remove currency from group',N'Remove currency from group',N'Remove currency from group',N'Remove currency from group',N'Remove currency from group',N'Remove currency from group',1,'Remove currency from group')
GO