/*
	Created: 20191211@Winnie
	Task: Update Enable for 009RM. RedmineID:#122277_DirrectAccount
	DB: DBCust/CustDB
*/

UPDATE custInfo WITH(ROWLOCK,UPDLOCK)
SET enabled=1
WHERE username='009RM'
