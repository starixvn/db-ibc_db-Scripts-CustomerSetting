/*
	Created: Johnson
	Date: 2019-10-14
	Task: adjust virtual rate for other sports
	DB: DBCUST/CUSTDB
*/

CREATE TABLE #supers (custid INT,  isfinished BIT DEFAULT(0))
DECLARE @tmpCust TABLE (custid INT)

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
	AND ci.custid NOT IN(SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
UNION ALL
	--all licensees
	SELECT custid
	FROM dbo.Dep_CustSuper WITH(NOLOCK)
	
SELECT custid
INTO #tblCust
FROM custinfo ci WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM #Supers)
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
			
	UPDATE cs
	SET bitmapVirtual=  CONVERT(
					BINARY(64),						
					CASE WHEN seqNo = 1 THEN SUBSTRING(bitmapVirtual,1,12) ELSE 0x END +
							 CONVERT(
									BINARY(64),
									REPLACE(
											CASE WHEN seqNo = 1 THEN SUBSTRING(bitmapVirtual,13,len(bitmapVirtual)) ELSE bitmapVirtual END
										,	CAST(CAST(150 AS BINARY(1)) AS VARCHAR)	-- Virtual Rate +50%
										,	CAST(CAST(100 AS BINARY(1)) AS VARCHAR)	-- replaced with Virtual Rate 0
											)
									)		
				)
	FROM CustVirtualSetting cs with(ROWLOCK,UPDLOCK)
	WHERE custid IN (SELECT custid FROM @tmpCust)
		AND CASE WHEN seqNo = 1 THEN SUBSTRING(bitmapVirtual,13,len(bitmapVirtual)) ELSE bitmapVirtual END LIKE '%[' + CAST(CAST(150 AS BINARY(1)) AS VARCHAR) + ']%'
	
	UPDATE cs
	SET ValueIDLive = CASE WHEN ValueIDLive = 33 THEN 19 ELSE ValueIDLive END,
		ValueIDNonLive = CASE WHEN ValueIDNonLive = 33 THEN 19 ELSE ValueIDNonLive END
	FROM VRCustSetting cs WITH(UPDLOCK,ROWLOCK)
	WHERE custid IN (SELECT custid FROM @tmpCust)
		AND (ValueIDLive = 33 --50%
			OR ValueIDNonLive = 33)
	
	WAITFOR DELAY '00:00:00.1'	
END	