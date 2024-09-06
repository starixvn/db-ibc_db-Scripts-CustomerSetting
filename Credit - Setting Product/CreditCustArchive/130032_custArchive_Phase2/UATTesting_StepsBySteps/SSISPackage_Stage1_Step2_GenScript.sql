/*
	Created: 20200611@Max
	Task: https://nexdev.net/issues/130032
	DB: DBSPARE.CustDB
*/
USE CustDB
GO
IF @@SERVERNAME NOT IN ('DBSPARE')
	RETURN
	
SET NOCOUNT ON

-- simulate run date based on test data version
declare @currentDate smalldatetime 
select @currentDate = VValue from bodb02.dbo.Systemsettings with (nolock) where VName = 'aa_TestDate'

if NOT EXISTS(SELECT 1 FROM bodb02.dbo.SystemSettings WITH(NOLOCK) WHERE VValue = 'Stage 1 - Done' AND VName = 'aa_Stmt_Status')
BEGIN
	raisError ('Statement data for this stage not loaded yet!', 16, 1)
	RETURN

END

INSERT INTO bodb_report.dbo.tempCustID
SELECT custid
FROM bodb02.dbo.transfer with (NOLOCK)
WHERE bettype <> 20000 AND custid NOT IN(select custid from bodb_report.dbo.tempCustID)
UNION
SELECT custid
FROM bodb02.dbo.bettrans with (NOLOCK)
WHERE custid NOT IN(select custid from bodb_report.dbo.tempCustID)
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

SELECT ag.custid, isnull(MemCount, 0) [Member Count]
INTO #tmpAg
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
WHERE ag.roleid = 2
	--AND isnull(MemCount, 0) > 0
	AND (ag.creatdate < DATEADD(mm, -3, @currentDate))
	--AND agci.closed = 0 
	--AND agci.enabled = 1
	AND ca.isInternal = 0
	AND ag.srecommend NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))
	AND ag.srecommend NOT IN (SELECT custid FROM bodb_report.dbo.Task_Cust_ArchiveAcc_Exception WITH(NOLOCK))
	AND ag.mrecommend NOT IN (SELECT custid FROM bodb_report.dbo.Task_Cust_ArchiveAcc_Exception WITH(NOLOCK))
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
		WHERE roleid IN (1,2) AND
			creatdate >= DATEADD(mm, -3, @currentDate)
		)

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


