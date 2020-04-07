/*
    Created: Eden
    Date: 20200407
    Task: Update block add new cust - Unblock [#131758]
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO
UPDATE Site_BlockNewCust WITH(ROWLOCK)
SET BlockNewCust = 0	
	,UnblockTime = NULL
WHERE BlockNewCust = 1