/*
	Created: 20200713@Elodie	
	Task: Unblock add new cust [Redmine: 137256]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO
UPDATE Site WITH(ROWLOCK)
SET BlockNewCust = 0,
	UnblockTime = NULL
WHERE siteid = 487