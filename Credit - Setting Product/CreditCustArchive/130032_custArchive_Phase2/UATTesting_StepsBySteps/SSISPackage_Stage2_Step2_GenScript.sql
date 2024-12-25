/*
	Created: 20200611@Max
	Task: https://nexdev.net/issues/130032
	DB: DBSPARE.CustDB
	Revisions:
		20210727@Tina: get closed status from CustProductStatus [RedmineID: #148600]
*/
USE CustDB
GO
IF @@SERVERNAME NOT IN ('DBSPARE')
	RETURN

SET NOCOUNT ON

-- simulate run date based on test data version
declare @currentDate smalldatetime 
select @currentDate = VValue from bodb02.dbo.Systemsettings with (nolock) where VName = 'aa_TestDate'

if NOT EXISTS(SELECT 1 FROM bodb02.dbo.SystemSettings WITH(NOLOCK) WHERE VValue = 'Stage 2 - Done' AND VName = 'aa_Stmt_Status')
BEGIN
	raisError ('Statement data for this stage not loaded yet!', 16, 1)
	RETURN

END

DECLARE @startdate smalldatetime
SET @startdate = DATEADD(mm, - 4, @currentDate)

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
UNION
SELECT custid
FROM bodb02.dbo.TransferExtra with (NOLOCK) WHERE custid NOT IN(select custid from bodb_report.dbo.tempCustID)
	AND bettype <> 30000
UNION
SELECT custid
FROM bodb02.dbo.SabaWalletTicket with (NOLOCK) WHERE custid NOT IN(select custid from bodb_report.dbo.tempCustID)

--update exception list
EXEC CustDB.dbo.DBA_ArchiveAccount_UpdateException

--Get cust from s1
SELECT ag.recommend custid, isnull(MemCount, 0) [Member Count]
INTO #tmpAg
FROM bodb_report.dbo.tmpCustArchived ag WITH (NOLOCK)
	INNER JOIN custinfo agci WITH (NOLOCK) ON agci.custid = ag.recommend
	INNER JOIN CustProductStatus cps WITH (NOLOCK) ON agci.custid = cps.CustID
	LEFT JOIN (
		SELECT recommend
			,COUNT(*) MemCount
		FROM custinfo mem WITH (NOLOCK)
		WHERE roleid = 1
		GROUP BY recommend
		) mem ON mem.recommend = agci.custid
WHERE ag.isFinished = 1
	--AND isnull(MemCount, 0) > 0
	AND cps.CloseInfo > 0
	--AND agci.enabled = 1
	AND agci.srecommend NOT IN (SELECT custid FROM bodb_report.dbo.Task_Cust_ArchiveAcc_Exception WITH(NOLOCK))
	AND agci.mrecommend NOT IN (SELECT custid FROM bodb_report.dbo.Task_Cust_ArchiveAcc_Exception WITH(NOLOCK))
	AND agci.custid NOT IN (SELECT custid FROM bodb_report.dbo.Task_Cust_ArchiveAcc_Exception WITH(NOLOCK))
	AND agci.custid NOT IN (
		SELECT DISTINCT recommend
		FROM bodb_report.dbo.tempCustID tc
		INNER JOIN custinfo ci WITH (NOLOCK) ON tc.custid = ci.custid
		)
	AND agci.custid NOT IN (
		SELECT DISTINCT recommend
		FROM customer c WITH (NOLOCK)
		WHERE roleid IN (1,2) AND
			creatdate >= @startdate
		)
	AND ag.IsFinished = 1 AND (ISNULL(ag.ErrMsg,'') = '' OR ag.ErrMsg LIKE '%archived%')

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
