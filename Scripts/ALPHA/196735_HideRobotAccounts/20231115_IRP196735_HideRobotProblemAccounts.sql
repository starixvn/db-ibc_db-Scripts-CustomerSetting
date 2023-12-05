/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231115@Johnson
	Task: Hide Robot Problem accounts on Alpha
	DB: DBCUST/CustDB
*/

UPDATE CategoryConfig WITH(ROWLOCK)
SET HiddenSite = 1
WHERE CustomerClass IN (300,3100,3200)