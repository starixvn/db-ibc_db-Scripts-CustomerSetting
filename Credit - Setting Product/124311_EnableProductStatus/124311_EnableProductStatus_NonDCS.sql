/*
	Created: Tiara	
	Task: Enable Product Status for all disabled customers under 789y Headline- Non DCS Products
	DB: DBCUST/CustDB
	Date: 20191223
*/ 

DECLARE @max_custid INT
SELECT @max_custid = xx

--Super accounts under 789y Headline
CREATE TABLE #supers (custid int)

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
			AND ci.username NOT LIKE '3rdSuper%'
			AND ci.site IN ('789y')
			AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
			AND s.islicensee = 0
			AND ci.currency <> 20	
			
--Enable Number Game, Happy5
SELECT DISTINCT CI.custid, CI.DisableNumber
INTO #tmpSetting_NG
FROM custInfo ci WITH (NOLOCK)
	INNER JOIN #supers S WITH (NOLOCK) ON S.custid = CI.srecommend
	INNER JOIN CustSetting3rd CS WITH (NOLOCK) ON CS.custid = CI.custid
WHERE CI.Enabled = 1
	AND CI.DisableNumber = 1
	AND CS.sporttype IN (161,164)
	AND CI.custid <= @max_custid
	
UPDATE CI
SET CI.DisableNumber = 0
FROM custInfo ci WITH (UPDLOCK,ROWLOCK)
	INNER JOIN #tmpSetting_NG T ON T.custid = CI.custid
 
--Enable RNG Casino
SELECT DISTINCT CI.custid, CI.DisableCasino
INTO #tmpSetting_RC
FROM custInfo ci WITH (NOLOCK)
	INNER JOIN #supers S WITH (NOLOCK) ON S.custid = CI.srecommend
WHERE CI.Enabled = 1
	AND CI.DisableCasino = 1
	AND CI.custid <= @max_custid
	
UPDATE CI
SET CI.DisableCasino = 0
FROM custInfo ci WITH (UPDLOCK,ROWLOCK)
	INNER JOIN #tmpSetting_RC T ON T.custid = CI.custid
	
--Enable RNG Keno
SELECT DISTINCT CI.custid
INTO #tmpSetting_RK
FROM custInfo CI WITH (NOLOCK)
	INNER JOIN CustGameType CT WITH (NOLOCK) ON CT.CustID = CI.custid
	INNER JOIN #supers S ON S.custid = CI.srecommend
WHERE CI.Enabled = 1
	AND CT.GameTypeID NOT IN (2,7,9,1701,1702)
	AND CT.IsDisabled = 1
	AND CI.custid <= @max_custid
	
UPDATE CT
SET CT.IsDisabled = 0
FROM CustGameType CT WITH (UPDLOCK,ROWLOCK)
	INNER JOIN #tmpSetting_RK T ON T.custid = CT.custid	

--Enable Gold Deluxe
SELECT DISTINCT CI.custid
INTO #tmpSetting_GD
FROM custInfo CI WITH (NOLOCK)
	INNER JOIN CustGameType CT WITH (NOLOCK) ON CT.CustID = CI.custid
	INNER JOIN #supers S ON S.custid = CI.srecommend
WHERE CI.Enabled = 1
	AND CI.DisableGoldDeluxe = 1
	AND CT.GameTypeID  IN (1701,1702)
	AND CI.custid <= @max_custid
		
UPDATE CI
SET CI.DisableGoldDeluxe = 0
FROM custInfo CI WITH (UPDLOCK,ROWLOCK)
	INNER JOIN #tmpSetting_GD T ON T.custid = CI.custid
	
--Drop all temp tables
DROP TABLE #supers
DROP TABLE #tmpSetting_NG
DROP TABLE #tmpSetting_RK
DROP TABLE #tmpSetting_RC
DROP TABLE #tmpSetting_GD