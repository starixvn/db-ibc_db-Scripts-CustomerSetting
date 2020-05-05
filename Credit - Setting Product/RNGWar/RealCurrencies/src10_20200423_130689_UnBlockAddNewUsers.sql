/*
	Created: 20200505@Tiara
	Task: Unblock add new cust [Redmine: #132018]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO
UPDATE Site_BlockNewCust WITH(ROWLOCK)
SET BlockNewCust = 0,
	UnblockTime = NULL
