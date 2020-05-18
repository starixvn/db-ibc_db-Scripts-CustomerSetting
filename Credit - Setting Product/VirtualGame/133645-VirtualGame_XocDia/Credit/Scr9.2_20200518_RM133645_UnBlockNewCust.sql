/*
	Created: Eden
	Date: 20200518
	Task: Unblock add new cust [Redmine: 132323]
	DB: DBCust/CustDB
*/
USE CustDB
GO
UPDATE Site WITH(ROWLOCK)
SET BlockNewCust = 0,
	UnblockTime = NULL
