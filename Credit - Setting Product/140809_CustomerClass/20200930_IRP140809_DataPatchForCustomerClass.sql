/*
	Created: 2020930@Johnson
	Task: Set CustomerClass = NULL incase CustomerClass = - 1
	DB: DBCUST/CustDB
*/

--3 rows affect
UPDATE c 
SET CustomerClass = NULL
FROM custinfo c WITH(UPDLOCK,ROWLOCK)
WHERE CustomerClass = -1