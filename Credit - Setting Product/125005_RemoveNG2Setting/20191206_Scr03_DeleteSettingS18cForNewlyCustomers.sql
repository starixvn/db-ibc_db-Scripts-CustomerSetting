/*
	Created: Johnson
	Date: 2019-12-06
	Task: delete settings for sport 18C of NG2	for newly customers
	DB: DBCUST/CUSTDB
*/

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))

DECLARE @max_custid INT, @srecommend INT
SELECT  @max_custid= xxx ---input maxcustid

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4 	
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0	
	AND EXISTS(SELECT TOP 1 1 
			FROM CustPTSetting3rd_Agent WITH(NOLOCK) 
			WHERE custid = ci.custid AND sporttype = 216
			)
			
CREATE TABLE #tblCust(custid INT PRIMARY KEY, roleid TINYINT)
DECLARE @tmpCust TABLE(custid INT PRIMARY KEY)
DECLARE @count INT 

INSERT INTO #tblCust(custid,roleid)
SELECT custid, roleid 	
FROM dbo.custInfo WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers)
	AND custid > @max_custid

DELETE CustPTGroupSetting3rd_Member WITH(UPDLOCK,ROWLOCK)
WHERE AgentID IN (SELECT custid FROM #tblCust WHERE roleid = 2)
	AND sporttype = 216
	
WHILE(1=1)
BEGIN
	DELETE TOP (500) t
	OUTPUT DELETED.custid INTO @tmpCust
	FROM #tblCust t
	WHERE roleid IN (2,3,4)
	
	SELECT @count = @@ROWCOUNT
	
	DELETE CustPTSetting3rd_Agent WITH(UPDLOCK,ROWLOCK)
	WHERE custid IN (SELECT custid FROM @tmpCust)
		AND sporttype = 216
	
	DELETE CustBetSetting3rd_Agent WITH(UPDLOCK,ROWLOCK)
	WHERE custid IN (SELECT custid FROM @tmpCust)
		AND sporttype = 216 
		
	IF @count < 500
		BREAK;
	
	DELETE @tmpCust
END

DELETE @tmpCust

WHILE(1=1)
BEGIN
	DELETE TOP (500) t
	OUTPUT DELETED.custid INTO @tmpCust
	FROM #tblCust t
	WHERE roleid = 1
	
	SELECT @count = @@ROWCOUNT
	
	--2 rows setting for each customer
	DELETE CustPTSetting3rd_Member WITH(UPDLOCK,ROWLOCK)
	WHERE custid IN (SELECT custid FROM @tmpCust)
		AND sporttype = 216
	
	--11 rows setting for each customer
	DELETE CustBetSetting3rd_Member WITH(UPDLOCK,ROWLOCK)
	WHERE custid IN (SELECT custid FROM @tmpCust)
		AND sporttype = 216 
		
	IF @count < 500
		BREAK;
	
	DELETE @tmpCust
END	

GO		