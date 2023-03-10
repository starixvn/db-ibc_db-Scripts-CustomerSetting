/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230302@Johnson
	Task: Update isActive = 1 for basketball in table ProfileVirtualSetting [redmine: #184339]
	DB: DBCUST/CustDB
*/

UPDATE p
SET IsActive = 1
FROM ProfileVirtualSetting p WITH(ROWLOCK)
WHERE sporttype =2 