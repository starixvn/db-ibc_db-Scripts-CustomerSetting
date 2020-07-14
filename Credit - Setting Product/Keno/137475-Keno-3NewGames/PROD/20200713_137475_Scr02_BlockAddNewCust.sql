/*
	Created: 20200713@Eden
	Task: Block add new cust and restore DB [Redmine:#137475]
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO
--> Step 1 add config to block add new cust
DECLARE @UnblockTime VARCHAR(50) = '03:15 PM (GMT+8)' -- time unblock add new cust

UPDATE Site WITH(ROWLOCK)
SET BlockNewCust = 1,
	UnblockTime = @UnblockTime

--> Step 2 : Restore DB to DBNOTI.CustDB_AdjustCS
