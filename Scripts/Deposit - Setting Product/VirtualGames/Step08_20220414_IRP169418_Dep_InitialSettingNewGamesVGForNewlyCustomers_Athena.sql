/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Johnson
	Date: 20220414
	Task: Create setting for FGG Athena Site ( New accounts)
	DB: DBCust/CustDB
*/

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
WHERE c.roleid = 4  
	AND s.islicensee = 1
	AND ci.Enabled = 1	
	AND c.currency IN (SELECT ExchangeId FROM exchange WITH(NOLOCK)
						WHERE currency IN ('RM','KHR','PLN','USDT','US$','AUD','MMK','MKK','CHF','UUS','BND','YUN','RMB','DKK','NOK', 'SEK', 'IN', 'TB', 'Won','INH','Euro'
						,'INR','RUB','GBP','JPY'))
	AND s.site IN ('Athena000')


	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		Currency INT,
		SiteId INT
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED
		,roleid	TINYINT
		,Currency INT
		,SiteId INT
	)
	
	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend IN (SELECT custid FROM #Supers) 
		AND roleid=3 
		AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88' + 'CAS%')
		
	INSERT INTO #MemberTemp (CustID,currency,siteid)
	SELECT ci.custid, ci.currency,s.siteid
	FROM Custinfo ci WITH (NOLOCK)
		INNER JOIN customer c WITH (NOLOCK) ON c.custid = ci.recommend
		INNER JOIN dbo.Site s WITH (NOLOCK) ON c.site = s.site
	WHERE ci.srecommend IN (SELECT custid FROM #Supers) 
		AND ci.roleid = 1  AND Enabled = 1 AND ci.custid > @max_custid	
		AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO #SMATemp (CustID,roleid,currency,siteid)
	SELECT ci.custid,ci.roleid,ci.currency,s.siteid
	FROM Custinfo ci WITH (NOLOCK)
		INNER JOIN customer c WITH (NOLOCK) ON c.custid = ci.custid
		INNER JOIN dbo.Site s WITH (NOLOCK) ON c.site = s.site
	WHERE ci.srecommend IN (SELECT custid FROM #Supers) AND ci.roleid IN (2,3,4) AND Enabled = 1 AND ci.custid > @max_custid 
	AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)

	DECLARE @SportBetType TABLE
	(
		SportType SMALLINT, 
		BetType   SMALLINT
	)
	INSERT INTO @SportBetType(SportType, BetType) VALUES (245, 4605)
	
	-------------------------------------------------STAKE LEVEL----------------------------------------------------------------
	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustStakeLevel_Agent
	FROM Dep_CustStakeLevel_Agent a WITH(NOLOCK)
	INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.CustID = ci.custid

	DELETE a
	FROM Dep_CustStakeLevel_Agent a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #Dep_CustStakeLevel_Agent t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustStakeLevel_Member
	FROM Dep_CustStakeLevel_Member a WITH(NOLOCK)
	INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN #MemberTemp ci WITH(NOLOCK) ON a.CustID = ci.custid

	DELETE a
	FROM Dep_CustStakeLevel_Member a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #Dep_CustStakeLevel_Member t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

	-------------------------------------------------STAKE LEVEL----------------------------------------------------------------
	INSERT INTO DEP_CustStakeLevel_Agent(CustID, SportType, BetType, StakeLevelList)
	SELECT tmp.CustID
		,SportType = t.SportType
		,BetType = t.BetType
		,StakeLevelList = SUBSTRING(( SELECT ',' + CONVERT(VARCHAR(5),s.StakeLevelID) 
										FROM DEP_StakeLevel s WITH(NOLOCK) 
										WHERE s.ExchangeId = tmp.Currency AND s.GameTypeID = t.BetType AND s.SiteID = tmp.SiteId 
										FOR XML PATH(''))
							,2,200)
	FROM #SMATemp tmp
		CROSS APPLY @SportBetType t

	INSERT INTO DEP_CustStakeLevel_Member(CustID, SportType, BetType, StakeLevelList,LastUpdated)
	SELECT tmp.CustID
		,SportType = t.SportType
		,BetType = t.BetType
		,StakeLevelList = (	SELECT TOP 1 CONVERT(VARCHAR(5),s.StakeLevelID) 
							FROM DEP_StakeLevel s WITH(NOLOCK) 
							WHERE s.ExchangeId = tmp.Currency AND s.GameTypeID = t.BetType AND s.SiteID = tmp.SiteId 
							ORDER BY s.MaxStake)
		,GETDATE()
	FROM #MemberTemp tmp
		CROSS APPLY @SportBetType t

	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp	