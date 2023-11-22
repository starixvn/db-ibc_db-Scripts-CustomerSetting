/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 2023108@Tacy
	Task: insert new actionID into table LogAction [redmine:#194024]
	DB: DBLOG.bodb_CustomerLog
*/
INSERT INTO LogAction 
		(ActionID,ActionTypeID,SPName,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
VALUES	(31773,NULL,N'NAP_Domain_Ins',N'Add new domain',N'Add new domain',N'Add new domain',N'Add new domain',N'Add new domain',N'Add new domain',0,'Add new domain'),
		(31774,NULL,N'NAP_Domain_Upd',N'Edit domain',	N'Edit domain',N'Edit domain',N'Edit domain',N'Edit domain',N'Edit domain',0,'Edit domain'),
		(31775,NULL,N'NAP_Domain_Del',N'Delete domain',N'Delete domain',N'Delete domain',N'Delete domain',N'Delete domain',N'Delete domain',0,'Delete domain')
GO