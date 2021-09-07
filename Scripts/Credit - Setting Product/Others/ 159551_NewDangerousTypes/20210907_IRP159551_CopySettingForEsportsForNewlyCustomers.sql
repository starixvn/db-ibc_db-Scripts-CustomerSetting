/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210907@Johnson
	Task: copy danger setting for Esports from Other Sports for newly customers
	DB: DBCust/CustDB
*/

DECLARE @max_custid INT

SELECT @max_custid = xxx

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT (0))

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN custInfo C WITH (NOLOCK) ON C.custid = ci.custid	
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'	
	AND Enabled = 1
	
CREATE TABLE #tblCust (custid INT PRIMARY KEY)
DECLARE @tmp TABLE (custid INT PRIMARY KEY)

INSERT INTO #tblCust(custid)
SELECT custid
FROM custInfo ci WITH(NOLOCK) 
WHERE srecommend IN (SELECT custid FROM #supers)
	AND custid > @max_custid
	AND Danger3 IN (8, 9, 16, 17, 21)
	AND ISNULL(Danger5,0) <> Danger3

WHILE(1=1)
BEGIN
	DELETE TOP (500) t
	OUTPUT DELETED.custid INTO @tmp(custid)
	FROM #tblCust t
	
	IF @@ROWCOUNT = 0
		BREAK;
		
	UPDATE custInfo WITH(ROWLOCK)
	SET danger5 = Danger3
	WHERE custid IN (SELECT custid FROM @tmp)
		AND Danger3 IN (8, 9, 16, 17, 21)
		AND ISNULL(Danger5,0) <> Danger3
	
	DELETE @tmp
	
	WAITFOR DELAY '0:0:1'
END
	
DROP TABLE #tblCust	
DROP TABLE #supers		