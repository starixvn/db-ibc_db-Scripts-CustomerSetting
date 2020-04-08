/*
	Created: 20200406@Eden
	Task: Block add new cust and restore DB [Redmine: #131363]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

--> Step 1 add config to block add new cust
DECLARE @UnblockTime VARCHAR(50) = '01:30 PM (GMT+8)' -- time unblock add new cust

UPDATE Site_BlockNewCust WITH(ROWLOCK)
SET BlockNewCust = 1,
	UnblockTime = @UnblockTime

--> Step 2 : Restore DB to DBOTI.CustDB_BackupSetting