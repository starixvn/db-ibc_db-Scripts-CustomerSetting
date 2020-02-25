/*
	Created: Johnson
	Date: 2020-02-25
	Task: adjust virtual rate for credit under YEN currency
	DB: DBCUST/CUSTDB
*/
-- BEGIN STEP 1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
------------------------------------------------------

ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
	@srecommend INT	
	,@max_custid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustVirtualSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN	
	
	DECLARE @tmpCust TABLE (custid INT PRIMARY KEY)
	DECLARE @bitmapVirtual_tmp BINARY(64),
			@bitmapVirtual_tmp2 BINARY(64)
	
	SELECT custid
	INTO #tblCust
	FROM custinfo ci WITH(NOLOCK)
	WHERE srecommend = @srecommend
		AND custid <= @max_custid
	
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
			--LIVE HDP/1H HDP All sports -60%, -80%, -85%, -86% to -88%
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,2,1) AS INT) IN (40,20,15,14) THEN CONVERT(BINARY(64),STUFF(bitmapVirtual, 2, 1, CAST(CAST(12 AS BINARY(1)) AS VARCHAR))) ELSE bitmapVirtual END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,8,1) AS INT) IN (40,20,15,14) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 8, 1, CAST(CAST(12 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,14,1) AS INT) IN (40,20,15,14) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 14, 1, CAST(CAST(12 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,20,1) AS INT) IN (40,20,15,14) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 20, 1, CAST(CAST(12 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,26,1) AS INT) IN (40,20,15,14) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 26, 1, CAST(CAST(12 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,32,1) AS INT) IN (40,20,15,14) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 32, 1, CAST(CAST(12 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,38,1) AS INT) IN (40,20,15,14) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 38, 1, CAST(CAST(12 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,46,1) AS INT) IN (40,20,15,14) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 46, 1, CAST(CAST(12 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,56,1) AS INT) IN (40,20,15,14) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 56, 1, CAST(CAST(12 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,64,1) AS INT) IN (40,20,15,14) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 64, 1, CAST(CAST(12 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			
			--Live FT OU & 1H OU All sports -60%, -80%, -85%, -86%, -88%, -90% to -92%
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,6,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 6, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,10,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 10, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,18,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 18, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,22,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 22, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,30,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 30, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,34,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 34, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,42,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 42, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,50,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 50, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND CAST(SUBSTRING(cs.bitmapVirtual,60,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 60, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
			
		--SeqNo = 2
			--LIVE HDP/1H HDP All sports -60%, -80%, -85%, -86% to -88%
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,8,1) AS INT) IN (40,20,15,14) THEN CONVERT(BINARY(64),STUFF(bitmapVirtual, 8, 1, CAST(CAST(12 AS BINARY(1)) AS VARCHAR))) ELSE bitmapVirtual END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,12,1) AS INT) IN (40,20,15,14) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 12, 1, CAST(CAST(12 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,20,1) AS INT) IN (40,20,15,14) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 20, 1, CAST(CAST(12 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,28,1) AS INT) IN (40,20,15,14) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 28, 1, CAST(CAST(12 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,36,1) AS INT) IN (40,20,15,14) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 36, 1, CAST(CAST(12 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,44,1) AS INT) IN (40,20,15,14) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 44, 1, CAST(CAST(12 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,50,1) AS INT) IN (40,20,15,14) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 50, 1, CAST(CAST(12 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			
			--Live FT OU & 1H OU All sports -60%, -80%, -85%, -86%, -88%, -90% to -92%
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,4,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 4, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,10,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 10, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,14,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 14, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,24,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 24, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,32,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 32, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,40,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 40, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,48,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 48, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND CAST(SUBSTRING(cs.bitmapVirtual,52,1) AS INT) IN (40,20,15,14,12,10) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 52, 1, CAST(CAST(8 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
			
			bitmapVirtual = CASE WHEN seqNo = 1 THEN @bitmapVirtual_tmp 
								WHEN seqNo = 2 THEN @bitmapVirtual_tmp2 
								ELSE bitmapVirtual END
		FROM dbo.CustVirtualSetting cs WITH(UPDLOCK,ROWLOCK)
		WHERE ((cs.seqNo = 1
				AND (
					--SeqNo = 1
					--LIVE HDP/1H HDP All sports  -60%, -80%, -85% to -86%
					CAST(SUBSTRING(cs.bitmapVirtual,2,1) AS INT) IN (40,20,15,14)
					OR CAST(SUBSTRING(cs.bitmapVirtual,8,1) AS INT) IN (40,20,15,14)
					OR CAST(SUBSTRING(cs.bitmapVirtual,14,1) AS INT) IN (40,20,15,14)
					OR CAST(SUBSTRING(cs.bitmapVirtual,20,1) AS INT) IN (40,20,15,14)
					OR CAST(SUBSTRING(cs.bitmapVirtual,26,1) AS INT) IN (40,20,15,14)
					OR CAST(SUBSTRING(cs.bitmapVirtual,32,1) AS INT) IN (40,20,15,14)
					OR CAST(SUBSTRING(cs.bitmapVirtual,38,1) AS INT) IN (40,20,15,14)
					OR CAST(SUBSTRING(cs.bitmapVirtual,46,1) AS INT) IN (40,20,15,14)
					OR CAST(SUBSTRING(cs.bitmapVirtual,56,1) AS INT) IN (40,20,15,14)
					OR CAST(SUBSTRING(cs.bitmapVirtual,64,1) AS INT) IN (40,20,15,14)
					
					--Live FT OU & 1H OU All sports -60%, -80%, -85%, -86%, -88% to -90%
					OR CAST(SUBSTRING(cs.bitmapVirtual,6,1) AS INT) IN (40,20,15,14,12,10)
					OR CAST(SUBSTRING(cs.bitmapVirtual,10,1) AS INT) IN (40,20,15,14,12,10)
					OR CAST(SUBSTRING(cs.bitmapVirtual,18,1) AS INT) IN (40,20,15,14,12,10)
					OR CAST(SUBSTRING(cs.bitmapVirtual,22,1) AS INT) IN (40,20,15,14,12,10)
					OR CAST(SUBSTRING(cs.bitmapVirtual,30,1) AS INT) IN (40,20,15,14,12,10)
					OR CAST(SUBSTRING(cs.bitmapVirtual,34,1) AS INT) IN (40,20,15,14,12,10)
					OR CAST(SUBSTRING(cs.bitmapVirtual,42,1) AS INT) IN (40,20,15,14,12,10)
					OR CAST(SUBSTRING(cs.bitmapVirtual,50,1) AS INT) IN (40,20,15,14,12,10)
					OR CAST(SUBSTRING(cs.bitmapVirtual,60,1) AS INT) IN (40,20,15,14,12,10)
					)
				)
			OR (cs.seqNo = 2
				AND (
					--SeqNo = 2					
					--LIVE HDP/1H HDP All sports  -60%, -80%, -85% to -86%
						CAST(SUBSTRING(cs.bitmapVirtual,8,1) AS INT) IN (40,20,15,14)
					OR CAST(SUBSTRING(cs.bitmapVirtual,12,1) AS INT) IN (40,20,15,14)
					OR CAST(SUBSTRING(cs.bitmapVirtual,20,1) AS INT) IN (40,20,15,14)
					OR CAST(SUBSTRING(cs.bitmapVirtual,28,1) AS INT) IN (40,20,15,14)
					OR CAST(SUBSTRING(cs.bitmapVirtual,36,1) AS INT) IN (40,20,15,14)
					OR CAST(SUBSTRING(cs.bitmapVirtual,44,1) AS INT) IN (40,20,15,14)
					OR CAST(SUBSTRING(cs.bitmapVirtual,50,1) AS INT) IN (40,20,15,14)
					
					--Live FT OU & 1H OU All sports -60%, -80%, -85%, -86%, -88% to -90%
					OR CAST(SUBSTRING(cs.bitmapVirtual,4,1) AS INT) IN (40,20,15,14,12,10)					
					OR CAST(SUBSTRING(cs.bitmapVirtual,10,1) AS INT) IN (40,20,15,14,12,10)
					OR CAST(SUBSTRING(cs.bitmapVirtual,14,1) AS INT) IN (40,20,15,14,12,10)
					OR CAST(SUBSTRING(cs.bitmapVirtual,24,1) AS INT) IN (40,20,15,14,12,10)
					OR CAST(SUBSTRING(cs.bitmapVirtual,32,1) AS INT) IN (40,20,15,14,12,10)
					OR CAST(SUBSTRING(cs.bitmapVirtual,40,1) AS INT) IN (40,20,15,14,12,10)
					OR CAST(SUBSTRING(cs.bitmapVirtual,48,1) AS INT) IN (40,20,15,14,12,10)
					OR CAST(SUBSTRING(cs.bitmapVirtual,52,1) AS INT) IN (40,20,15,14,12,10)
					)
				)
			)
			AND cs.custid IN (SELECT custid FROM @tmpCust)	
	
			WAITFOR DELAY '00:00:00.1'
	END	
	
	DROP TABLE #tblCust		
END		
GO
-- END STEP 1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 2: Run this SP at replicated DB -----
--------------------------------------------------------------------------------------

CREATE TABLE #supers (custid INT,  isfinished BIT DEFAULT(0))

DECLARE @max_custid INT, @srecommend INT
SELECT  @max_custid= xxx ---input maxcustid

INSERT INTO #supers(custid)
--get list supers for credit
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND s.islicensee = 0
	AND ci.currency IN(16) --YEN
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid		
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_CustSetting3rd_19] 
			@srecommend = @srecommend, 			
			@max_custid=@max_custid,			
			@target = 'REPLICATED' 	
				
	--WAITFOR DELAY '00:00:00.280'			
END			
GO		

-- END STEP 2: Run this SP at replicated DB -----
-----------------------------------------------------------------------------------



---
-- BEGIN STEP 3: Run this SP at DBCust -----
-------------------------------------------------	

CREATE TABLE #supers (custid INT,  isfinished BIT DEFAULT(0))

DECLARE @max_custid INT, @srecommend INT
SELECT  @max_custid= xxx ---input maxcustid

INSERT INTO #supers(custid)
--get list supers for credit
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND s.islicensee = 0
	AND ci.currency IN(16) --YEN
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid		
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_CustSetting3rd_19] 
			@srecommend = @srecommend, 			
			@max_custid=@max_custid,			
			@target = 'DBCUST' 	
				
	--WAITFOR DELAY '00:00:00.280'			
END			
GO	

-- END STEP 3: Run this SP at DBCust -----
-------------------------------------------------	

