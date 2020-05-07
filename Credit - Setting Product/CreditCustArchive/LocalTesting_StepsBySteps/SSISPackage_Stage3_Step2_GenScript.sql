/*
	Created: 20200505@Helen
	Task: https://nexdev.net/issues/130032
	DB: DBACC.bodb02
*/
USE bodb02
GO
IF @@SERVERNAME NOT IN ('DB234','DB232')
	RETURN
	
--EXEC DBA_ArchiveAccount3_GenScript

SET NOCOUNT ON

if NOT EXISTS(SELECT 1 FROM dbo.SystemSettings WITH(NOLOCK) WHERE VValue = 'Stage 3 - Done' AND VName = 'aa_Stmt_Status')
BEGIN
	raisError ('Statement data for this stage not loaded yet!', 16, 1)
	RETURN

END

INSERT INTO bodb_report.dbo.tempCustID
SELECT custid
FROM bettrans with (NOLOCK)
WHERE bettype <> 20000 AND custid NOT IN(select custid from bodb_report.dbo.tempCustID)
UNION
SELECT custid
FROM translog with (NOLOCK) WHERE custid NOT IN(select custid from bodb_report.dbo.tempCustID)
UNION
SELECT custid
FROM bettransRNG with (NOLOCK) WHERE custid NOT IN(select custid from bodb_report.dbo.tempCustID)
UNION
SELECT custid
FROM bettransLC with (NOLOCK) WHERE custid NOT IN(select custid from bodb_report.dbo.tempCustID)


--update exception list
EXEC dbo.DBA_ArchiveAccount_UpdateException

SELECT ag.custid, isnull(MemCount, 0) [Member Count], isnull(TransCount, 0) [Trans Count]
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
	LEFT JOIN (
		SELECT recommend
			,COUNT(*) TransCount
		FROM bettrans b WITH (NOLOCK)
		WHERE custid <> recommend
		GROUP BY recommend
		) b ON b.recommend = agci.custid		
WHERE ag.roleid = 2
	AND isnull(MemCount, 0) > 0-- AND isnull(TransCount, 0) > 0
	AND (ag.creatdate < DATEADD(mm, -7, GETDATE()))
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
			creatdate >= DATEADD(mm, -7, GETDATE())
		)
	AND agci.credit >= 0
		
DECLARE @xmlData NVARCHAR(MAX) = ''

SET @xmlData = (
SELECT sag.username Super
	,mag.username Master
	,ag.username Agent
	,[Member Count] MemCnt
	/*,[Trans Count]
	,'Exec DBA_ArchiveAccount2_ClearBalance ''' + ag.username +''' WAITFOR DELAY ''000:00:00.200''' SPCommand
	,'Exec DBA_ArchiveAccount2_DelCustSetting ''' + ag.username +''' WAITFOR DELAY ''000:00:00.200'' ;GO' SPCommand2*/
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
--DBCUST
SELECT  @query = N''		
SELECT	@query = @query + N'EXEC Task_Archive_Credit_tmp_Helen @xmlData'
SELECT	@ExecuteSQL = N'EXECUTE DBCUST.CUSTDB.dbo.sp_executesql @query, N''@xmlData NVARCHAR(MAX)'',@xmlData'

EXECUTE	sys.sp_executesql @ExecuteSQL, N'@query NVARCHAR(MAX), @xmlData NVARCHAR(MAX)', @query, @xmlData

--DBTRANS
SELECT  @query = N''		
SELECT	@query = @query + N'EXEC Task_Archive_Credit_tmp_Helen @xmlData'
SELECT	@ExecuteSQL = N'EXECUTE DBTXN.bodb02.dbo.sp_executesql @query, N''@xmlData NVARCHAR(MAX)'',@xmlData'

EXECUTE	sys.sp_executesql @ExecuteSQL, N'@query NVARCHAR(MAX), @xmlData NVARCHAR(MAX)', @query, @xmlData


DROP TABLE #tmpAg
