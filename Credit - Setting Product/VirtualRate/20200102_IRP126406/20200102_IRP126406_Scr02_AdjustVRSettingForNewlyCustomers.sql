/*
	Created: Johnson
	Date: 2020-01-02
	Task: adjust virtual rate for UT/YEN currency for credit & All licensees for newly customers
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
DECLARE @bitmapVirtual_tmp BINARY(64),
		@bitmapVirtual_tmp2 BINARY(64)	

SELECT custid
INTO #tblCust
FROM custinfo ci WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers)
	AND custid > @max_custid

WHILE (1 =1)
BEGIN
	DELETE @tmpCust
	
	DELETE TOP (2500) t
	OUTPUT DELETED.custid
	INTO @tmpCust 
	FROM #tblCust t
	
	IF @@rowcount = 0 
		BREAK;	
		
	UPDATE cs
		SET 
			--LIVE HDP/1H HDP Soccer -80% OR -85% to -86%
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND (SUBSTRING(cs.bitmapVirtual,2,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,2,1) = CAST(15 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(bitmapVirtual, 2, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE bitmapVirtual END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND (SUBSTRING(cs.bitmapVirtual,8,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,8,1) = CAST(15 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 8, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND (SUBSTRING(cs.bitmapVirtual,14,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,14,1) = CAST(15 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 14, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND (SUBSTRING(cs.bitmapVirtual,20,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,20,1) = CAST(15 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 20, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND (SUBSTRING(cs.bitmapVirtual,26,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,26,1) = CAST(15 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 26, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND (SUBSTRING(cs.bitmapVirtual,32,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,32,1) = CAST(15 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 32, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND (SUBSTRING(cs.bitmapVirtual,38,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,38,1) = CAST(15 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 38, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND (SUBSTRING(cs.bitmapVirtual,46,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,46,1) = CAST(15 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 46, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND (SUBSTRING(cs.bitmapVirtual,56,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,56,1) = CAST(15 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 56, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND (SUBSTRING(cs.bitmapVirtual,64,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,64,1) = CAST(15 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 64, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND (SUBSTRING(cs.bitmapVirtual,8,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,8,1) = CAST(15 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(bitmapVirtual, 8, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE bitmapVirtual END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND (SUBSTRING(cs.bitmapVirtual,12,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,12,1) = CAST(15 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 12, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND (SUBSTRING(cs.bitmapVirtual,20,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,20,1) = CAST(15 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 20, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND (SUBSTRING(cs.bitmapVirtual,28,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,28,1) = CAST(15 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 28, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND (SUBSTRING(cs.bitmapVirtual,35,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,35,1) = CAST(15 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 35, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND (SUBSTRING(cs.bitmapVirtual,44,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,44,1) = CAST(15 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 44, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND (SUBSTRING(cs.bitmapVirtual,50,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,50,1) = CAST(15 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 50, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND (SUBSTRING(cs.bitmapVirtual,58,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,58,1) = CAST(15 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 58, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			
			bitmapVirtual = CASE WHEN seqNo = 1 THEN @bitmapVirtual_tmp 
								WHEN seqNo = 2 THEN @bitmapVirtual_tmp2 
								ELSE bitmapVirtual END
		FROM dbo.CustVirtualSetting cs WITH(UPDLOCK,ROWLOCK)
		WHERE ((cs.seqNo = 1
				AND (
					--LIVE HDP/1H HDP Soccer	
					(SUBSTRING(cs.bitmapVirtual,2,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,2,1) = CAST(15 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,8,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,8,1) = CAST(15 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,14,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,14,1) = CAST(15 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,20,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,20,1) = CAST(15 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,26,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,26,1) = CAST(15 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,32,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,32,1) = CAST(15 AS BINARY(1)))					
					OR (SUBSTRING(cs.bitmapVirtual,38,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,38,1) = CAST(15 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,46,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,46,1) = CAST(15 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,56,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,56,1) = CAST(15 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,64,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,64,1) = CAST(15 AS BINARY(1)))
					)
				)
				OR
				(cs.seqNo = 2
				AND (
					(SUBSTRING(cs.bitmapVirtual,8,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,8,1) = CAST(15 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,12,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,12,1) = CAST(15 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,20,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,20,1) = CAST(15 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,28,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,28,1) = CAST(15 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,35,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,35,1) = CAST(15 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,44,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,44,1) = CAST(15 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,50,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,50,1) = CAST(15 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,58,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,58,1) = CAST(15 AS BINARY(1)))					
					)
				)	
			)
		AND cs.custid IN (SELECT custid FROM @tmpCust)
			
		WAITFOR DELAY '00:00:00.1'
END	
	
DROP TABLE #tblCust	
