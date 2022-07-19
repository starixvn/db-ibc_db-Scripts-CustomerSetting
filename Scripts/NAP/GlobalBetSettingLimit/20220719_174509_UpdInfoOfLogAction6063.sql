/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20220719@Tacy
	Task: Update info of ActionID=6063 on table LogAction [redmine:#174509]
	DB: DBLOG.bodb_CustomerLog
*/

UPDATE la
SET [SPName]='Acc_InitializingGlobal_BetLimitIns'
, [ActionNameEN]='Update Global Bet Limit'
, [ActionNameCH]='Update Global Bet Limit'
, [ActionNameCS]='Update Global Bet Limit'
, [ActionNameJP]='Update Global Bet Limit'
, [ActionNameIT]='Update Global Bet Limit'
, [ActionNameTH]='Update Global Bet Limit'
, [ActionNameKO]='Update Global Bet Limit'
, [ActionNameVI]='Update Global Bet Limit'
, [ActionNameCN]='Update Global Bet Limit'
FROM LogAction la WITH (ROWLOCK, UPDLOCK)
WHERE ActionID=6063