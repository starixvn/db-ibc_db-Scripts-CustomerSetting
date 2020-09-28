/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200909
	Task:  Block add new cust [Joker] - Credit RedmineID:#131603
	DB: DBCust/CustDB
*/
--> Step 1 add config to block add new cust
PRINT N'Step 5: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
DECLARE @UnblockTime VARCHAR(50) = '11:20 AM (GMT+8)' -- time unblock add new cust

UPDATE Site WITH(ROWLOCK)
SET BlockNewCust = 1,
	UnblockTime = @UnblockTime
WHERE siteid NOT IN ( 3) -- 789y
PRINT N'Step 5: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 