/*
	Created by: Johnson	
	Date: 20190401
	Task: update actiontype for SC cn88
	DB: DBLOG/bodb_CustomerLog
*/

UPDATE LogAction WITH(UPDLOCK,ROWLOCK)
SET ActionTypeID = 4
WHERE actionID IN (935,936)