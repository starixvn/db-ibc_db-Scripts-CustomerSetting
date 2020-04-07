/*
	Created: 20200406@Eden
	Task: Unblock add new cust [Redmine: #131363]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO
UPDATE Site_BlockNewCust WITH(ROWLOCK)
SET BlockNewCust = 0,
	UnblockTime = NULL
