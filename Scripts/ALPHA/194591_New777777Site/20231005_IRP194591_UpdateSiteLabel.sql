/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231005@Johnson
	Task: update sitelabel for 777777
	DB: DBCUST/CustDB
*/

UPDATE site WITH(ROWLOCK)
SET SiteLabel = '777',
	RepUpdateTime = SYSDATETIME()
WHERE site = '777777'