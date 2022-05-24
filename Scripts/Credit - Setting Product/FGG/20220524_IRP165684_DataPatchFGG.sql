/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Johnson
	Date: 20220524
	Task: Data patch for FGG- remove setting from CustDirectAccount for test accounts [RedmineID:#165684]
	DB: DBCust/CustDB
*/

DELETE ca
FROM CustDirectAccount ca WITH(ROWLOCK)
WHERE custid IN (15521829, 25099814)
	OR EXISTS (SELECT 1 FROM customer c WITH(NOLOCK) WHERE srecommend = 1176070--SuperTest1
			AND ca.custid = c.custid
			AND roleid <4)