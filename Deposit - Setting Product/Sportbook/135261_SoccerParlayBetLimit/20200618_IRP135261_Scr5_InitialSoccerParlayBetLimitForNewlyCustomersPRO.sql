/*
	Created: 20200618@Johnson
	Task: copy bet limit from soccer hdp for soccer parlay for newly customers
	DB: DBCUST/CustDB
*/

DECLARE @max_custid INT, @srecommend INT
SELECT  @max_custid= xxx ---input maxcustid
	
CREATE TABLE #Supers (custid INT, isFinished BIT DEFAULT(0))

INSERT INTO #supers(custid)
SELECT s.custid
FROM Dep_CustSuper s WITH(NOLOCK)

CREATE TABLE #tblCust (custid INT PRIMARY KEY, mrecommend INT)
DECLARE @tmpCust TABLE(Custid INT PRIMARY KEY)
	
INSERT INTO #tblCust (custid,mrecommend)			
SELECT custid,mrecommend
FROM dbo.Customer WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM #Supers)
	AND custid > @max_custid

DELETE #tblCust 
WHERE mrecommend IN (SELECT custid 
					FROM dbo.custinfo WITH(NOLOCK)
					WHERE srecommend IN (SELECT custid FROM #Supers)
					AND(username like '%Acc%'  OR username like '%AFF%' OR username like '%LocalBank%')
					AND roleid=3)

DECLARE @rowcount INT 

WHILE(1=1)
BEGIN		
	DELETE TOP (5000) t
	OUTPUT DELETED.custid INTO @tmpCust
	FROM #tblCust t
	
	SELECT @rowcount = @@rowcount
	
	UPDATE cs
	SET cs.MinBet = cs2.MinBet,
		cs.MaxBet = cs2.MaxBet
	FROM Dep_CustSetting cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN Dep_CustSetting cs2 WITH(NOLOCK) ON cs.custid = cs2.custid 
														AND cs.sporttype = 1 AND cs.bettype = 9 AND cs.islive = 0
														AND cs2.sporttype = 1 AND cs2.bettype = 1 AND cs2.islive = 0
	WHERE cs.custid IN (SELECT custid FROM @tmpCust)													
	
	UPDATE ci
	SET maxpermatch1mp = maxpermatch
	FROM CustInfo ci WITH(UPDLOCK,ROWLOCK)			
	WHERE custid IN (SELECT custid FROM @tmpCust)	
	
	IF @rowcount < 5000 
		BREAK;
	
	DELETE @tmpCust
	
	WAITFOR DELAY '0:0:0.01'
END	