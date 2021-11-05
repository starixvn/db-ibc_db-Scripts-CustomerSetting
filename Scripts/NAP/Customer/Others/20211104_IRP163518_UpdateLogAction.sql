/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20211104@Johnson
	Task: Update Log action 
	DB: DBLOG/bodb_CustomerLog
*/

UPDATE LogAction WITH(ROWLOCK)
SET ActionNameEN = N'Update Checked Status',
	ActionNameCH = N'Update Checked Status', 
	ActionNameCS = N'Update Checked Status',
	ActionNameJP = N'Update Checked Status',
	ActionNameIT = N'Update Checked Status',
	ActionNameTH = N'Update Checked Status',
	ActionNameKO = N'Update Checked Status',	
	ActionNameVI = N'Update Checked Status',
	ActionNameCN = N'Update Checked Status'
WHERE actionID = 1106