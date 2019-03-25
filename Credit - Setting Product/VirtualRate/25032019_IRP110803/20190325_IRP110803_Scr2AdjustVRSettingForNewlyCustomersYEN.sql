/*
	Created: Johnson
	Date: 2019-03-25
	Task: adjust virtual rate 
	DB: DBCUST/CUSTDB
*/


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
	AND ci.currency = 16 --YEN currency	
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	
DECLARE @tmpCust TABLE (custid INT PRIMARY KEY)
	
	SELECT custid
	INTO #tblCust
	FROM custinfo ci WITH(NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers)
		AND custid > @max_custid
	
	WHILE (1 =1)
	BEGIN
		DELETE @tmpCust
		
		DELETE TOP (1500) t
		OUTPUT DELETED.custid
		INTO @tmpCust 
		FROM #tblCust t
		
		IF @@rowcount = 0 
			BREAK;
		
		UPDATE	cvs 
		SET		cvs.bitmapVirtual =	CONVERT(
										BINARY(64)
									,	REPLACE(
											cvs.bitmapVirtual
										,	CAST(CAST(20 AS BINARY(1)) AS VARCHAR)	-- Virtual Rate -80%
										,	CAST(CAST(15 AS BINARY(1)) AS VARCHAR)	-- replaced with Virtual Rate -85%
										)
									)

		FROM		dbo.CustVirtualSetting AS cvs WITH(ROWLOCK,UPDLOCK)			
		WHERE	
			cvs.bitmapVirtual LIKE '%[' + CAST(CAST(20 AS BINARY(1)) AS VARCHAR) + ']%'	-- Update rows that containt Virtual Rate -80% only
			AND cvs.custid IN (SELECT custid FROM @tmpCust)
		
		WAITFOR DELAY '00:00:00.1'
	END
	
	DROP TABLE #tblCust