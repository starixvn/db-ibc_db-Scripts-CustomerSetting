/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20240308@Tacy
	Task: Insert new ActionID on table LogAction [redmine:#201432]
		https://nexdev.net/issues/201432
	DB: DBLOG.bodb_CustomerLog
*/
--LogAction
INSERT INTO LogAction ([ActionID], [ActionTypeID], [SPName], [ActionNameEN], [ActionNameCH], [ActionNameCS], [ActionNameJP], [ActionNameTH], [ActionNameKO], [IsInternal], [ActionNameVI])
VALUES
 (709,'4',N'EAS_CustomerUpdSuperInfo_Multiple',N'Update Multiple Info Of Super',N'Update Multiple Info Of Super',N'Update Multiple Info Of Super',N'Update Multiple Info Of Super',N'Update Multiple Info Of Super',N'Update Multiple Info Of Super',1,'Update Multiple Info Of Super')
,(954,'4',N'Age_CustomerUpdPwd_Multiple',N'Reset Multiple Password Of Super',N'Reset Multiple Password Of Super',N'Reset Multiple Password Of Super',N'Reset Multiple Password Of Super',N'Reset Multiple Password Of Super',N'Reset Multiple Password Of Super',1,'Reset Multiple Password Of Super')
,(955,'4',N'Acc_CustomerUpdSecurityCode_Multiple',N'Reset Multiple Security Code Of Super',N'Reset Multiple Security Code Of Super',N'Reset Multiple Security Code Of Super',N'Reset Multiple Security Code Of Super',N'Reset Multiple Security Code Of Super',N'Reset Multiple Security Code Of Super',1,'Reset Multiple Security Code Of Super')
GO