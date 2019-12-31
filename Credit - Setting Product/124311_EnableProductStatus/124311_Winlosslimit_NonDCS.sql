/*
	Created: Tiara	
	Task: Set default Winloss limit for customers under 789y Headline- Non DCS Products- RedmineID: #124311
	DB: DBCUST/CustDB
	Date: 20191230
*/ 

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

		
--RNG Casino

SELECT DISTINCT CI.custid, CI.roleid, CW.SportType, CW.BetType
INTO #Customer_C
FROM custInfo CI WITH (NOLOCK)
	INNER JOIN #supers S on S.custid=CI.srecommend
	INNER JOIN CustWinLimit CW ON CW.CustId = CI.custid
	INNER JOIN DBCASINO.CasinoAdmin.dbo.Customer c WITH (NOLOCK) ON CI.custid = c.ibccustid
    INNER JOIN DBCASINO.CasinoAdmin.dbo.CustGameType CG WITH (NOLOCK) ON CG.custid = CI.custid
WHERE CI.enabled=1
	AND CW.MaxLossLimit = 0
	AND CW.MaxWinLimit = 0
	AND SportType = 208 
	AND BetType = 2101
	
--Update Super
UPDATE C
SET C.MaxWinLimit = X, C.MaxLossLimit = X
FROM CustWinLimit C WITH (UPDLOCK,ROWLOCK)
	INNER JOIN #Customer_C CC WITH (NOLOCK) ON CC.custid = C.CustId AND CC.SportType = C.SportType AND CC.BetType = C.BetType
WHERE CC.roleid = 4
	AND C.SportType = 208 
	AND C.BetType = 2101

--Update Master, Agent
UPDATE C
SET C.MaxWinLimit = X, C.MaxLossLimit = X
FROM CustWinLimit C WITH (UPDLOCK,ROWLOCK)
	INNER JOIN #Customer_C CC WITH (NOLOCK) ON CC.custid = C.CustId AND CC.SportType = C.SportType AND CC.BetType = C.BetType
WHERE CC.roleid in (2,3)
	AND C.SportType = 208 
	AND C.BetType = 2101

--Update Member
UPDATE C
SET C.MaxWinLimit = X, C.MaxLossLimit = X
FROM CustWinLimit C WITH (UPDLOCK,ROWLOCK)
	INNER JOIN #Customer_C CC WITH (NOLOCK) ON CC.custid = C.CustId AND CC.SportType = C.SportType AND CC.BetType = C.BetType
WHERE CC.roleid = 1
	AND C.SportType = 208 
	AND C.BetType = 2101

--Gold Deluxe
SELECT DISTINCT CI.custid, CI.roleid, C.SportType, C.BetType
INTO #Customer_GD
FROM custInfo CI WITH (NOLOCK)
	INNER JOIN #supers S on S.custid=CI.srecommend
	INNER JOIN CustGameType CS WITH (NOLOCK) ON CS.CustID = CI.custid
	INNER JOIN CustWinLimit C ON C.CustId = CI.custid 
WHERE CI.enabled=1
	AND CS.GameTypeID in (1701,1702)
	AND C.MaxLossLimit = 0
	AND C.MaxWinLimit = 0
	AND SportType = 255 
	AND BetType = 1701	
	
--Update Super
UPDATE C
SET C.MaxWinLimit = X, C.MaxLossLimit = X
FROM CustWinLimit C WITH (UPDLOCK,ROWLOCK)
	INNER JOIN #Customer_GD CC WITH (NOLOCK) ON CC.custid = C.CustId AND CC.SportType = C.SportType AND CC.BetType = C.BetType
WHERE CC.roleid = 4
	AND  C.SportType = 255 
	AND C.BetType = 1701	


--Update Master, Agent
UPDATE C
SET C.MaxWinLimit = X, C.MaxLossLimit = X
FROM CustWinLimit C WITH (UPDLOCK,ROWLOCK)
	INNER JOIN #Customer_GD CC WITH (NOLOCK) ON CC.custid = C.CustId AND CC.SportType = C.SportType AND CC.BetType = C.BetType
WHERE CC.roleid in (2,3)
	AND  C.SportType = 255 
	AND C.BetType = 1701	

--Update Member
UPDATE C
SET C.MaxWinLimit = X, C.MaxLossLimit = X
FROM CustWinLimit C WITH (UPDLOCK,ROWLOCK)
	INNER JOIN #Customer_GD CC WITH (NOLOCK) ON CC.custid = C.CustId AND CC.SportType = C.SportType AND CC.BetType = C.BetType
WHERE CC.roleid = 1
	AND  C.SportType = 255 
	AND C.BetType = 1701	

--Drop all temp tables
DROP TABLE #supers
DROP TABLE #Customer_C
DROP TABLE #Customer_GD
