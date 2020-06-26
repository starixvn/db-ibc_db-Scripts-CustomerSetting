/*
	Created: 20200623@Eden
	Task: Block add new cust and restore DB - HKK, HK$ [Redmine: 128058]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

--> Step 1 add config to block add new cust
DECLARE @UnblockTime VARCHAR(50) = '03:15 PM (GMT+8)' -- time unblock add new cust

UPDATE Site WITH(ROWLOCK)
SET BlockNewCust = 1,
	UnblockTime = @UnblockTime
WHERE site IN(	'222223'
				,'222227'
				,'611111'
				,'722222'
				,'733333'
				,'BEST-ODDS'
				,'XYZBET'
				)

--> Step 2 : Restore DB to DBNOTI.CustDB_AdjustCS