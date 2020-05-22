/*
	Created: 20200423@Tiara
	Task: Unblock add new cust [Redmine: #130689]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO
UPDATE Site WITH(ROWLOCK)
SET BlockNewCust = 0,
	UnblockTime = NULL
