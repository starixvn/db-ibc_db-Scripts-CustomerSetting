/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211027@Johnson
	Task: update settings bitcoin for supers GEH,GFH,S822M
	DB: DBCust/CustDB
*/

CREATE TABLE #tblCust(custid INT PRIMARY KEY, roleid TINYINT)

INSERT INTO #tblCust(custid,roleid)
SELECT custid,roleid
FROM custinfo WITH(NOLOCK)
WHERE srecommend IN (966501,1601946,2042873)
	AND roleid IN (1,2,3)
		
--reset PT = 0 for masters/agents
--561 rows affected
UPDATE cs
SET MasterPT = 0,
	AgentPT = 0,
	AutoMasterPT = 0,
	IsAutoMasterPT = 0,
	MinPT = 0,
	SuperPT = CASE WHEN roleid = 3 AND IsAutoSuperPT = 0 THEN 88 ELSE SuperPT END,
	AutoSuperPT = CASE WHEN roleid = 3 AND IsAutoSuperPT = 1 THEN 88 ELSE AutoSuperPT END
FROM CustPTSetting3rd_Agent cs WITH(ROWLOCK)
	INNER JOIN #tblCust t ON cs.custid = t.custid 
WHERE roleid IN (2,3)
	AND sporttype = 175
GO

--update pt on members
--3348 rows affected
UPDATE cs
SET MasterPT = 0,
	AgentPT = 0,
	AutoMasterPT = 0,
	IsAutoMasterPT = 0,
	SuperPT = 88
FROM CustPTSetting3rd_Member cs WITH(ROWLOCK)
WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid IN (1))
	AND sporttype = 175
GO

--reset discount = 0 for masters/agents
--561 rows affected
UPDATE cs
SET Discount = 0
FROM CustDiscount3rd_Agent cs WITH(ROWLOCK)
WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid IN (2,3))
	AND sporttype = 175
GO

--update discount on members
--3348 rows affected
UPDATE cs
SET PlayerDiscount = 0,
	AgentDiscount = 0,
	MasterDiscount = 0
FROM CustDiscount3rd_Member cs WITH(ROWLOCK)
WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid IN (1))
	AND sporttype = 175
GO