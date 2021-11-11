/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211105@Johnson
	Task: copy settings for new games keno for newly uus customers ON PRO
	DB: DBCust/CustDB
*/


DECLARE @Custid INT, @max_custid INT

SELECT @max_custid = xxx

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT (0))

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN custInfo C WITH (NOLOCK) ON C.custid = ci.custid	
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid	
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'	
	AND Enabled = 1	
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND ci.currency = 20
	AND cs.isinternal = 0
	AND s.islicensee = 0
	
CREATE TABLE #tblCust (custid INT PRIMARY KEY)
DECLARE @tmp TABLE (custid INT PRIMARY KEY)

INSERT INTO #tblCust(custid)
SELECT custid
FROM custinfo WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers)
	AND enabled = 1
	AND custid > @max_custid

WHILE(1=1)
BEGIN
	DELETE TOP (500) t
	OUTPUT DELETED.custid INTO @tmp(custid)
	FROM #tblCust t
	
	IF @@ROWCOUNT = 0
		BREAK;
	
	INSERT INTO [dbo].[CustGameType]
		   ([CustID]
		   ,[GameTypeID]
		   ,[StakeLevelList]
		   ,[MaxPerGameType]
		   ,[MinBet]
		   ,[MaxBet]
		   ,[IsDisabled])
	SELECT cs.CustID
		   ,t.GameTypeID
		   ,cs.[StakeLevelList]
		   ,cs.[MaxPerGameType]
		   ,cs.[MinBet]
		   ,cs.[MaxBet]
		   ,cs.[IsDisabled]
	FROM CustGameType cs WITH(NOLOCK)
		CROSS APPLY (SELECT 30 as GameTypeID UNION SELECT 31) t
		LEFT JOIN CustGameType cs2 WITH(NOLOCK) ON cs.custid = cs2.custid 
												AND cs2.GameTypeID = t.GameTypeID
	WHERE cs.custid IN (SELECT custid FROM @tmp)
		AND cs.GameTypeID = 15
		AND cs2.custid IS NULL
	
	DELETE @tmp
	
	WAITFOR DELAY '0:0:0.1'
END	   

DROP TABLE #tblCust		