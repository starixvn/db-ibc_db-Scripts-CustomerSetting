/*
	Created: Johnson
	Date: 2020-01-10
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
		--SeqNo = 1
			--Non-LIVE HDP/1H HDP All sports -80%, -85%, -88% to -90%
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND (SUBSTRING(cs.bitmapVirtual,1,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,1,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,1,1) = CAST(12 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(bitmapVirtual, 1, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE bitmapVirtual END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND (SUBSTRING(cs.bitmapVirtual,7,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,7,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,7,1) = CAST(12 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 7, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND (SUBSTRING(cs.bitmapVirtual,13,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,13,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,13,1) = CAST(12 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 13, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND (SUBSTRING(cs.bitmapVirtual,19,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,19,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,19,1) = CAST(12 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 19, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND (SUBSTRING(cs.bitmapVirtual,25,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,25,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,25,1) = CAST(12 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 25, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND (SUBSTRING(cs.bitmapVirtual,31,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,31,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,31,1) = CAST(12 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 31, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND (SUBSTRING(cs.bitmapVirtual,37,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,37,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,37,1) = CAST(12 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 37, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND (SUBSTRING(cs.bitmapVirtual,45,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,45,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,45,1) = CAST(12 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 45, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND (SUBSTRING(cs.bitmapVirtual,55,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,55,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,55,1) = CAST(12 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 55, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND (SUBSTRING(cs.bitmapVirtual,63,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,63,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,63,1) = CAST(12 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 63, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			
			--Non-Live FT OU & 1H OU All sports -80%, -85%, -88%, -90% to -92%
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND (SUBSTRING(cs.bitmapVirtual,5,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,5,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,5,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,5,1) = CAST(10 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 5, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND (SUBSTRING(cs.bitmapVirtual,9,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,9,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,9,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,9,1) = CAST(10 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 9, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND (SUBSTRING(cs.bitmapVirtual,17,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,17,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,17,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,17,1) = CAST(10 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 17, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND (SUBSTRING(cs.bitmapVirtual,21,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,21,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,21,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,21,1) = CAST(10 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 21, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND (SUBSTRING(cs.bitmapVirtual,29,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,29,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,29,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,29,1) = CAST(10 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 29, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND (SUBSTRING(cs.bitmapVirtual,33,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,33,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,33,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,33,1) = CAST(10 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 33, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND (SUBSTRING(cs.bitmapVirtual,41,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,41,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,41,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,41,1) = CAST(10 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 41, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND (SUBSTRING(cs.bitmapVirtual,49,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,49,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,49,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,49,1) = CAST(10 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 49, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND (SUBSTRING(cs.bitmapVirtual,59,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,59,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,59,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,59,1) = CAST(10 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 59, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			
		--SeqNo = 2
			--Non-LIVE HDP/1H HDP All sports -80%, -85%, -88% to -90%
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND (SUBSTRING(cs.bitmapVirtual,7,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,7,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,7,1) = CAST(12 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(bitmapVirtual, 7, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE bitmapVirtual END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND (SUBSTRING(cs.bitmapVirtual,11,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,11,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,11,1) = CAST(12 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 11, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND (SUBSTRING(cs.bitmapVirtual,19,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,19,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,19,1) = CAST(12 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 19, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND (SUBSTRING(cs.bitmapVirtual,27,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,27,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,27,1) = CAST(12 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 27, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND (SUBSTRING(cs.bitmapVirtual,35,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,35,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,35,1) = CAST(12 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 35, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND (SUBSTRING(cs.bitmapVirtual,43,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,43,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,43,1) = CAST(12 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 43, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND (SUBSTRING(cs.bitmapVirtual,49,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,49,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,49,1) = CAST(12 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 49, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			
			--Non-Live FT OU & 1H OU All sports -80%, -85%, -88%, -90% to -92%
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND (SUBSTRING(cs.bitmapVirtual,3,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,3,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,3,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,3,1) = CAST(10 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 3, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND (SUBSTRING(cs.bitmapVirtual,9,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,9,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,9,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,9,1) = CAST(10 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 9, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND (SUBSTRING(cs.bitmapVirtual,13,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,13,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,13,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,13,1) = CAST(10 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 13, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND (SUBSTRING(cs.bitmapVirtual,23,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,23,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,23,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,23,1) = CAST(10 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 23, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND (SUBSTRING(cs.bitmapVirtual,31,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,31,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,31,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,31,1) = CAST(10 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 31, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND (SUBSTRING(cs.bitmapVirtual,39,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,39,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,39,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,39,1) = CAST(10 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 39, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND (SUBSTRING(cs.bitmapVirtual,47,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,47,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,47,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,47,1) = CAST(10 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 47, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND (SUBSTRING(cs.bitmapVirtual,51,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,51,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,51,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,51,1) = CAST(10 AS BINARY(1))) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 51, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			
			bitmapVirtual = CASE WHEN seqNo = 1 THEN @bitmapVirtual_tmp 
								WHEN seqNo = 2 THEN @bitmapVirtual_tmp2 
								ELSE bitmapVirtual END
		FROM dbo.CustVirtualSetting cs WITH(UPDLOCK,ROWLOCK)
		WHERE ((cs.seqNo = 1
				AND (
					--SeqNo = 1
					--Non-LIVE HDP/1H HDP All sports -80%, -85%, -88% to -90%
					(SUBSTRING(cs.bitmapVirtual,1,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,1,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,1,1) = CAST(12 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,7,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,7,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,7,1) = CAST(12 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,13,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,13,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,13,1) = CAST(12 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,19,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,19,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,19,1) = CAST(12 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,25,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,25,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,25,1) = CAST(12 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,31,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,31,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,31,1) = CAST(12 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,37,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,37,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,37,1) = CAST(12 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,45,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,45,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,45,1) = CAST(12 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,55,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,55,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,55,1) = CAST(12 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,63,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,63,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,63,1) = CAST(12 AS BINARY(1)))
					
					--Non-Live FT OU & 1H OU All sports -80%, -85%, -88%, -90% to -92%
					OR (SUBSTRING(cs.bitmapVirtual,5,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,5,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,5,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,5,1) = CAST(10 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,9,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,9,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,9,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,9,1) = CAST(10 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,17,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,17,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,17,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,17,1) = CAST(10 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,21,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,21,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,21,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,21,1) = CAST(10 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,29,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,29,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,29,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,29,1) = CAST(10 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,33,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,33,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,33,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,33,1) = CAST(10 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,41,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,41,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,41,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,41,1) = CAST(10 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,49,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,49,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,49,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,49,1) = CAST(10 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,59,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,59,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,59,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,59,1) = CAST(10 AS BINARY(1)))
					)
				)
			OR (cs.seqNo = 2
				AND (
					--SeqNo = 2
					--Non-LIVE HDP/1H HDP All sports -80%, -85%, -88% to -90%
					(SUBSTRING(cs.bitmapVirtual,7,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,7,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,7,1) = CAST(12 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,11,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,11,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,11,1) = CAST(12 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,19,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,19,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,19,1) = CAST(12 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,27,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,27,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,27,1) = CAST(12 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,35,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,35,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,35,1) = CAST(12 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,43,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,43,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,43,1) = CAST(12 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,49,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,49,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,49,1) = CAST(12 AS BINARY(1)))					
					
					--Non-Live FT OU & 1H OU All sports -80%, -85%, -88%, -90% to -92%
					OR (SUBSTRING(cs.bitmapVirtual,3,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,3,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,3,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,3,1) = CAST(10 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,9,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,9,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,9,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,9,1) = CAST(10 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,13,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,13,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,13,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,13,1) = CAST(10 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,23,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,23,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,23,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,23,1) = CAST(10 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,31,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,31,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,31,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,31,1) = CAST(10 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,39,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,39,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,39,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,39,1) = CAST(10 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,47,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,47,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,47,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,47,1) = CAST(10 AS BINARY(1)))
					OR (SUBSTRING(cs.bitmapVirtual,51,1) = CAST(20 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,51,1) = CAST(15 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,51,1) = CAST(12 AS BINARY(1)) OR SUBSTRING(cs.bitmapVirtual,51,1) = CAST(10 AS BINARY(1)))
					)
				)
			)
			AND cs.custid IN (SELECT custid FROM @tmpCust)	
	
			WAITFOR DELAY '00:00:00.1'
END		

DROP TABLE #tblCust		