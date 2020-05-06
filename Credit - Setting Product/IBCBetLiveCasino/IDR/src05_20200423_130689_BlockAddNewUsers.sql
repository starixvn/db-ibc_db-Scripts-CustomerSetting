/*
	Created: 20200423@Tiara
	Task: Block add new cust and restore DB - IDR [Redmine: #130689]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

--> Step 1 add config to block add new cust
DECLARE @UnblockTime VARCHAR(50) = '01:30 PM (GMT+8)' -- time unblock add new cust

UPDATE Site WITH(ROWLOCK)
SET BlockNewCust = 1,
	UnblockTime = @UnblockTime

--> Step 2 : Restore DB to DBNOTI.CustDB_AdjustCS
