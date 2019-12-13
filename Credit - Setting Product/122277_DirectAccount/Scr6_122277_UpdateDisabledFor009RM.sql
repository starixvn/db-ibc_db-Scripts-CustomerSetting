/*
	Created: 20191213@Winnie
	Task: Update Enable=0 for 009RM. RedmineID:#122277_DirrectAccount
	DB: DBCust/CustDB
*/

UPDATE custInfo WITH(ROWLOCK,UPDLOCK)
SET enabled=0
WHERE username='009RM'
