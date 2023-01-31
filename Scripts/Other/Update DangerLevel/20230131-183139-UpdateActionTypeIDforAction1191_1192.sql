/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20230131@Tacy
	Task: Update ActionTypeID for ActionID: 1191-1192 [redmine:#183139]
	DB: DBLOG.bodb_CustomerLog
*/
UPDATE la
SET ActionTypeID=5
FROM LogAction la WITH (ROWLOCK, UPDLOCK)
WHERE ActionID IN (1191,1192)