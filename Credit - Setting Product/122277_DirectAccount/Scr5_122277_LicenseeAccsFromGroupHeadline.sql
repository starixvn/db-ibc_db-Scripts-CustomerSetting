/*
	Created: 20191211@Winnie
	Task: Remove account from table CustGroupHeadline, CustAccount since they're licensee accounts. RedmineID:#122277_DirrectAccount
	DB: DBCust/CustDB
*/

UPDATE a
	SET a.GroupID=0
FROM CustGroupHeadline a WITH(ROWLOCK)
	INNER JOIN Customer c WITH(NOLOCK) ON a.CustID=c.CustID
WHERE c.Username IN('12BETRMB01','12BETCBankRMB')


DELETE a
FROM CustAccount a WITH(ROWLOCK)
	INNER JOIN Customer c WITH(NOLOCK) ON a.CustID=c.CustID
WHERE c.Username IN('12BETRMB01','12BETCBankRMB')
