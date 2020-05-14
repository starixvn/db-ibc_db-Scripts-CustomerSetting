/*
	Created: 20200505@Helen
	Task: https://nexdev.net/issues/130032
	DB: DBACC.bodb02
*/
USE bodb02
GO
IF @@SERVERNAME NOT IN ('DB234','DB232')
	RETURN
	
--EXEC DBA_ArchiveAccount4_DelCustInfo_GenScript

SET NOCOUNT ON

if NOT EXISTS(SELECT 1 FROM dbo.SystemSettings WITH(NOLOCK) WHERE VValue = 'Stage 4 - Done' AND VName = 'aa_Stmt_Status')
BEGIN
	raisError ('Statement data for this stage not loaded yet!', 16, 1)
	RETURN

END

CREATE TABLE #SuperHeadLine (custId INT)
CREATE TABLE #SuperPhoneBetting (custId INT)

INSERT INTO #SuperHeadLine (custId)
SELECT DISTINCT ci.srecommend		
FROM CustGroupHeadline gl (nolock)		
	INNER JOIN Customer ci (nolock) ON gl.CustID = ci.custid		
WHERE GroupID > 0 and ci.roleid in (1,2,3,4)

INSERT INTO #SuperPhoneBetting (custId)
SELECT DISTINCT ag.custid
FROM phonebettingCustomerList p WITH(NOLOCK)
	INNER JOIN custinfo c WITH(NOLOCK) ON p.username = c.username
	INNER JOIN custinfo ag WITH(NOLOCK) ON ag.custid = c.srecommend

DECLARE @DDiff DATETIME

SELECT @DDiff = DATEADD(mm, -7, GETDATE())

SELECT @DDiff = DATEADD(week, -2, @DDiff)

INSERT INTO bodb_report.dbo.tempCustID
SELECT distinct custid
FROM bettrans with (NOLOCK)
WHERE bettype <> 20000  
	and recommend IN (xxx)
	--and recommend in  (42780012,42780013,42780014,42780015,42780016,42780017,42780018,42780020)
	AND custid NOT IN(select custid from bodb_report.dbo.tempCustID)
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
		FROM bettrans b WITH (NOLOCK)
		WHERE custid <> recommend
		GROUP BY recommend
		) b ON b.recommend = agci.custid		
WHERE ag.isFinished = 1
	AND isnull(MemCount, 0) > 0 AND isnull(TransCount, 0) = 0
	AND agci.enabled = 0
	AND ag.recommend NOT IN(SELECT custid FROM bodb_report.dbo.Task_Cust_ArchiveAcc_Exception WITH(NOLOCK))
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
	AND agci.srecommend NOT IN (SELECT custid FROM #SuperHeadLine)
	AND agci.srecommend NOT IN (SELECT custid FROM #SuperPhoneBetting)
	AND agci.srecommend NOT IN (1584511--	SMON
								,17131340	--	RG2
								,20505414	--	HG81
								,31381376	--	L1
								,31890071	--	RG33
								,32506252	--	RG37
								,32546605	--	AMH5
								,34176539	--	KW19
								,39428597	--	RG81
								,40906204	--	RG83
								,859594	--	S99H
								,2953285	--	HPV
								,5044097	--	HPMM
								,18119949	--	A3
								,25256329	--	S99BE
								,26979533	--	B60T
								,28182257	--	JYZ
								,28969062	--	B59T
								,1687347	--	S222TH
								,29680156	--	B62T
								,39583203	--	B70T
								,39583632	--	B65T
								,1528414	--	B6T
								,1538175	--	B14T
								,20060537	--	SSD72
								,16731414	--	CG34
								,31556024	--	QZ9Q
								,21127993	--	DT25
								,2198456	--	TV71
								,5362687	--	BC9
								,25174645	--	TVA9C
								,22765105	--	MBO
								,5453438	--	K9
								,9735627	--	S6KW
								,24400636--	S68H
								,14182461--	supertest3 
								,1176070	--	SuperTest1
							)


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
		FROM bettrans b WITH (NOLOCK)
		WHERE custid <> recommend
		GROUP BY recommend
		) b ON b.recommend = agci.custid		
WHERE ag.roleid = 2
	AND isnull(MemCount, 0) > 0 AND isnull(TransCount, 0) = 0
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
	AND agci.srecommend NOT IN (SELECT custid FROM #SuperHeadLine)
	AND agci.srecommend NOT IN (SELECT custid FROM #SuperPhoneBetting)
	AND agci.srecommend NOT IN (1584511--	SMON
								,17131340	--	RG2
								,20505414	--	HG81
								,31381376	--	L1
								,31890071	--	RG33
								,32506252	--	RG37
								,32546605	--	AMH5
								,34176539	--	KW19
								,39428597	--	RG81
								,40906204	--	RG83
								,859594	--	S99H
								,2953285	--	HPV
								,5044097	--	HPMM
								,18119949	--	A3
								,25256329	--	S99BE
								,26979533	--	B60T
								,28182257	--	JYZ
								,28969062	--	B59T
								,1687347	--	S222TH
								,29680156	--	B62T
								,39583203	--	B70T
								,39583632	--	B65T
								,1528414	--	B6T
								,1538175	--	B14T
								,20060537	--	SSD72
								,16731414	--	CG34
								,31556024	--	QZ9Q
								,21127993	--	DT25
								,2198456	--	TV71
								,5362687	--	BC9
								,25174645	--	TVA9C
								,22765105	--	MBO
								,5453438	--	K9
								,9735627	--	S6KW
								,24400636--	S68H
								,14182461--	supertest3 
								,1176070	--	SuperTest1
							)
		
		
DECLARE @xmlData NVARCHAR(MAX) = ''

SET @xmlData = (
SELECT sag.username Super
	,mag.username Master
	,ag.username Agent
	,[Member Count] MemCnt
	--,[Trans Count]
	,ag.custid recommend
	--,'Exec [DBA_ArchiveAccount3_DelCustInfo] ''' + ag.username +''' WAITFOR DELAY ''000:00:00.200''' SPCommand
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
DROP TABLE #SuperHeadLine
DROP TABLE #SuperPhoneBetting