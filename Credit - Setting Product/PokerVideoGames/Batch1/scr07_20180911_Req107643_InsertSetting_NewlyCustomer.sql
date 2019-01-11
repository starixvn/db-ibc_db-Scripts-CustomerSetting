/*
	Created: Winnie
	Task: Copy Setting for newly created customer
	DB: DBCUST/CustDB
	Date: 20190110
*/ 
PRINT N'Step 7: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

DECLARE @MaxCustID INT,@Sporttype INT = 165,@Bettype INT =1901	
DECLARE @BitOrder INT,@BitOrder1402 INT
SELECT @BitOrder= bitmapOrder from ProductStatusProfile WITH(NOLOCK) where SportType=@Sporttype
SELECT @BitOrder1402= bitmapOrder from ProductStatusProfile WITH(NOLOCK) where SportType=163 AND Bettype=1402
	
SELECT @MaxCustID = xxx
	
CREATE TABLE #supers (custid INT)

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
	AND ci.site IN ('789y')
	AND ci.currency <> 20
	AND ci.custid NOT IN (16) -- dummy account
	AND ci.currency IN (16,64)

DECLARE @ProductID INT = 33

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

CREATE TABLE #tempMember (CustID INT PRIMARY KEY,DisableVideoGame BIT DEFAULT(1))
CREATE TABLE #tempSMA (CustID INT PRIMARY KEY,DisableVideoGame BIT DEFAULT(1))

INSERT INTO #tempMember(CustID,DisableVideoGame)
SELECT ci.custid,dbo.f_GetProductStatus(s.bitmapIsDisabled,@BitOrder1402)
FROM #MemberTemp CI WITH (NOLOCK) 
	INNER JOIN CustProductStatus s WITH(NOLOCK) ON ci.custid=s.CustID


INSERT INTO #tempSMA(CustID,DisableVideoGame)
SELECT ci.custid,dbo.f_GetProductStatus(s.bitmapIsDisabled,@BitOrder1402)
FROM #SMATemp CI WITH (NOLOCK) 
	INNER JOIN CustProductStatus s WITH(NOLOCK) ON ci.custid=s.CustID

UPDATE cs
	SET								
			bitmapIsHidden =  dbo.f_GenerateProductStatus (cs.bitmapIsHidden,@BitOrder,0),
			bitmapIsDisabled = dbo.f_GenerateProductStatus (cs.bitmapIsDisabled,@BitOrder,DisableVideoGame)
	FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #tempMember CI WITH (NOLOCK) ON cs.CustID = ci.CustID

UPDATE cs
	SET								
			bitmapIsHidden =  dbo.f_GenerateProductStatus (cs.bitmapIsHidden,@BitOrder,0),
			bitmapIsDisabled = dbo.f_GenerateProductStatus (cs.bitmapIsDisabled,@BitOrder,DisableVideoGame)
	FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #tempSMA CI WITH (NOLOCK) ON cs.CustID = ci.CustID


DROP TABLE #SMATemp
DROP TABLE #MemberTemp