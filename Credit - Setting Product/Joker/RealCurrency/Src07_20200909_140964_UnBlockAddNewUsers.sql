/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200909
	Task:  Unblock  add new cust [Joker] - Credit RedmineID:#140964
	DB: DBCust/CustDB
*/
--> Step 1 add config to block add new cust
PRINT N'Step 7: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

UPDATE Site WITH(ROWLOCK)
SET BlockNewCust = 0,
	UnblockTime = NULL
WHERE siteid not in (3) -- 789y	
PRINT N'Step 7: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
