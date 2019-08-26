/*
	Created: Winnie
	Task: Check if existed members were be updated to level 2 during time we running scripts. [RedmineID:#118564]
	DB: DBCUST/CustDB
	Date: 20190821
*/ 

CREATE TABLE #supers (custid INT PRIMARY KEY)

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
	AND ci.Site<>'CN88'
UNION
SELECT 179457

CREATE TABLE #tmpLevel2(GameTypeID INT,GameGroupID INT)	
INSERT INTO #tmpLevel2(GameTypeID ,GameGroupID )
SELECT 4001,2
UNION ALL
SELECT 4101,7

CREATE TABLE #tmpLevel1(GameTypeID INT,GameGroupID INT)	
INSERT INTO #tmpLevel1(GameTypeID ,GameGroupID )
SELECT 4001,1
UNION ALL
SELECT 4101,6


CREATE TABLE #MemberTempSL
(
	CustID			INT,
	SportType		INT,
	BetType			INT,
	StakeLevelList	VARCHAR(50)	
)

CREATE TABLE #SMATempSL
(
	CustID			INT,
	SportType		INT,
	BetType			INT,
	StakeLevelList	VARCHAR(50)
)

INSERT INTO #MemberTempSL (CustID,SportType,BetType,StakeLevelList)
SELECT c.custid,a.SportType,a.BetType,CAST(s1.StakeLevelID AS VARCHAR(50))	
FROM Temp_stakelevel s WITH(NOLOCK) 
INNER JOIN #tmpLevel2 t ON s.GameTypeID=t.GameTypeID AND s.GameGroupID=t.GameGroupID 
INNER JOIN CustStakeLevel_Member a WITH(NOLOCK) ON t.GametypeID=a.Bettype
INNER JOIN custInfo c WITH(NOLOCK) ON a.custid=c.CustiD AND s.ExchangeId=c.currency
INNER JOIN #tmpLevel1 t1 ON a.Bettype=t1.GameTypeID
INNER JOIN Temp_stakelevel s1 ON s1.GameTypeID=t1.GameTypeID AND s1.GameGroupID=t1.GameGroupID AND s1.ExchangeId=c.currency 
WHERE StakeLevelList = CAST(s.StakelevelID AS VARCHAR(50))
AND srecommend IN(SELECT CustiD FROM #supers)

INSERT INTO #SMATempSL (CustID,SportType,BetType,StakeLevelList)
SELECT c.custid,a.SportType,a.BetType,CAST(s1.StakeLevelID AS VARCHAR(50))	
FROM Temp_stakelevel s WITH(NOLOCK) 
INNER JOIN #tmpLevel2 t ON s.GameTypeID=t.GameTypeID AND s.GameGroupID=t.GameGroupID 	
INNER JOIN CustStakeLevel_Agent a WITH(NOLOCK) ON t.GametypeID=a.Bettype
INNER JOIN custInfo c WITH(NOLOCK) ON a.custid=c.CustiD  AND s.ExchangeId=c.currency	
INNER JOIN #tmpLevel1 t1 ON a.Bettype=t1.GameTypeID
INNER JOIN Temp_stakelevel s1 ON s1.GameTypeID=t1.GameTypeID AND s1.GameGroupID=t1.GameGroupID AND s1.ExchangeId=c.currency
WHERE  StakeLevelList like '%'+ CAST(s.StakelevelID AS VARCHAR(50))+'%'
AND srecommend IN(SELECT CustiD FROM #supers)
SELECT * FROM #MemberTempSL
SELECT * FROM #SMATempSL
	----------------------------------------Betlimit Setting-------------------------------------------------		
----Member Level
--UPDATE a
--		SET a.StakeLevelList=t.StakeLevelList
--		FROM #MemberTempSL t
--		INNER JOIN CustStakeLevel_Member a WITH(ROWLOCK,UPDLOCK) ON t.CustID=a.CustID AND t.SportType=a.SportType AND t.BetType=a.BetType		

----Agent Level
--UPDATE a
--		SET a.StakeLevelList=t.StakeLevelList
--	FROM #SMATempSL t
--		INNER JOIN CustStakeLevel_Agent a WITH(ROWLOCK,UPDLOCK) ON t.CustID=a.CustID AND t.SportType=a.SportType AND t.BetType=a.BetType		

DROP TABLE #supers
DROP TABLE #MemberTempSL
DROP TABLE #SMATempSL
DROP TABLE #tmpLevel1
DROP TABLE #tmpLevel2