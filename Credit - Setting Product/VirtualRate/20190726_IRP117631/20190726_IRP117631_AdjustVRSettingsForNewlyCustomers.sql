/*
	Created: Johnson
	Date: 2019-07-26
	Task: adjust virtual rate for UT/YEN currency for newly customers of credit & licensees
	DB: DBCUST/CUSTDB
*/


CREATE TABLE #supers (custid INT,  isfinished BIT DEFAULT(0))

DECLARE @max_custid INT
SELECT  @max_custid= xxx ---input maxcustid

INSERT INTO #supers(custid)
--get list supers for credit
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND s.islicensee = 0
	AND ci.currency IN(16,64) --YEN/UT currency	
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
UNION ALL
	--all licensees
	SELECT custid
	FROM dbo.Dep_CustSuper WITH(NOLOCK)

DECLARE @tmpCust TABLE (custid INT PRIMARY KEY)
DECLARE @bitmapVirtual_tmp BINARY(64)	

SELECT custid
INTO #tblCust
FROM custinfo ci WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers)
	AND custid > @max_custid

WHILE (1 =1)
BEGIN
	DELETE @tmpCust
	
	DELETE TOP (5000) t
	OUTPUT DELETED.custid
	INTO @tmpCust 
	FROM #tblCust t
	
	IF @@rowcount = 0 
		BREAK;		

	UPDATE cs
	SET @bitmapVirtual_tmp = CASE WHEN SUBSTRING(cs.bitmapVirtual,2,1) = CAST(15 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(bitmapVirtual, 2, 1, CAST(CAST(20 AS BINARY(1)) AS VARCHAR))) ELSE bitmapVirtual END,
		bitmapVirtual = CASE WHEN SUBSTRING(cs.bitmapVirtual,8,1) = CAST(15 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 8, 1, CAST(CAST(20 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END
	FROM dbo.CustVirtualSetting cs WITH(UPDLOCK,ROWLOCK)
	WHERE cs.seqNo = 1
		AND (SUBSTRING(cs.bitmapVirtual,2,1) = CAST(15 AS BINARY(1))
			OR SUBSTRING(cs.bitmapVirtual,8,1) = CAST(15 AS BINARY(1))
			)		
		AND cs.custid IN (SELECT custid FROM @tmpCust)
	
	WAITFOR DELAY '00:00:00.1'
END	

DROP TABLE #tblCust	

