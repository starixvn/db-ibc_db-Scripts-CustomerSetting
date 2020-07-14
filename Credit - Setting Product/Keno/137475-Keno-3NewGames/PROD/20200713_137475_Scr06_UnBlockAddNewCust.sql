/*
	Created: 20200713@Eden
	Task: Unblock add new cust [Redmine:#137475]
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO
UPDATE Site WITH(ROWLOCK)
SET BlockNewCust = 0,
	UnblockTime = NULL

