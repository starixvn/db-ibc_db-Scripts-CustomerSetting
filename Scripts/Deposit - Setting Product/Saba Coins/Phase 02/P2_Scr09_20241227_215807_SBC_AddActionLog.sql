/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20241227@Tacy
	Task: insert new actionID into table LogAction [redmine:#215807]
	DB: DBLOG.bodb_CustomerLog
*/
INSERT INTO LogAction 
		(ActionID,ActionTypeID,SPName,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
VALUES	(271006,NULL,N'API_CustomerIns_SabaMapping',N'Associate a member with a SabaCoins wallet',N'Associate a member with a SabaCoins wallet',N'Associate a member with a SabaCoins wallet',N'Associate a member with a SabaCoins wallet',N'Associate a member with a SabaCoins wallet',N'Associate a member with a SabaCoins wallet',0,'Associate a member with a SabaCoins wallet')
GO