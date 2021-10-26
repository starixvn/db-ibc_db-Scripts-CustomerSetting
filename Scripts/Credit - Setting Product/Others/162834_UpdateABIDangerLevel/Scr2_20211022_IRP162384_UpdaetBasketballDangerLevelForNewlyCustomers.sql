/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211022@Johnson
	Task: update basketball danger level 
	DB: DBCust/CustDB
*/

DECLARE @max_custid INT

SELECT @max_custid = xxx

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT (0))
CREATE TABLE #tblCust (custid INT PRIMARY KEY)
DECLARE @tmp TABLE (custid INT PRIMARY KEY)


INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN custInfo C WITH (NOLOCK) ON C.custid = ci.custid	
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'	
	AND Enabled = 1
	
INSERT INTO #tblCust(custid)
SELECT custid
FROM custInfo ci WITH(NOLOCK) 
WHERE srecommend IN (SELECT custid FROM #supers)
	AND custid > @max_custid
	AND Danger2 IN (11,16)
	AND 1 = CASE WHEN Danger2 = 11 AND ISNULL(Danger4,0) <> 15 THEN 1
				WHEN Danger2 = 16 AND ISNULL(Danger4,0) <> 49 THEN 1
				ELSE 0 END
	
WHILE(1=1)
BEGIN
	DELETE TOP (500) t
	OUTPUT DELETED.custid INTO @tmp(custid)
	FROM #tblCust t
	
	IF @@ROWCOUNT = 0
		BREAK;
		
	UPDATE custInfo WITH(ROWLOCK)
	SET danger4 = CASE WHEN Danger2 = 11 THEN 15
						WHEN Danger2 = 16 THEN 49
						ELSE Danger4 END
	WHERE custid IN (SELECT custid FROM @tmp)
				
	DELETE @tmp
	
	WAITFOR DELAY '0:0:1'
END
	
DROP TABLE #tblCust			
DROP TABLE #supers