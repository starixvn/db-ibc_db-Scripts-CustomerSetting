/*
	Created: 20191211@Winnie
	Task: Unmark as Direct account for Agent 339BHK and Remove OLD-RM from CustDirectAccount table . RedmineID:#122277_DirrectAccount
	DB: DBCust/CustDB
*/

DELETE a
FROM CustDirectAccount a WITH(ROWLOCK)
	INNER JOIN Customer c WITH(NOLOCK) ON a.CustID=c.CustID
WHERE c.Username IN('339BHK','OLD-RM')


