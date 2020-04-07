/*
    Created: Eden
    Date: 20200407
    Task: Update block add new cust - for test [#131758]
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO
UPDATE Site_BlockNewCust WITH(ROWLOCK)
SET BlockNewCust = 1	
	,UnblockTime = '03:30 PM (GMT+8)'
WHERE siteid = 3 