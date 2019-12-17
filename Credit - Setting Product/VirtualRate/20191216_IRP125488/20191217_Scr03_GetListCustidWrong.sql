/*
	Created: Johnson
	Date: 2019-12-17
	Task: adjust virtual rate for UT/YEN currency for credit & All licensees
	DB: DBCUST/CUSTDB
*/


CREATE TABLE #supers (custid INT,  isfinished BIT DEFAULT(0))

DECLARE @max_custid INT, @srecommend INT

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
	
SELECT cs.*
into Tmp_CustVirtual
FROM custinfo ci (NOLOCK)
	INNER JOIN dbo.CustVirtualSetting cs WITH(NOLOCK) ON cs.custid = ci.custid
WHERE srecommend in (SELECT custid FROM #supers)	
AND ((cs.seqNo = 1
				AND (					
					--OU/1H OU
					SUBSTRING(cs.bitmapVirtual,5,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,6,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,9,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,10,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,17,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,18,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,21,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,22,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,29,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,30,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,33,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,34,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,41,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,42,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,49,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,50,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,59,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,60,1) = CAST(15 AS BINARY(1))				
					)		
				)
				OR
				( cs.seqNo = 2
				AND 
					(SUBSTRING(cs.bitmapVirtual,3,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,4,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,9,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,10,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,13,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,14,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,23,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,24,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,31,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,32,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,39,1) = CAST(15 AS BINARY(1))					
					OR SUBSTRING(cs.bitmapVirtual,40,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,47,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,48,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,51,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,52,1) = CAST(15 AS BINARY(1))										
					)
				)
			)	