/*
	Created: 20200828@Johnson
	Task: data patch for problem accounts
	DB: DBCUST/CUSTDB
*/

UPDATE ProblemAccount WITH (UPDLOCK,ROWLOCK) 
SET LimitAmount = 0,
	VoidTime = 'At Settlement'
WHERE LimitAmount IS NULL