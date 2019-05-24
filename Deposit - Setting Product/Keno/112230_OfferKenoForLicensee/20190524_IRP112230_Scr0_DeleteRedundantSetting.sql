/*
	Created: 20190524@Johnson
	Task: Delete redundant keno setting for customer 10185244
	DB: DBCUST/CustDB
*/

DELETE custsettinggame WITH(UPDLOCK,ROWLOCK)
WHERE custid = 10185244
	AND sporttype = 202
	AND bettype = 1502