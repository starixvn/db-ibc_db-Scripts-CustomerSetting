/*
	Created: 20200625@winfred
	Task: Update ProductStatusSiteCurrency [SapaGameSetting] RedmineID:#136210
	DB: DBCUST/CustDB
*/ 

--> Step 1 add config to block add new cust
DECLARE @UnblockTime VARCHAR(50) = '01:00 PM (GMT+8)' -- time unblock add new cust

UPDATE Site WITH(ROWLOCK)
SET BlockNewCust = 1,
	UnblockTime = @UnblockTime
WHERE siteid  = 487 -- IBCIndo

