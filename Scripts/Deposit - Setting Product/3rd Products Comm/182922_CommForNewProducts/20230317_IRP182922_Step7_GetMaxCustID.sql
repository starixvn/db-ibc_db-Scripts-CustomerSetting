/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230317@Johnson
	Task: initial comm setting for MaxGame,FGG,Jili for Real licensees
	DB: DBCust/CustDB
*/

SELECT MAX(custid) FROM custinfo WITH(NOLOCK)