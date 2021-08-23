/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Johnson
	Date: 20210802
	Task: add setting for bet restriction for basketball
	DB: DBCust/CustDB
*/
UPDATE BetRestriction_Setting WITH(ROWLOCK)
SET BackEndStatus = 0
WHERE SportType= 2
