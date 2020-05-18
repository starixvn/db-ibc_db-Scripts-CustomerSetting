/*
	Created: Eden
	Date: 20200518
	Task: Block add new cust [Redmine: 132323]
	DB: DBCust/CustDB
*/
USE CustDB
GO

--> Step 1 add config to block add new cust
DECLARE @UnblockTime VARCHAR(50) = '10:30 PM (GMT+8)' -- time unblock add new cust

UPDATE Site WITH(ROWLOCK)
SET BlockNewCust = 1,
	UnblockTime = @UnblockTime
