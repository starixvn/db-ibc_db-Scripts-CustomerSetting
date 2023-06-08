/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20230523@Tacy
	Task: Insert new ActionID on table LogAction [redmine:#188025]
		https://nexdev.net/issues/188025
	DB: DBLOG.bodb_CustomerLog
*/
--LogAction
INSERT INTO LogAction ([ActionID], [ActionTypeID], [SPName], [ActionNameEN], [ActionNameCH], [ActionNameCS], [ActionNameJP], [ActionNameTH], [ActionNameKO], [IsInternal], [ActionNameVI])
VALUES
(20403,4,'EAS_AccountType_Ins','Mark Account Type','Mark Account Type','Mark Account Type','Mark Account Type','Mark Account Type','Mark Account Type',1,'Mark Account Type'),
(20404,4,'EAS_AccountType_Upd','Edit Account Type','Edit Account Type','Edit Account Type','Edit Account Type','Edit Account Type','Edit Account Type',1,'Edit Account Type'),
(20405,4,'EAS_AccountType_Del','Unmark Account Type','Unmark Account Type','Unmark Account Type','Unmark Account Type','Unmark Account Type','Unmark Account Type',1,'Unmark Account Type')