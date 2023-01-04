/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20230104@Johnson
	Task:  RNG Keno/RNG Lottery/Table Game/Sports Lottery - Adjust bet limit for Credit market [redmine: #182389]
	DB: DBCUST/CustDB
*/
SELECT MAX(custid) FROM custinfo WITH(NOLOCK)