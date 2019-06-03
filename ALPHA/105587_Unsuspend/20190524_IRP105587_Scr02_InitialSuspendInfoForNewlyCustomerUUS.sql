/*
	Created: Johnson
	Date: 2019-05-24
	Task: initial suspendinfo for newly UUS customers
	DB: DBCust/CustDB
*/

CREATE TABLE #Super(CustID INT, isfinished BIT DEFAULT(0))
CREATE TABLE #tblCust (CustID INT PRIMARY KEY, roleid TINYINT, suspend BIT, suspendSuper BIT, suspendMaster BIT, suspendAgent BIT, suspendInfo TINYINT)	
DECLARE @tmpCust TABLE (custid INT PRIMARY KEY, suspendInfo TINYINT)
DECLARE @max_custid INT, @rowcount INT

SELECT @max_custid = xxx

INSERT INTO #Super(custid)
SELECT ci.custid 
FROM dbo.customer c WITH (Nolock) 
	INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
	INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
WHERE ci.roleid = 4
	AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))	
	AND ci.custid NOT IN (SELECT custid FROM dbo.CustSuper WITH(NOLOCK) WHERE isInternal = 1)
	AND ci.Enabled = 1
	AND s.islicensee = 0
	AND c.username NOT LIKE '3rdSuper%'
	AND ci.currency = 20

INSERT INTO #tblCust(CustID,roleid,suspend,suspendSuper,suspendMaster,suspendAgent, suspendInfo)
SELECT ci.custid, ci.roleid, ISNULL(ci.reject,0), ISNULL(s.reject,0), ISNULL(m.reject,0), ISNULL(a.reject,0),0
FROM custinfo ci WITH(NOLOCK)
	LEFT JOIN custinfo s WITH(NOLOCK) on ci.srecommend = s.custid
	LEFT JOIN custinfo m WITH(NOLOCK) on ci.mrecommend = m.custid
	LEFT JOIN custinfo a WITH(NOLOCK) on ci.recommend = a.custid
WHERE ci.srecommend IN (SELECT custid FROM #super)
	AND ci.custid > @max_custid

DECLARE @suspendSuper TINYINT = 0,
		@suspendMaster TINYINT = 0,
		@suspendAgent TINYINT = 0,
		@SuspendMember TINYINT = 0
		
UPDATE #tblCust
SET @suspendSuper = 0,
	@suspendMaster =0,
	@suspendAgent = 0,
	@SuspendMember = 0,
	@suspendSuper = (SELECT suspendInfo FROM dbo.f_GenerateSuspendInfo_UAT1(4,suspendSuper,@suspendSuper)),
	@suspendMaster = CASE WHEN roleid < 4 AND suspendSuper =0  
							THEN (SELECT suspendInfo FROM dbo.f_GenerateSuspendInfo_UAT1(3,suspendMaster,@suspendSuper))
							ELSE @suspendSuper END,
	@suspendAgent = CASE WHEN roleid < 3 AND suspendSuper = 0 AND suspendMaster = 0 
							THEN (SELECT suspendInfo FROM dbo.f_GenerateSuspendInfo_UAT1(2,suspendAgent,@suspendMaster))
							ELSE @suspendMaster END,
	@suspendMember = CASE WHEN roleid < 2 AND suspendSuper = 0 AND suspendMaster = 0 AND suspendAgent = 0
							THEN (SELECT suspendInfo FROM dbo.f_GenerateSuspendInfo_UAT1(1,suspend,@suspendAgent))
							ELSE @suspendAgent END,
	suspendInfo = CASE WHEN roleid = 4 THEN @suspendSuper
						WHEN roleid = 3 THEN @suspendMaster
						WHEN roleid =2 THEN @suspendAgent							
						WHEN roleid =1 THEN @SuspendMember
						ELSE 0 END	
						
WHILE(1=1)
BEGIN			
	DELETE TOP (5000) t
	OUTPUT DELETED.custid, DELETED.SuspendInfo
	INTO @tmpCust(custid, suspendInfo)
	FROM #tblCust t
	
	SELECT @rowcount = @@ROWCOUNT
	
	UPDATE cs
	SET suspendInfo = t.SuspendInfo
	FROM custProductStatus cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN @tmpCust t ON cs.custid = t.custid
	
	IF @rowcount < 5000
		BREAK;
	
	DELETE @tmpCust
	
	WAITFOR DELAY '0:0:2'--wait for replication do others cmd
END

DROP TABLE #tblCust					
						