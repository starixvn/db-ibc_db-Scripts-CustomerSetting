/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20241023@Johnson
	Task: remove customer settings for bitcoin for new customers [redmine: #201396]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT
SELECT @max_custid = xxx

CREATE TABLE #tblCust (custid INT PRIMARY KEY, roleid TINYINT)
DECLARE @BatchCust TABLE (custid INT PRIMARY KEY)
DECLARE @Sporttype INT = 175,
		@Bettype INT = 7901
				
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

INSERT INTO #tblCust(custid,roleid)
SELECT custid, roleid
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers)
	AND Enabled = 1 
	AND custid > @max_custid 
	
DELETE cs
FROM CustPTGroupSetting3rd_Member cs WITH(ROWLOCK)
WHERE AgentID IN (SELECT custid FROM #tblCust WHERE roleid = 2)
	AND Sporttype = @Sporttype
	AND Bettype = @Bettype	
	
WHILE (1=1)
BEGIN
	DELETE TOP (1000) t
	OUTPUT DELETED.custid INTO @BatchCust(custid)
	FROM #tblCust t
	WHERE roleid > 1
	
	IF @@ROWCOUNT = 0
		BREAK;
		
	DELETE cs
	FROM CustPTSetting3rd_Agent cs WITH(ROWLOCK)
	WHERE custid IN (SELECT custid FROM @BatchCust)
		AND Sporttype = @Sporttype
		AND Bettype = @Bettype	
	
	DELETE cs
	FROM CustDiscount3rd_Agent cs WITH(ROWLOCK)
	WHERE custid IN (SELECT custid FROM @BatchCust)
		AND Sporttype = @Sporttype
		AND Bettype = @Bettype	
	
	DELETE @BatchCust
	
	WAITFOR DELAY '0:0:0.5'
END

WHILE (1=1)
BEGIN
	DELETE TOP (1000) t
	OUTPUT DELETED.custid INTO @BatchCust(custid)
	FROM #tblCust t
	WHERE roleid = 1
	
	IF @@ROWCOUNT = 0
		BREAK;
		
	DELETE cs
	FROM CustPTSetting3rd_Member cs WITH(ROWLOCK)
	WHERE custid IN (SELECT custid FROM @BatchCust)
		AND Sporttype = @Sporttype
		AND Bettype = @Bettype	
	
	DELETE cs
	FROM CustDiscount3rd_Member cs WITH(ROWLOCK)
	WHERE custid IN (SELECT custid FROM @BatchCust)
		AND Sporttype = @Sporttype
		AND Bettype = @Bettype	
	
	DELETE @BatchCust	
	WAITFOR DELAY '0:0:0.5'
END	
GO

--Remove MyamarOdds Comm
--423 rows affected
DELETE CustDiscount3rd_Agent WITH(ROWLOCK)
WHERE SportType = 2
	AND BetType = 1
GO
	
--1398 rows affected
DELETE CustDiscount3rd_Member WITH(ROWLOCK)
WHERE SportType = 2
	AND BetType = 1	
GO	

--1516 rows affected
DELETE CustPTTemplateDetail WITH(ROWLOCK)
WHERE GroupID = 4 
	AND SubGroupID = 10	

