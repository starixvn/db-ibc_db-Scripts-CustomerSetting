/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20230619
	Task: Enablesuper: StarixSCYEN - 42399710 [Redmine:#189964]
	DB: DBCUST/CustDB 
*/

UPDATE c
SET c.enabled = 1
--SELECT *
FROM custinfo c WITH(ROWLOCK)
WHERE c.custid = 42399710--'StarixSCYEN'