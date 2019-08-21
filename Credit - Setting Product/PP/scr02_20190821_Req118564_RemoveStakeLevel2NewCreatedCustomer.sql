/*
	Created: Winnie
	Task: Remove stake level for newly created customers. [RedmineID:#118564]
	DB: DBCUST/CustDB
	Date: 20190821
*/ 

DECLARE @MaxCustID INT
	
SELECT @MaxCustID = xxx
	
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

CREATE TABLE #MemberTemp
(
	CustID INT PRIMARY KEY CLUSTERED,
	Currency INT
)

CREATE TABLE #SMATemp
(
	CustID INT PRIMARY KEY CLUSTERED,
	Currency INT
)

		
INSERT INTO #MemberTemp (CustID,Currency)
SELECT custid,currency
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN(SELECT CustID FROM #supers) AND roleid = 1  AND Enabled = 1 AND custid > @maxcustid	

	
INSERT INTO #SMATemp (CustID,Currency)
SELECT custid,currency
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN(SELECT CustID FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @maxcustid 


CREATE TABLE #MemberTempSL
(
	CustID			INT,
	SportType		INT,
	BetType			INT,
	StakeLevelList	VARCHAR(50),
	PRIMARY KEY(CustID,Sporttype,Bettype)
)

CREATE TABLE #SMATempSL
(
	CustID			INT,
	SportType		INT,
	BetType			INT,
	StakeLevelList	VARCHAR(50),
	PRIMARY KEY(CustID,Sporttype,Bettype)
)

INSERT INTO #MemberTempSL (CustID,SportType,BetType,StakeLevelList)
SELECT c.custid,a.SportType,a.BetType,CAST(MIN(s1.StakeLevelID) AS VARCHAR(50))	
FROM stakelevel s WITH(NOLOCK) 
INNER JOIN #tmpLevel2 t ON s.GameTypeID=t.GameTypeID AND s.GameGroupID=t.GameGroupID 
INNER JOIN CustStakeLevel_Member a WITH(NOLOCK) ON t.GametypeID=a.Bettype
INNER JOIN #MemberTemp c WITH(NOLOCK) ON a.custid=c.CustiD AND s.ExchangeId=c.currency
INNER JOIN #tmpLevel1 t1 ON a.Bettype=t1.GameTypeID
INNER JOIN stakelevel s1 ON s1.GameTypeID=t1.GameTypeID AND s1.GameGroupID=t1.GameGroupID AND s1.ExchangeId=c.currency 
WHERE StakeLevelList = CAST(s.StakelevelID AS VARCHAR(50))
GROUP BY c.custid,a.SportType,a.BetType

INSERT INTO #SMATempSL (CustID,SportType,BetType,StakeLevelList)
SELECT c.custid,a.SportType,a.BetType,CAST(MIN(s1.StakeLevelID) AS VARCHAR(50))	
FROM stakelevel s WITH(NOLOCK) 
INNER JOIN #tmpLevel2 t ON s.GameTypeID=t.GameTypeID AND s.GameGroupID=t.GameGroupID 	
INNER JOIN CustStakeLevel_Agent a WITH(NOLOCK) ON t.GametypeID=a.Bettype
INNER JOIN #SMATemp c WITH(NOLOCK) ON a.custid=c.CustiD  AND s.ExchangeId=c.currency	
INNER JOIN #tmpLevel1 t1 ON a.Bettype=t1.GameTypeID
INNER JOIN stakelevel s1 ON s1.GameTypeID=t1.GameTypeID AND s1.GameGroupID=t1.GameGroupID AND s1.ExchangeId=c.currency
WHERE  StakeLevelList like '%'+ CAST(s.StakelevelID AS VARCHAR(50))+'%'
GROUP BY c.custid,a.SportType,a.BetType
	----------------------------------------Betlimit Setting-------------------------------------------------		
--Member Level
UPDATE a
		SET a.StakeLevelList=t.StakeLevelList
		FROM #MemberTempSL t
		INNER JOIN CustStakeLevel_Member a WITH(ROWLOCK,UPDLOCK) ON t.CustID=a.CustID AND t.SportType=a.SportType AND t.BetType=a.BetType		

--Agent Level
UPDATE a
		SET a.StakeLevelList=t.StakeLevelList
	FROM #SMATempSL t
		INNER JOIN CustStakeLevel_Agent a WITH(ROWLOCK,UPDLOCK) ON t.CustID=a.CustID AND t.SportType=a.SportType AND t.BetType=a.BetType		

DROP TABLE #SMATemp
DROP TABLE #MemberTemp
DROP TABLE #supers
DROP TABLE #MemberTempSL
DROP TABLE #SMATempSL
DROP TABLE #tmpLevel1
DROP TABLE #tmpLevel2