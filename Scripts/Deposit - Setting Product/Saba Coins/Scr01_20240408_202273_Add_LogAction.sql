/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20240408@Tacy
	Task: insert new actionID into table LogAction [redmine:#202273]
	DB: DBLOG.bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

INSERT INTO LogAction 
 (ActionID,ActionTypeID,SPName,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
VALUES
 (2049,3,N'Dot_Dep_CustomerInsMember_Ag_Cust_Shadow',N'Add Bet Setting for member',N'Add Bet Setting for member',N'Add Bet Setting for member',N'Add Bet Setting for member',N'Add Bet Setting for member',N'Add Bet Setting for member',0,'Add Bet Setting for member')
,(2719,1,N'Dot_Dep_CustomerInsMember_Ag_Cust_Shadow',N'Add Position Taking for member',N'Add Position Taking for member',N'Add Position Taking for member',N'Add Position Taking for member',N'Add Position Taking for member',N'Add Position Taking for member',0,'Add Position Taking for member')
,(2421,4,N'Dot_Dep_CustomerInsMember_Ag_Cust_Shadow',N'Add the general information for member',N'Add the general information for member',N'Add the general information for member',N'Add the general information for member',N'Add the general information for member',N'Add the general information for member',0,'Add the general information for member')
,(2221,5,N'Dot_Dep_CustomerInsMember_Ag_Cust_Shadow',N'Add the initial statuses for member',N'Add the initial statuses for member',N'Add the initial statuses for member',N'Add the initial statuses for member',N'Add the initial statuses for member',N'Add the initial statuses for member',0,'Add the initial statuses for member')
GO
