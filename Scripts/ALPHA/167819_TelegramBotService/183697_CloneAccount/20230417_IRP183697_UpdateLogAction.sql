/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20230417@Johnson
	Task: update log action for clone account from telegram chatbot [#RedmineID:#183697]
	DB: DBLOG/bodb_CustomerLog
*/

UPDATE LogAction WITH(UPDLOCK)
SET spName = 'Acc_CustomerInsMember_CloneSetting_MAg'
WHERE ActionID IN (629, 95081, 95082)

UPDATE LogAction WITH(UPDLOCK)
SET spName = 'Acc_CustomerInsMember_CloneSetting_SAg'
WHERE ActionID IN (630, 95079, 95080)
                 