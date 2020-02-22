/*
	Created: Johnson
	Date: 2020-02-22
	Task: adjust virtual rate for DDD, IN, IND and IDD currency for credit
	DB: DBCUST/CUSTDB
*/

	DECLARE @tmpCust TABLE (custid INT PRIMARY KEY)
	DECLARE @bitmapVirtual_tmp BINARY(64),
			@bitmapVirtual_tmp2 BINARY(64)
	
	
	CREATE TABLE #supers (custid INT,  isfinished BIT DEFAULT(0))

	DECLARE @max_custid INT, @srecommend INT
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
		AND ci.currency IN(15	,--	IN
							22	,--	IND
							33	,--	IDD
							47	--	DDD
						) 	
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))


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
			--LIVE HDP/1H HDP All sports -60%, -80%, -85% to -86%
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,2,1) AS INT) IN (40,20,15) THEN CONVERT(BINARY(64),STUFF(bitmapVirtual, 2, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE bitmapVirtual END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,8,1) AS INT) IN (40,20,15) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 8, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,14,1) AS INT) IN (40,20,15) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 14, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,20,1) AS INT) IN (40,20,15) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 20, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,26,1) AS INT) IN (40,20,15) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 26, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,32,1) AS INT) IN (40,20,15) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 32, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,38,1) AS INT) IN (40,20,15) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 38, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,46,1) AS INT) IN (40,20,15) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 46, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,56,1) AS INT) IN (40,20,15) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 56, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,64,1) AS INT) IN (40,20,15) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 64, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			
			--Live FT OU & 1H OU All sports -60%, -80%, -85%, -86%, -88% to -90%
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,6,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 6, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,10,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 10, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,18,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 18, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,22,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 22, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,30,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 30, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,34,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 34, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,42,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 42, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,50,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 50, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,60,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 60, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			
			--Non-Live HDP/1H HDP All sports -60%, -80%, -85%, -86%, -88% to -90%
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,1,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 1, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,7,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 7, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,13,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 13, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,19,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 19, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,25,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 25, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,31,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 31, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,37,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 37, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,45,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 45, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,55,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 55, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,63,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 63, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			
			--Non-Live OU/1H OU All Sports -60%, -80%, -85%, -86%, -88%, -90% to -92%
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,5,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 5, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,9,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 9, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,17,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 17, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,21,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 21, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,29,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 29, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,33,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 33, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,41,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 41, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,49,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 49, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,59,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 59, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
						
		--SeqNo = 2
			--LIVE HDP/1H HDP All sports -60%, -80%, -85% to -86%
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,8,1) AS INT) IN (40,20,15) THEN CONVERT(BINARY(64),STUFF(bitmapVirtual, 8, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE bitmapVirtual END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,12,1) AS INT) IN (40,20,15) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 12, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,20,1) AS INT) IN (40,20,15) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 20, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,28,1) AS INT) IN (40,20,15) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 28, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,36,1) AS INT) IN (40,20,15) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 36, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,44,1) AS INT) IN (40,20,15) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 44, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,50,1) AS INT) IN (40,20,15) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 50, 1, CAST(CAST(14 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			
			--Live FT OU & 1H OU All sports -60%, -80%, -85%, -86%, -88% to -90%
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,4,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 4, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,10,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 10, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,14,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 14, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,24,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 24, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,32,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 32, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,40,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 40, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,48,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 48, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,52,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 52, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			
			--Non-Live HDP/1H HDP All sports -60%, -80%, -85%, -86%, -88% to -90%
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,7,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 7, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,11,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 11, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,19,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 19, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,27,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 27, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,35,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 35, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,43,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 43, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,49,1) AS INT) IN (40,20,15,14,12) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 49, 1, CAST(CAST(10 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			
			--Non-Live OU/1H OU All Sports -60%, -80%, -85%, -86%, -88%, -90% to -92%
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,3,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 3, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,9,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 9, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,13,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 13, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,23,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 23, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,31,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 31, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,39,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 39, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,47,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 47, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,51,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 51, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			
			
			bitmapVirtual = CASE WHEN seqNo = 1 THEN @bitmapVirtual_tmp 
								WHEN seqNo = 2 THEN @bitmapVirtual_tmp2 
								ELSE bitmapVirtual END
		FROM dbo.CustVirtualSetting cs WITH(UPDLOCK,ROWLOCK)
		WHERE ((cs.seqNo = 1
				AND (
					--SeqNo = 1
					--LIVE HDP/1H HDP All sports  -60%, -80%, -85% to -86%
					CAST(SUBSTRING(cs.bitmapVirtual,2,1) AS INT) IN (40,20,15)
					OR CAST(SUBSTRING(cs.bitmapVirtual,8,1) AS INT) IN (40,20,15)
					OR CAST(SUBSTRING(cs.bitmapVirtual,14,1) AS INT) IN (40,20,15)
					OR CAST(SUBSTRING(cs.bitmapVirtual,20,1) AS INT) IN (40,20,15)
					OR CAST(SUBSTRING(cs.bitmapVirtual,26,1) AS INT) IN (40,20,15)
					OR CAST(SUBSTRING(cs.bitmapVirtual,32,1) AS INT) IN (40,20,15)
					OR CAST(SUBSTRING(cs.bitmapVirtual,38,1) AS INT) IN (40,20,15)
					OR CAST(SUBSTRING(cs.bitmapVirtual,46,1) AS INT) IN (40,20,15)
					OR CAST(SUBSTRING(cs.bitmapVirtual,56,1) AS INT) IN (40,20,15)
					OR CAST(SUBSTRING(cs.bitmapVirtual,64,1) AS INT) IN (40,20,15)
					
					--Live FT OU & 1H OU All sports -60%, -80%, -85%, -86%, -88% to -90%
					OR CAST(SUBSTRING(cs.bitmapVirtual,6,1) AS INT) IN (40,20,15,14,12)
					OR CAST(SUBSTRING(cs.bitmapVirtual,10,1) AS INT) IN (40,20,15,14,12)
					OR CAST(SUBSTRING(cs.bitmapVirtual,18,1) AS INT) IN (40,20,15,14,12)
					OR CAST(SUBSTRING(cs.bitmapVirtual,22,1) AS INT) IN (40,20,15,14,12)
					OR CAST(SUBSTRING(cs.bitmapVirtual,30,1) AS INT) IN (40,20,15,14,12)
					OR CAST(SUBSTRING(cs.bitmapVirtual,34,1) AS INT) IN (40,20,15,14,12)
					OR CAST(SUBSTRING(cs.bitmapVirtual,42,1) AS INT) IN (40,20,15,14,12)
					OR CAST(SUBSTRING(cs.bitmapVirtual,50,1) AS INT) IN (40,20,15,14,12)
					OR CAST(SUBSTRING(cs.bitmapVirtual,60,1) AS INT) IN (40,20,15,14,12)
					
					--Non-Live HDP/1H HDP All sports -60%, -80%, -85%, -86%, -88% to -90%
					OR CAST(SUBSTRING(cs.bitmapVirtual,1,1) AS INT) IN (40,20,15,14,12)
					OR CAST(SUBSTRING(cs.bitmapVirtual,7,1) AS INT) IN (40,20,15,14,12)
					OR CAST(SUBSTRING(cs.bitmapVirtual,13,1) AS INT) IN (40,20,15,14,12)
					OR CAST(SUBSTRING(cs.bitmapVirtual,19,1) AS INT) IN (40,20,15,14,12)
					OR CAST(SUBSTRING(cs.bitmapVirtual,25,1) AS INT) IN (40,20,15,14,12)
					OR CAST(SUBSTRING(cs.bitmapVirtual,31,1) AS INT) IN (40,20,15,14,12)
					OR CAST(SUBSTRING(cs.bitmapVirtual,37,1) AS INT) IN (40,20,15,14,12)
					OR CAST(SUBSTRING(cs.bitmapVirtual,45,1) AS INT) IN (40,20,15,14,12)
					OR CAST(SUBSTRING(cs.bitmapVirtual,55,1) AS INT) IN (40,20,15,14,12)
					OR CAST(SUBSTRING(cs.bitmapVirtual,63,1) AS INT) IN (40,20,15,14,12)
					
					--Non-Live OU/1H OU All Sports -60%, -80%, -85%, -86%, -88%, -90% to -92%
					OR CAST(SUBSTRING(cs.bitmapVirtual,5,1) AS INT) IN (40,20,15,14,12,10)
					OR CAST(SUBSTRING(cs.bitmapVirtual,9,1) AS INT) IN (40,20,15,14,12,10)
					OR CAST(SUBSTRING(cs.bitmapVirtual,17,1) AS INT) IN (40,20,15,14,12,10)
					OR CAST(SUBSTRING(cs.bitmapVirtual,21,1) AS INT) IN (40,20,15,14,12,10)
					OR CAST(SUBSTRING(cs.bitmapVirtual,29,1) AS INT) IN (40,20,15,14,12,10)
					OR CAST(SUBSTRING(cs.bitmapVirtual,33,1) AS INT) IN (40,20,15,14,12,10)
					OR CAST(SUBSTRING(cs.bitmapVirtual,41,1) AS INT) IN (40,20,15,14,12,10)
					OR CAST(SUBSTRING(cs.bitmapVirtual,49,1) AS INT) IN (40,20,15,14,12,10)
					OR CAST(SUBSTRING(cs.bitmapVirtual,59,1) AS INT) IN (40,20,15,14,12,10)
					)
				)
			OR (cs.seqNo = 2
				AND (
					--SeqNo = 2					
					--LIVE HDP/1H HDP All sports  -60%, -80%, -85% to -86%
						CAST(SUBSTRING(cs.bitmapVirtual,8,1) AS INT) IN (40,20,15)
					OR CAST(SUBSTRING(cs.bitmapVirtual,12,1) AS INT) IN (40,20,15)
					OR CAST(SUBSTRING(cs.bitmapVirtual,20,1) AS INT) IN (40,20,15)
					OR CAST(SUBSTRING(cs.bitmapVirtual,28,1) AS INT) IN (40,20,15)
					OR CAST(SUBSTRING(cs.bitmapVirtual,36,1) AS INT) IN (40,20,15)
					OR CAST(SUBSTRING(cs.bitmapVirtual,44,1) AS INT) IN (40,20,15)
					OR CAST(SUBSTRING(cs.bitmapVirtual,50,1) AS INT) IN (40,20,15)
					
					--Live FT OU & 1H OU All sports -60%, -80%, -85%, -86%, -88% to -90%
					OR CAST(SUBSTRING(cs.bitmapVirtual,1,1) AS INT) IN (40,20,15,14,12)					
					OR CAST(SUBSTRING(cs.bitmapVirtual,10,1) AS INT) IN (40,20,15,14,12)
					OR CAST(SUBSTRING(cs.bitmapVirtual,14,1) AS INT) IN (40,20,15,14,12)
					OR CAST(SUBSTRING(cs.bitmapVirtual,24,1) AS INT) IN (40,20,15,14,12)
					OR CAST(SUBSTRING(cs.bitmapVirtual,32,1) AS INT) IN (40,20,15,14,12)
					OR CAST(SUBSTRING(cs.bitmapVirtual,40,1) AS INT) IN (40,20,15,14,12)
					OR CAST(SUBSTRING(cs.bitmapVirtual,48,1) AS INT) IN (40,20,15,14,12)
					OR CAST(SUBSTRING(cs.bitmapVirtual,52,1) AS INT) IN (40,20,15,14,12)
					
					--Non-Live HDP/1H HDP All sports -60%, -80%, -85%, -86%, -88% to -90%
					OR CAST(SUBSTRING(cs.bitmapVirtual,7,1) AS INT) IN (40,20,15,14,12)
					OR CAST(SUBSTRING(cs.bitmapVirtual,11,1) AS INT) IN (40,20,15,14,12)
					OR CAST(SUBSTRING(cs.bitmapVirtual,19,1) AS INT) IN (40,20,15,14,12)
					OR CAST(SUBSTRING(cs.bitmapVirtual,27,1) AS INT) IN (40,20,15,14,12)
					OR CAST(SUBSTRING(cs.bitmapVirtual,35,1) AS INT) IN (40,20,15,14,12)
					OR CAST(SUBSTRING(cs.bitmapVirtual,43,1) AS INT) IN (40,20,15,14,12)
					OR CAST(SUBSTRING(cs.bitmapVirtual,49,1) AS INT) IN (40,20,15,14,12)
					
					--Non-Live OU/1H OU All Sports -60%, -80%, -85%, -86%, -88%, -90% to -92%
					OR CAST(SUBSTRING(cs.bitmapVirtual,3,1) AS INT) IN (40,20,15,14,12,10)
					OR CAST(SUBSTRING(cs.bitmapVirtual,9,1) AS INT) IN (40,20,15,14,12,10)
					OR CAST(SUBSTRING(cs.bitmapVirtual,13,1) AS INT) IN (40,20,15,14,12,10)
					OR CAST(SUBSTRING(cs.bitmapVirtual,23,1) AS INT) IN (40,20,15,14,12,10)
					OR CAST(SUBSTRING(cs.bitmapVirtual,31,1) AS INT) IN (40,20,15,14,12,10)
					OR CAST(SUBSTRING(cs.bitmapVirtual,39,1) AS INT) IN (40,20,15,14,12,10)
					OR CAST(SUBSTRING(cs.bitmapVirtual,47,1) AS INT) IN (40,20,15,14,12,10)
					OR CAST(SUBSTRING(cs.bitmapVirtual,51,1) AS INT) IN (40,20,15,14,12,10)					
					)
				)
			)
			AND cs.custid IN (SELECT custid FROM @tmpCust)	
	
			WAITFOR DELAY '00:00:00.1'
	END	
	