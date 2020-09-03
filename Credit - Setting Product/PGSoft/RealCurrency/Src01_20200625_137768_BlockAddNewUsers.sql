/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200805
	Task:  Block add new cust [PG Game] RedmineID:#137763
	DB: DBCust/CustDB
*/
--> Step 1 add config to block add new cust
DECLARE @UnblockTime VARCHAR(50) = '3:30 PM (GMT+8)' -- time unblock add new cust

UPDATE Site WITH(ROWLOCK)
SET BlockNewCust = 1,
	UnblockTime = @UnblockTime
WHERE siteid  in ( 3,11,22,35,487) -- 789y,INDO,755555,KORIBC,IBCIndo