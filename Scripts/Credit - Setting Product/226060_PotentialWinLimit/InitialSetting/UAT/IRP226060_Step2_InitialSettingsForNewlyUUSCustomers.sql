/*<info serverAlias="DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250515@Johnson	
	Task: Initial Potential Winning Limit/Threshold for customers [redmine:#226060]
	DB: DBCUST-CustDB
*/
CREATE TABLE #supers (custid int,isfinished bit default(0))
CREATE TABLE #MemberTemp(CustID INT PRIMARY KEY CLUSTERED)
CREATE TABLE #tmpCust (CustID INT PRIMARY KEY CLUSTERED)

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = 237239799

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
	AND ci.currency = 20

INSERT INTO #MemberTemp (CustID)
SELECT custid
FROM Custinfo ci WITH (NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers)
	AND roleid = 1  
	AND Enabled = 1 
	AND custid > @max_custid
	AND NOT EXISTS(SELECT 1 FROM CustPotentialWinLimit cs WITH(NOLOCK) WHERE cs.custid = ci.custid)
	
WHILE(1=1)
BEGIN
	DELETE TOP (1000) t
	OUTPUT DELETED.CustID INTO #tmpCust(custid)
	FROM #MemberTemp t

	IF @@ROWCOUNT = 0
		BREAK;	

	INSERT INTO [dbo].[CustPotentialWinLimit]
		([CustID]
		,[Sporttype]
		,[Bettype]
		,[PotentialWinLimit]
		,[IsAutoReset]
		,[RepUpdateTime])
	SELECT custid, 0, 0, 0, 1, dbo.f_GetDateTime2()
	FROM #tmpCust t

	DELETE #tmpCust

	WAITFOR DELAY '00:00:0.200'
END

DROP TABLE #supers
DROP TABLE #MemberTemp
DROP TABLE #tmpCust
GO
