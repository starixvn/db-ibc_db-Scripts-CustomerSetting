/*
	Created: 20210222@Johnson
	Task: update isActive = 1 for preventive action [redmine:#149447]
	DB: DBCUST/CustDB
*/

UPDATE ProblemAccountAction WITH(UPDLOCK,ROWLOCK)
SET isActive = 1
WHERE ActionID IN (3,4)