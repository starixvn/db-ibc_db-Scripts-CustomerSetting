/*
	Created: Winnie
	Task: Copy CardClub Setting for newly created customers. [RedmineID:#115322]
	DB: DBCUST/CustDB
	Date: 20190621
*/ 

DECLARE @MaxCustID INT,@Sporttype INT = 165,@Bettype INT =1901	
	
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
	AND ci.currency <> 20

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


	----------------------------------------Betlimit Setting-------------------------------------------------		
--Agent Level
INSERT INTO dbo.CustStakeLevel_Agent  ([CustID]
										,[SportType]
										,[BetType]
										,[StakeLevelList]) 
SELECT t.custid,@Sporttype, @Bettype, CAST(StakeLevelID AS varchar(50))
FROM StakeLevel WITH(NOLOCK) 
CROSS JOIN  #SMATemp t
WHERE GameGroupID=9 AND GameTypeID=1901 AND ExchangeId=t.Currency
--Member Level
INSERT INTO dbo.CustStakeLevel_Member([CustID]
									,[SportType]
									,[BetType]
									,[StakeLevelList]
									,LastUpdated) 
SELECT t.custid,@Sporttype, @Bettype, CAST(StakeLevelID AS varchar(50)),GETDATE()
FROM StakeLevel WITH(NOLOCK) 
CROSS JOIN  #MemberTemp t
WHERE GameGroupID=9 AND GameTypeID=1901 AND ExchangeId=t.Currency

DROP TABLE #SMATemp
DROP TABLE #MemberTemp
