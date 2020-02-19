/*
	Created: 20200218@Tiara
	Date: 20200218
	Task: Copy SA Bet Setting for newly created customers [Redmine: #128128]
	DB: DBCUST/CustDB
*/ 

DECLARE @MaxCustID INT,@Sporttype INT = 244
	
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

CREATE TABLE #tmpbettype (BettypeID INT PRIMARY KEY)

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

INSERT INTO #tmpbettype(BettypeID)
SELECT 3001 UNION ALL
SELECT 3002 UNION ALL
SELECT 3003 UNION ALL
SELECT 3004 UNION ALL
SELECT 3005 UNION ALL
SELECT 3006 UNION ALL
SELECT 3007
		
INSERT INTO #MemberTemp (CustID,Currency)
SELECT custid,currency
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN(SELECT CustID FROM #supers) AND roleid = 1  AND Enabled = 1 AND custid > @maxcustid	

INSERT INTO #SMATemp (CustID,Currency)
SELECT custid,currency
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN(SELECT CustID FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @maxcustid 


	----------------------------------------Betlimit Setting-------------------------------------------------		
--Agent Level
INSERT INTO dbo.CustStakeLevel_Agent  ([CustID]
										,[SportType]
										,[BetType]
										,[StakeLevelList]) 
SELECT t.custid,@Sporttype, TB.BettypeID, CAST(StakeLevelID AS varchar(50))
FROM StakeLevel S WITH(NOLOCK) INNER JOIN #tmpbettype TB WITH (NOLOCK) ON S.GameTypeID = TB.BettypeID
CROSS JOIN  #SMATemp t
WHERE ExchangeId=t.Currency
--Member Level
INSERT INTO dbo.CustStakeLevel_Member([CustID]
									,[SportType]
									,[BetType]
									,[StakeLevelList]
									,LastUpdated) 
SELECT t.custid,@Sporttype, TB.BettypeID, CAST(StakeLevelID AS varchar(50)),GETDATE()
FROM StakeLevel S WITH(NOLOCK) INNER JOIN #tmpbettype TB WITH (NOLOCK) ON S.GameTypeID = TB.BettypeID 
CROSS JOIN  #MemberTemp t
WHERE ExchangeId=t.Currency

DROP TABLE #SMATemp
DROP TABLE #MemberTemp
DROP TABLE #tmpbettype
