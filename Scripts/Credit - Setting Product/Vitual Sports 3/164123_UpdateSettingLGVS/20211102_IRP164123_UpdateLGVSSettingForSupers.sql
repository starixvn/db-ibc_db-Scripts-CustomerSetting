/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211102@Johnson
	Task: update settings LG Virtual sports for supers 
	DB: DBCust/CustDB
*/

CREATE TABLE #tblCust(custid INT PRIMARY KEY, roleid TINYINT)

INSERT INTO #tblCust(custid,roleid)
SELECT custid,roleid
FROM custinfo WITH(NOLOCK)
WHERE srecommend IN (966501,1601946,2042873)--GEH,GFH,S822M
	AND roleid IN (1,2,3)

		
--reset PT = 0 for masters/agents
--742 rows affected
UPDATE cs
SET MasterPT = 0,
	AgentPT = 0,
	AutoMasterPT = 0,
	IsAutoMasterPT = 0,
	MinPT = 0,
	SuperPT = CASE WHEN roleid = 3 AND IsAutoSuperPT = 0 THEN 85 ELSE SuperPT END,
	AutoSuperPT = CASE WHEN roleid = 3 AND IsAutoSuperPT = 1 THEN 85 ELSE AutoSuperPT END
FROM CustPTSetting3rd_Agent cs WITH(ROWLOCK)
	INNER JOIN #tblCust t ON cs.custid = t.custid 
WHERE roleid IN (2,3)
	AND sporttype = 231
GO

--update pt on members
--3511 rows affected
UPDATE cs
SET MasterPT = 0,
	AgentPT = 0,
	AutoMasterPT = 0,
	IsAutoMasterPT = 0,
	SuperPT = 85
FROM CustPTSetting3rd_Member cs WITH(ROWLOCK)
WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid IN (1))
	AND sporttype = 231
GO


---------------------------------------------------------------------

---update settings for supers SHK,SPHM

DELETE #tblCust

INSERT INTO #tblCust(custid,roleid)
SELECT custid,roleid
FROM custinfo WITH(NOLOCK)
WHERE srecommend IN (463265,796555)
	AND roleid IN (1,2,3)
		
--reset PT = 0 for agents, set us3=85, m3 = 80
--202 rows affected
UPDATE cs
SET MasterPT = CASE WHEN roleid = 3 THEN 80 ELSE 0 END,
	AgentPT = 0,
	AutoMasterPT = 0,
	IsAutoMasterPT = 0,
	MinPT = 0,
	SuperPT = 0,
	AutoSuperPT = CASE WHEN roleid = 3 THEN 85 ELSE AutoSuperPT END,
	IsAutoSuperPT = CASE WHEN roleid = 3 THEN 1 ELSE IsAutoSuperPT END
FROM CustPTSetting3rd_Agent cs WITH(ROWLOCK)
	INNER JOIN #tblCust t ON cs.custid = t.custid 
WHERE roleid IN (2,3)
	AND sporttype = 231
GO

--update pt on members
--1702 rows affected
UPDATE cs
SET MasterPT = 0,
	AgentPT = 0,
	AutoMasterPT = 0,
	IsAutoMasterPT = 0,
	SuperPT = 85
FROM CustPTSetting3rd_Member cs WITH(ROWLOCK)
WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid IN (1))
	AND sporttype = 231
GO