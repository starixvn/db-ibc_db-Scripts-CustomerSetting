/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20241002@Tacy
	Task: insert new actionID into table LogAction [redmine:#211405]
	DB: DBLOG.bodb_CustomerLog
*/
INSERT INTO LogAction 
		(ActionID,ActionTypeID,SPName,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
VALUES	(6067,NULL,N'Age_CustomerUpdSynced',N'Synchronized into Nova Casino',N'Synchronized into Nova Casino',N'Synchronized into Nova Casino',N'Synchronized into Nova Casino',N'Synchronized into Nova Casino',N'Synchronized into Nova Casino',1,'Synchronized into Nova Casino')
GO