/*
	Created: 20200623@Eden
	Task: Unblock add new cust [Redmine:128058]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO
UPDATE Site WITH(ROWLOCK)
SET BlockNewCust = 0,
	UnblockTime = NULL