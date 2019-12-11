/*
	Created: 20191211@Winnie
	Task: Remove the setting that 271SD as a Group Headline. RedmineID:#122277_DirrectAccount
	DB: DBCust/CustDB
*/

UPDATE a
	SET a.GroupID=0
FROM CustGroupHeadline a WITH(ROWLOCK)
	INNER JOIN Customer c WITH(NOLOCK) ON a.CustID=c.CustID
WHERE c.Username='271SD'


