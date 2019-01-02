/*
	Created: Johnson
	Date: 2019-01-02
	Task: reinitial bet setting for Happy 5 for newly customers
	DB: DBCUST/CUSTDB
*/
DECLARE @max_custid INT, @max_custid2 INT, @currency INT, @site VARCHAR(50)
SELECT @max_custid = xx,--old maxcustid
	@max_custid2 =yy --new maxcustid

SELECT  @max_custid= xxx, ---input maxcustid
		@site = 'abc',
		@currency = xxx
		
CREATE TABLE #supers (custid INT)
CREATE TABLE #tblCust (custid INT PRIMARY KEY)

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4 
	AND ci.currency <> 20
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND s.site = @site
	AND ci.currency = @currency
	AND ci.custid <= @max_custid
	
	
INSERT INTO #tblCust(custid)
SELECT custid
FROM dbo.CustInfo WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM #Supers)
	AND custid > @max_custid	

UPDATE cs
SET MinBet = cs1.MinBet,
	MaxBet = cs1.MaxBet
FROM dbo.CustSetting3rd cs WITH(UPDLOCK,ROWLOCK)
	INNER JOIN dbo.CustSetting3rd cs1 WITH(NOLOCK) ON cs1.custID = cs.custID 
													AND cs1.sporttype = 161
													AND cs1.bettype = 81
WHERE cs.custid IN (SELECT custid FROM #tblCust)
	AND cs.sporttype = 164 
	AND cs.bettype = 8101

UPDATE ci
SET maxpermatch164 = maxpermatch161
FROM dbo.CustInfo ci WITH(UPDLOCK,ROWLOCK)
WHERE custid IN (SELECT custid FROM #tblCust)

	