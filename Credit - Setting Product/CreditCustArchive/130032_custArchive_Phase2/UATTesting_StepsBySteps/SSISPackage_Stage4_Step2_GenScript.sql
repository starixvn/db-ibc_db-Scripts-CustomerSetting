/*
	Created: 20200611@Max
	Task: https://nexdev.net/issues/130032
	DB: DBSPARE.CustDB
*/
USE CustDB
GO
IF @@SERVERNAME NOT IN ('DBSPARE')
	RETURN

-- simulate run date based on test data version
declare @currentDate smalldatetime 
select @currentDate = VValue from bodb02.dbo.Systemsettings with (nolock) where VName = 'aa_TestDate'
	
if NOT EXISTS(SELECT 1 FROM bodb02.dbo.SystemSettings WITH(NOLOCK) WHERE VValue = 'Stage 4 - Done' AND VName = 'aa_Stmt_Status')
BEGIN
	raisError ('Statement data for this stage not loaded yet!', 16, 1)
	RETURN

END

CREATE TABLE #Super_Exception (srecommend INT PRIMARY KEY)

INSERT INTO #Super_Exception (srecommend)
SELECT ci.srecommend		
FROM CustGroupHeadline gl (nolock)		
	INNER JOIN Customer ci (nolock) ON gl.CustID = ci.custid		
WHERE GroupID > 0 and ci.roleid in (1,2,3,4)
UNION
SELECT ag.custid
FROM phonebettingCustomerList p WITH(NOLOCK)
	INNER JOIN custinfo c WITH(NOLOCK) ON p.username = c.username
	INNER JOIN custinfo ag WITH(NOLOCK) ON ag.custid = c.srecommend

CREATE TABLE #Exclude_Agents(recommend INT PRIMARY KEY)

--Exclude Direct and Dummy agents
INSERT INTO #Exclude_Agents(recommend)
SELECT DISTINCT ci.recommend
FROM CustDirectAccount d WITH(NOLOCK)
	INNER JOIN custinfo ci WITH(NOLOCK) ON d.CustID = ci.custid
WHERE ci.roleid IN (1,2)

DECLARE @DDiff DATETIME

SELECT @DDiff = DATEADD(mm, -7, @CurrentDate)

SELECT @DDiff = DATEADD(week, -2, @DDiff)

INSERT INTO bodb_report.dbo.tempCustID
SELECT custid
FROM bodb02.dbo.bettrans with (NOLOCK)
WHERE bettype <> 20000 AND custid NOT IN(select custid from bodb_report.dbo.tempCustID)
UNION
SELECT custid
FROM bodb02.dbo.translog with (NOLOCK) WHERE custid NOT IN(select custid from bodb_report.dbo.tempCustID)
UNION
SELECT custid
FROM bodb02.dbo.bettransRNG with (NOLOCK) WHERE custid NOT IN(select custid from bodb_report.dbo.tempCustID)
UNION
SELECT custid
FROM bodb02.dbo.bettransLC with (NOLOCK) WHERE custid NOT IN(select custid from bodb_report.dbo.tempCustID)

--update exception list
EXEC CustDB.dbo.DBA_ArchiveAccount_UpdateException


--Get cust from s3
SELECT ag.recommend custid, isnull(MemCount, 0) [Member Count], isnull(TransCount, 0) [Trans Count]
INTO #tmpAg
FROM bodb_report.dbo.tmpCustArchived ag WITH (NOLOCK)
	INNER JOIN custinfo agci WITH (NOLOCK) ON agci.custid = ag.recommend
	LEFT JOIN (
		SELECT recommend
			,COUNT(*) MemCount
		FROM custinfo mem WITH (NOLOCK)
		WHERE roleid = 1
		GROUP BY recommend
		) mem ON mem.recommend = agci.custid
	LEFT JOIN (
		SELECT recommend
			,COUNT(*) TransCount
		FROM bodb02.dbo.bettrans b WITH (NOLOCK)
		WHERE custid <> recommend
		GROUP BY recommend
		) b ON b.recommend = agci.custid	
	LEFT JOIN #Super_Exception se ON se.srecommend = agci.srecommend
