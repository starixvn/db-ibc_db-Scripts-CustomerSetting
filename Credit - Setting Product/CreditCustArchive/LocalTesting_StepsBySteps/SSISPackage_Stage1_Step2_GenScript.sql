/*
	Created: 20200505@Helen
	Task: https://nexdev.net/issues/130032
	DB: DBACC.bodb02
*/
USE bodb02
GO
IF @@SERVERNAME NOT IN ('DB234','DB232')
	RETURN
	
--EXEC DBA_ArchiveAccount1_CloseAgentLine_GenScript

SET NOCOUNT ON

if NOT EXISTS(SELECT 1 FROM dbo.SystemSettings WITH(NOLOCK) WHERE VValue = 'Stage 1 - Done' AND VName = 'aa_Stmt_Status')
BEGIN
	raisError ('Statement data for this stage not loaded yet!', 16, 1)
	RETURN

END

INSERT INTO bodb_report.dbo.tempCustID
SELECT custid
FROM bettrans with (NOLOCK)
WHERE bettype <> 20000  
	and recommend IN (xxx)
	--and recommend in  (42780012,42780013,42780014,42780015,42780016,42780017,42780018,42780020)
	--AND custid NOT IN(select custid from bodb_report.dbo.tempCustID)
--UNION
--SELECT custid
--FROM translog with (NOLOCK) WHERE custid NOT IN(select custid from bodb_report.dbo.tempCustID)
--UNION
--SELECT custid
--FROM bettransRNG with (NOLOCK) WHERE custid NOT IN(select custid from bodb_report.dbo.tempCustID)
--UNION
--SELECT custid
--FROM bettransLC with (NOLOCK) WHERE custid NOT IN(select custid from bodb_report.dbo.tempCustID)


--update exception list
EXEC dbo.DBA_ArchiveAccount_UpdateException

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
	AND isnull(MemCount, 0) > 0
	AND (ag.creatdate < DATEADD(mm, -3, GETDATE()))
	AND agci.closed = 0 
	AND agci.enabled = 1
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
			creatdate >= DATEADD(mm, -3, GETDATE())
		)
	AND agci.credit >= 0
		
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

SELECT @xmlData

DECLARE  @ExecuteSQL NVARCHAR(MAX) = ''
			, @query NVARCHAR(MAX) = ''
SELECT  @query = N''		
SELECT	@query = @query + N'EXEC Task_Archive_Credit_tmp_Helen @xmlData'
SELECT	@ExecuteSQL = N'EXECUTE DBCUST.CUSTDB.dbo.sp_executesql @query, N''@xmlData NVARCHAR(MAX)'',@xmlData'

EXECUTE	sys.sp_executesql @ExecuteSQL, N'@query NVARCHAR(MAX), @xmlData NVARCHAR(MAX)', @query, @xmlData


DROP TABLE #tmpAg
