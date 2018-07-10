/*
	Created: Johnson
	Date: 2018-06-18
	Task: Delete existing PP settings for licensees
	DB: DBCUST/CUSTDB
*/
DECLARE @max_custid INT = xxx

SELECT custid 
INTO #supers
FROM dbo.Dep_CustSuper WITH(NOLOCK) 
WHERE site IN ('Aoncash','Macaubet','ITCbet','9bet','M8bola','Q8bola','NBCbet','BE7','Bolanation','Sbcbet','Goobet','UNObet')

--profile setting Dep_LicenseeProductSetting					
DELETE Dep_LicenseeProductSetting WITH(UPDLOCK,ROWLOCK)
WHERE ProductSettingID IN (21,22,23)--PP
	AND custid IN (SELECT custid FROM #supers)

--pt setting on SMA dummy	
SELECT cs.custid 
	INTO #tmp
FROM dbo.Dep_CustPTSetting_Agent cs WITH(NOLOCK)
	INNER JOIN dbo.CustInfo ci WITH(NOLOCK) ON cs.custid = ci.custid
WHERE srecommend IN (SELECT custid FROM #supers)
	AND roleid IN (2,3,4)
	AND sporttype = 248
	AND ci.custid <= @max_custid
	
DELETE dbo.Dep_CustPTSetting_Agent WITH(UPDLOCK,ROWLOCK)
WHERE custid IN (SELECT custid FROM #tmp)
	AND sporttype = 248

DROP TABLE #tmp

--pt group on members
SELECT cs.AgentID 
	INTO #tmp
FROM dbo.Dep_CustPTGroupSetting_Member cs WITH(NOLOCK)
	INNER JOIN dbo.CustInfo ci WITH(NOLOCK) ON cs.AgentID = ci.custid
WHERE srecommend IN (SELECT custid FROM #supers)
	AND roleid = 2 
	AND sporttype = 248
	AND ci.custid <= @max_custid
	
DELETE dbo.Dep_CustPTGroupSetting_Member WITH(UPDLOCK,ROWLOCK)
WHERE AgentID IN (SELECT AgentID FROM #tmp)
	AND sporttype = 248

DROP TABLE #tmp

--stakelevel on sma dummy
SELECT cs.custid 
	INTO #tmp
FROM dbo.Dep_CustStakeLevel_Agent cs WITH(NOLOCK)
	INNER JOIN dbo.CustInfo ci WITH(NOLOCK) ON cs.custid = ci.custid
WHERE srecommend IN (SELECT custid FROM #supers)
	AND roleid IN (2,3,4) 
	AND sporttype = 248
	AND ci.custid <= @max_custid
	
DELETE dbo.Dep_CustStakeLevel_Agent WITH(UPDLOCK,ROWLOCK)
WHERE custid IN (SELECT custid FROM #tmp)
	AND sporttype = 248

DROP TABLE #tmp
	
--stakelevel on member level
SELECT cs.custid 
	INTO #tmp
FROM dbo.Dep_CustStakeLevel_Member cs WITH(NOLOCK)
	INNER JOIN dbo.CustInfo ci WITH(NOLOCK) ON cs.custid = ci.custid
WHERE srecommend IN (SELECT custid FROM #supers)
	AND roleid = 1
	AND sporttype = 248
	AND ci.custid <= @max_custid
	
DELETE dbo.Dep_CustStakeLevel_Member WITH(UPDLOCK,ROWLOCK)
WHERE custid IN (SELECT custid FROM #tmp)
	AND sporttype = 248

DROP TABLE #tmp	
	