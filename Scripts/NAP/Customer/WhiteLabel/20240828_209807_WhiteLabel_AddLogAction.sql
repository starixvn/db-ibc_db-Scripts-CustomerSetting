/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20240828@Tacy
	Task: insert new actionID into table LogAction [redmine:#209807]
	DB: DBLOG.bodb_CustomerLog
*/
INSERT INTO LogAction 
		(ActionID,ActionTypeID,SPName,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
VALUES	(710,4,N'Acc_WhiteLabelSetting_Ins',N'Add new White Label rate',N'Add new White Label rate',N'Add new White Label rate',N'Add new White Label rate',N'Add new White Label rate',N'Add new White Label rate',1,'Add new White Label rate')
	,	(711,4,N'Acc_WhiteLabelSetting_Upd',N'Update White Label rate',N'Update White Label rate',N'Update White Label rate',N'Update White Label rate',N'Update White Label rate',N'Update White Label rate',1,'Update White Label rate')
	,	(712,4,N'Acc_WhiteLabelSetting_UpdGroup',N'Update group headline',N'Update group headline',N'Update group headline',N'Update group headline',N'Update group headline',N'Update group headline',1,'Update group headline')

GO