/*
	Created: 20191211@Winnie
	Task: Remove Headline role for Master account and remove from Direct Account table. RedmineID:#122277_DirrectAccount
	DB: DBCust/CustDB
*/
-- CASE #2

CREATE TABLE #tmp(CustID INT)
INSERT INTO #tmp(CustID)
SELECT CustID
FROM Customer WITH(NOLOCK) WHERE Username IN('M195RMB','M46RM','M68RMB','MJHK','MYKRM','ATUS','AWC','BMW1','MMYBSD','S33R91')

DELETE a
FROM CustGroupHeadline a WITH(ROWLOCK)
	INNER JOIN #tmp t ON a.CustID=t.CustID
	
DELETE a
FROM CustAccount a WITH(ROWLOCK)
	INNER JOIN #tmp t ON a.CustID=t.CustID	
	
DELETE a
FROM CustDirectAccount a WITH(ROWLOCK)
	INNER JOIN #tmp t ON a.CustID=t.CustID
