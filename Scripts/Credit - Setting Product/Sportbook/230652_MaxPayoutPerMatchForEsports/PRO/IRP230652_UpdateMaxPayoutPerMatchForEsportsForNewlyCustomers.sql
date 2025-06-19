/*<info serverAlias="DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250618@Johnson	
	Task: Update Max Payout Per Match for E-Sports [redmine:#230652]
	DB: DBCUST-CustDB
*/
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT
SELECT @max_custid = xxx

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
	--AND ci.currency <> 20
	
CREATE TABLE #tblCust(CustID INT PRIMARY KEY CLUSTERED, roleid TINYINT)
CREATE TABLE #tmpCust (CustID INT PRIMARY KEY CLUSTERED)

INSERT INTO #tblCust (CustID, roleid)
SELECT custid, roleid
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers)
    AND Enabled = 1 
    AND custid > @max_custid

WHILE(1=1)
BEGIN
    DELETE TOP (1000) t
    OUTPUT DELETED.CustID INTO #tmpCust(custid)
    FROM #tblCust t
    WHERE roleid > 1

    IF @@ROWCOUNT = 0 BREAK 

    UPDATE BetSetting_Agent WITH (ROWLOCK)
    SET MaxPayoutPerMatch = 10*MaxPerMatch,
        RepUpdateTime = dbo.f_GetDateTime2()
    WHERE custid IN (SELECT CustID FROM #tmpCust)
        AND Sporttype IN (43,44)

    DELETE FROM #tmpCust    
    WAITFOR DELAY '00:00:00.28' 
END

WHILE(1=1)
BEGIN
    DELETE TOP (1000) t
    OUTPUT DELETED.CustID INTO #tmpCust(custid)
    FROM #tblCust t
    WHERE roleid = 1

    IF @@ROWCOUNT = 0 BREAK 

    UPDATE BetSetting_Member WITH (ROWLOCK)
    SET MaxPayoutPerMatch = 10*MaxPerMatch,
        RepUpdateTime = dbo.f_GetDateTime2()
    WHERE custid IN (SELECT CustID FROM #tmpCust)
        AND Sporttype IN (43,44)

    DELETE FROM #tmpCust    
    WAITFOR DELAY '00:00:00.28' 
END

DROP TABLE #tblCust
DROP TABLE #tmpCust