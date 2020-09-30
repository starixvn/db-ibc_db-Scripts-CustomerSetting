/*
	Created: 2020930@Johnson
	Task: Set CustomerClass = NULL incase CustomerClass = - 1
	DB: DBCUST/CustDB
*/

--3 rows affect
SELECT custid 
INTO #tmp
FROM custinfo c WITH(NOLOCK)
WHERE CustomerClass = -1

UPDATE c 
SET CustomerClass = NULL
FROM custinfo c WITH(UPDLOCK,ROWLOCK)
WHERE custid IN (SELECT CustID FROM #tmp)