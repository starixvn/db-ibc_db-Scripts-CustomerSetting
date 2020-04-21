/*
	Created: 20200421@Tiara
	Task: Unblock add new cust [Redmine: #130678]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO
UPDATE Site_BlockNewCust WITH(ROWLOCK)
SET BlockNewCust = 0,
	UnblockTime = NULL
