/*
	Created: 20200625@winfred
	Task: Unblock add new cust [Redmine: 136210]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO
UPDATE Site WITH(ROWLOCK)
SET BlockNewCust = 0,
	UnblockTime = NULL
WHERE siteid  = 487 -- IBCIndo