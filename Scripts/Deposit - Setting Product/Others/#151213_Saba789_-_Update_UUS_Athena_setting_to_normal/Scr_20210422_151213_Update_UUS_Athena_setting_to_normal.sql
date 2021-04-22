/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20210422
    Task:  Update setting of Athena000SuperUUS follow by normal setting of line 12BETSuperAUD for testing (PT and comm) [#151213]
	DB: DBCUST-CUSTDB
*/

SELECT c.custid, c.roleid
INTO #RefSMA
FROM custinfo c WITH(NOLOCK)
WHERE c.custid in (1015423,1015420,1015419)

----Update Custinfo
--UPDATE ci
--SET 
--		ci.maxpermatch = ref.maxpermatch, 
--		ci.maxpermatch2 = ref.maxpermatch2, 
--		ci.maxpermatch3 = ref.maxpermatch3, 
--		ci.maxpermatch5 = ref.maxpermatch5, 
--		ci.maxpermatch8 = ref.maxpermatch8, 
--		ci.maxpermatch10 = ref.maxpermatch10, 
--		ci.maxpermatch11 = ref.maxpermatch11, 
--		ci.maxpermatch99 = ref.maxpermatch99, 
--		ci.MaxPerMatch99MP = ref.MaxPerMatch99MP, 
--		ci.MaxPerMatch1MP = ref.MaxPerMatch1MP
--FROM custinfo ci WITH (ROWLOCK, UPDLOCK)
--		INNER JOIN #RefSMA tmp
--		ON ci.roleid = tmp.roleid
--		INNER JOIN custinfo ref WITH(NOLOCK)
--		ON ref.custid = tmp.custid
--WHERE ci.srecommend = 10063437 --Athena000SuperUUS
--		AND ci.roleID IN(2, 3, 4);

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
		--c.minbet = ref.minbet, 
		--c.maxbet = ref.maxbet
FROM dep_custsetting c WITH (ROWLOCK, UPDLOCK)
		INNER JOIN custinfo ci WITH(NOLOCK)
		ON c.custid = ci.custid
		INNER JOIN #RefSMA tmp
		ON ci.roleid = tmp.roleid
		INNER JOIN dep_custsetting ref WITH(NOLOCK)
		ON ref.custid = tmp.custid
			AND ref.sporttype = c.sporttype
			AND ref.bettype = c.bettype
			AND ref.islive = c.islive
WHERE ci.srecommend = 10063437 --Athena000SuperUUS
		AND ci.roleID IN(2, 3, 4);

DROP TABLE #RefSMA
	