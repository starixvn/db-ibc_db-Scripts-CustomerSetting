/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20210422
    Task:  Update setting of Athena000UUS011903544,Athena000UUS011903545 follow by normal setting of 12BETAUD02001 for testing (PT and comm) [#151213]
	DB: DBCUST-CUSTDB
*/
--Update Dep_custSetting
UPDATE c
SET 
		c.apositiontaking = ref.apositiontaking, 
		c.mpositiontaking = ref.mpositiontaking, 
		c.spositiontaking = ref.spositiontaking, 
		c.playerdiscount = ref.playerdiscount, 
		c.discount = ref.discount, 
		c.adiscount = ref.adiscount, 
		c.sdiscount = ref.sdiscount 
FROM dep_custsetting c WITH (ROWLOCK, UPDLOCK)
	INNER JOIN dep_custsetting ref WITH(NOLOCK)
		ON ref.custid = 1411402 --12BETAUD02001
		AND ref.sporttype = c.sporttype
		AND ref.bettype = c.bettype
		AND ref.islive = c.islive
WHERE c.custid IN(31718371,31718368) --Athena000UUS011903544,Athena000UUS011903545 
	