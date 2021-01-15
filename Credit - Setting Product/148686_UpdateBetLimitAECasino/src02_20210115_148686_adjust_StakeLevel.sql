/*
	Created: Winfred
	Date: 20210114
	Task: change and insert Stake level for AE Casino [Redmine: 148686]
	DB: DBCUST/CustDB
*/

	CREATE TABLE #StakeTemp(StakeLevelID INT,ExchangeId INT	)
	INSERT INTO #StakeTemp(StakeLevelID ,ExchangeId )
	SELECT StakeLevelID,ExchangeId
	FROM StakeLevel WITH(NOLOCK)
	WHERE GameTypeID = 3101 AND ExchangeId in (2,5,67,13,66,81)  AND MinStake = 100 AND MaxStake = 10000 AND MinLabel = '100' AND MaxLabel = '10,000'
	
	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		roleid TINYINT,
		currency INT
	)
	CREATE TABLE #DirectMasterAgent (CustID INT PRIMARY KEY , srecommend INT , mrecommend INT , recommend INT ,roleid TINYINT,currency INT)
	--- get direct master / Agent
	INSERT INTO #DirectMasterAgent (CustID, srecommend,mrecommend,recommend ,roleid,currency)
	SELECT ci.custid, ci.srecommend,ci.mrecommend,ci.recommend, ci.roleid,c.currency
	FROM Customer ci with(nolock)
	INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
	INNER JOIN CustStakeLevel_Agent csa WITH(NOLOCK) on ci.custid = csa.CustID  AND csa.BetType = 3101 AND SportType = 243
	WHERE  EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		AND ci.roleid IN (2, 3) 
		AND  ci.currency in (2,5,67,13,66,81)
		AND c.Enabled=1
	
	-- get Supper
	INSERT INTO #SMATemp(CustID,roleid,currency)
	SELECT ci.custid,roleid,currency
	FROM dbo.customer ci WITH (NOLOCK)
		INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
		INNER JOIN CustStakeLevel_Agent csa WITH(NOLOCK) on ci.custid = csa.CustID  AND csa.BetType = 3101 AND SportType = 243
		LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.Site NOT IN ('CN88')
	AND ci.currency in (2,5,67,13,66,81)
	UNION 
	-- Super Direct
	SELECT DISTINCT ci.srecommend,4 as roleid,ci.currency
	FROM #DirectMasterAgent ci WITH (NOLOCK)
		
	-- get direct master 
	INSERT INTO #SMATemp(CustID,roleid,currency)
	SELECT DISTINCT ci.CustID,ci.roleid,ci.currency
	FROM #DirectMasterAgent ci WITH (NOLOCK)
	WHERE roleid  = 3
	UNION 
	SELECT DISTINCT ci.mrecommend,3 as roleid,ci.currency
	FROM #DirectMasterAgent ci WITH (NOLOCK)
	WHERE roleid  = 2
	
	-- get direct Agent 
	INSERT INTO #SMATemp(CustID,roleid,currency)
	SELECT DISTINCT ci.CustID,ci.roleid,ci.currency
	FROM #DirectMasterAgent ci WITH (NOLOCK)
	WHERE roleid  = 2
		 
	UPDATE a
	SET a.StakeLevelList = a.StakeLevelList +  CASE WHEN RIGHT(a.StakeLevelList,1) = ','  OR a.StakeLevelList = '' 
								THEN CAST(s.StakeLevelID AS VARCHAR(10))
								ELSE ',' + CAST(s.StakeLevelID AS VARCHAR(10)) END 
	FROM #SMATemp t
	INNER JOIN CustStakeLevel_Agent a WITH(ROWLOCK,UPDLOCK) ON t.CustID=a.CustID AND a.SportType=243 AND a.BetType=3101		
	INNER JOIN #StakeTemp s on t.currency = s.ExchangeId
	
	
	DROP TABLE #DirectMasterAgent
	DROP TABLE #SMATemp
	DROP TABLE #StakeTemp
		

