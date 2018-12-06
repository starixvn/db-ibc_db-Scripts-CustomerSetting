/*
	Created by: Louis
	Date: 2018-12-06
	Task: Credit Collection Summary [Redmine:#98621]	
	DB: DBLOG/bodb_CustomerLog
*/

USE bodb_CustomerLog
GO

INSERT INTO LogAction(ActionID, ActionTypeID, SPName, ActionNameEN, ActionNameCH, ActionNameCS, ActionNameJP, ActionNameIT, ActionNameTH, ActionNameKO, XsltContent, IsInternal, ActionNameVI)
VALUES (1166, 5, 'Acc_CreditCollStatusInit', 'Set default Collection Status', 'Set default Collection Status', 'Set default Collection Status', 'Set default Collection Status', 'Set default Collection Status', 'Set default Collection Status', 'Set default Collection Status', NULL, 1, 'Set default Collection Status')


INSERT INTO LogAction(ActionID, ActionTypeID, SPName, ActionNameEN, ActionNameCH, ActionNameCS, ActionNameJP, ActionNameIT, ActionNameTH, ActionNameKO, XsltContent, IsInternal, ActionNameVI)
VALUES (1167, 5, 'Acc_CreditCollStatusUpd_CreditTerm', 'Change Collection Status', 'Change Collection Status', 'Change Collection Status', 'Change Collection Status', 'Change Collection Status', 'Change Collection Status', 'Change Collection Status', NULL, 1, 'Change Collection Status')
	

INSERT INTO LogAction(ActionID, ActionTypeID, SPName, ActionNameEN, ActionNameCH, ActionNameCS, ActionNameJP, ActionNameIT, ActionNameTH, ActionNameKO, XsltContent, IsInternal, ActionNameVI)
VALUES (1168, 5, 'Acc_CreditCollStatusUpd', 'Change Collection Status from NAP CM', 'Change Collection Status from NAP CM', 'Change Collection Status from NAP CM', 'Change Collection Status from NAP CM', 'Change Collection Status from NAP CM', 'Change Collection Status from NAP CM', 'Change Collection Status from NAP CM', NULL, 1, 'Change Collection Status from NAP CM')
