/*
	Created: 20200504@Eden
	Task: Unblock add new cust [Redmine: 132323]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO
UPDATE Site WITH(ROWLOCK)
SET BlockNewCust = 0,
	UnblockTime = NULL