WHERE ag.isFinished = 1
	AND isnull(MemCount, 0) > 0 AND isnull(TransCount, 0) = 0
	AND agci.enabled = 0
	AND ag.recommend NOT IN(SELECT custid FROM bodb_report.dbo.Task_Cust_ArchiveAcc_Exception WITH(NOLOCK))
	AND ag.recommend NOT IN(SELECT recommend FROM #Exclude_Agents)
	AND agci.custid NOT IN (
		SELECT DISTINCT recommend
		FROM bodb_report.dbo.tempCustID tc
		INNER JOIN custinfo ci WITH (NOLOCK) ON tc.custid = ci.custid
		--WHERE ci.roleid = 1
		)
	AND agci.custid NOT IN (
		SELECT DISTINCT recommend
		FROM customer c WITH (NOLOCK)
		WHERE --roleid = 1 AND
			creatdate >= @DDiff
		)
	AND se.srecommend IS NULL
	AND ag.IsFinished = 1 AND (ISNULL(ag.ErrMsg,'') = '' OR ag.ErrMsg LIKE '%archived%')
	

/*
--Get more other cust based on s4 condition
INSERT INTO #tmpAg
SELECT ag.custid, isnull(MemCount, 0) [Member Count], isnull(TransCount, 0) [Trans Count]
FROM customer ag WITH (NOLOCK)
	INNER JOIN [site] s WITH (NOLOCK) ON ag.site = s.site AND s.isLicensee = 0
	INNER JOIN CustAgent ca WITH (NOLOCK) ON ag.custid = ca.custid
	INNER JOIN custinfo agci WITH (NOLOCK) ON agci.custid = ag.custid
	LEFT JOIN (
		SELECT recommend
			,COUNT(*) MemCount
		FROM custinfo mem WITH (NOLOCK)
		WHERE roleid = 1
		GROUP BY recommend
		) mem ON mem.recommend = agci.custid
	LEFT JOIN (
		SELECT recommend
			,COUNT(*) TransCount
		FROM bodb02.dbo.bettrans b WITH (NOLOCK)
		WHERE custid <> recommend
		GROUP BY recommend
		) b ON b.recommend = agci.custid	
	LEFT JOIN #Super_Exception se ON se.srecommend = agci.srecommend
WHERE ag.roleid = 2
	--AND isnull(MemCount, 0) > 0 
	AND isnull(TransCount, 0) = 0
	AND (ag.creatdate < @DDiff)
	AND agci.enabled = 0
	AND ca.isInternal = 0
	AND ag.srecommend NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))
	AND ag.custid NOT IN(SELECT custid FROM bodb_report.dbo.Task_Cust_ArchiveAcc_Exception WITH(NOLOCK))
	AND agci.custid NOT IN (
		SELECT DISTINCT recommend
		FROM bodb_report.dbo.tempCustID tc
		INNER JOIN custinfo ci WITH (NOLOCK) ON tc.custid = ci.custid
		--WHERE ci.roleid = 1
		)
	AND agci.custid NOT IN (
		SELECT DISTINCT recommend
		FROM customer c WITH (NOLOCK)
		WHERE --roleid = 1 AND
			creatdate >= @DDiff
		)
	AND agci.custid NOT IN (SELECT recommend FROM bodb_report.dbo.tmpCustArchived)
	AND se.srecommend IS NULL
*/
		

DECLARE @xmlData NVARCHAR(MAX) = ''

SET @xmlData = (SELECT sag.username Super
	,mag.username Master
	,ag.username Agent
	,[Member Count] MemCnt
	--,[Trans Count]
	,ag.custid recommend
FROM customer ag WITH (NOLOCK)
	INNER JOIN #tmpAg t WITH (NOLOCK) ON ag.custid = t.custid
	INNER JOIN customer mag WITH (NOLOCK) ON ag.mrecommend = mag.custid AND mag.roleid = 3
	INNER JOIN customer sag WITH (NOLOCK) ON ag.srecommend = sag.custid AND sag.roleid = 4
	LEFT JOIN  dbo.bettrans bt WITH(NOLOCK) ON ag.custid = bt.custid  AND bt.bettype = 20000 AND bt.matchid = 0
WHERE bt.custid IS NULL
ORDER BY [Member Count] DESC
FOR XML PATH ('r'))

DECLARE @xml XML
SET @xml = @xmlData
INSERT INTO CustDB.dbo.tmpCustArchived (Super, Master, Agent, MemCnt, recommend)
SELECT x.v.value('(Super/text())[1]','VARCHAR(50)') AS Super,
		x.v.value('(Master/text())[1]','VARCHAR(50)') AS Master,
		x.v.value('(Agent/text())[1]','VARCHAR(50)') AS Agent,
		x.v.value('(MemCnt/text())[1]','INT') AS MemCnt,
		x.v.value('(recommend/text())[1]','INT') AS recommend
FROM @xml.nodes('/r') AS x(v)

DROP TABLE #tmpAg
DROP TABLE #Super_Exception
DROP TABLE #Exclude_Agents