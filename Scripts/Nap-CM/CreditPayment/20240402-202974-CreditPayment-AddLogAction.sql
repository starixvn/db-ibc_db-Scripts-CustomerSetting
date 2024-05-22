/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20240402@Tacy
	Task: insert new actionID into table LogAction [redmine:#202974]
	DB: DBLOG.bodb_CustomerLog
*/
INSERT INTO LogAction 
		(ActionID,ActionTypeID,SPName,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
VALUES	(31776,NULL,N'NAP_PayoutPromotion_Upd',N'Update Payout Status',N'Update Payout Status',N'Update Payout Status',N'Update Payout Status',N'Update Payout Status',N'Update Payout Status',0,'Update Payout Status')
GO
