/*
	Created: Elodie
	Date: 20200323
	Task: Create stake level for Virtual games Athena Site and API Site (N88, N8B, N8G)( New accounts)
	DB: DBCust/CustDB
*/

	DECLARE @max_custid INT = xxx

	DECLARE @VGSportBettype TABLE (SportType SMALLINT, BetType SMALLINT)
	INSERT INTO @VGSportBettype(SportType, BetType) VALUES (245, 4601)

	--DELETE existing data
	-------------------------------------------------STAKE LEVEL----------------------------------------------------------------
	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustStakeLevel_Agent
	FROM Dep_CustStakeLevel_Agent a WITH(NOLOCK)
	INNER JOIN @VGSportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid AND ci.currency <> 20
	WHERE a.CustID >@max_custid

	DELETE a
	FROM Dep_CustStakeLevel_Agent a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #Dep_CustStakeLevel_Agent t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustStakeLevel_Member
	FROM Dep_CustStakeLevel_Member a WITH(NOLOCK)
	INNER JOIN @VGSportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid AND ci.currency <> 20
	WHERE a.CustID >@max_custid

	DELETE a
	FROM Dep_CustStakeLevel_Member a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #Dep_CustStakeLevel_Member t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 
	
	DROP TABLE #Dep_CustStakeLevel_Agent
	DROP TABLE #Dep_CustStakeLevel_Member

	---------------------CREATE setting for NEW ACCs-----------------------------------

	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED
	   ,Currency INT
	   ,mrecommend INT
	   ,SiteId INT
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED
	   ,Currency INT
	   ,RoleID TINYINT
	   ,mrecommend INT
	   ,SiteId INT
	)

	--> Athena Licensee
	CREATE TABLE #supers (custid int)

	INSERT INTO #supers(custid)
	SELECT c.custid
	FROM customer c WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
		INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
	WHERE c.roleid = 4  
	 AND s.islicensee = 1
	 AND ci.Enabled = 1
	 AND c.currency NOT IN (20,72,27,28,17,21,31,36,37,40,44,46,50,62,63,65,68,73)
	 AND s.site IN (
				'spondemo'
				,'Macaubet'
				,'Aoncash'
				,'ITCBet'
				,'Athena000'
				,'9bet'
				,'M8bola'
				,'Q8bola'
				,'BE7'
				,'NBCbet'
				,'Unobet'
				,'Bolanation'
				,'Luckywin88'
				,'Winn69'
				,'Axiawin'
				,'Jumbo88'
				,'Lagadewa'
				,'Ratugg'
				,'Monstergol'
				)

	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid=3 AND username LIKE '%Acc%'
	
	INSERT INTO #SMATemp(CustID,RoleID,Currency,mrecommend,SiteId)
	SELECT ci.custid, ci.roleid, ci.currency, ci.mrecommend,s.SiteId
	FROM Custinfo ci WITH (NOLOCK)
		INNER JOIN customer c WITH (NOLOCK) ON c.custid = ci.custid
		INNER JOIN dbo.Site s WITH (NOLOCK) ON c.site = s.site
	WHERE ci.srecommend IN (SELECT custid FROM #supers) AND ci.roleid IN (2,3,4) AND Enabled = 1 AND ci.custid > @max_custid 
	AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO #MemberTemp(CustID,Currency,mrecommend,SiteId)
	SELECT ci.custid, ci.currency, ci.mrecommend,s.SiteId
	FROM Custinfo ci WITH (NOLOCK)
		INNER JOIN customer c WITH (NOLOCK) ON c.custid = ci.recommend
		INNER JOIN dbo.Site s WITH (NOLOCK) ON c.site = s.site
	WHERE ci.srecommend IN (SELECT custid FROM #supers) AND ci.roleid = 1  AND Enabled = 1 AND ci.custid > @max_custid	
	AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)

	--> API Licensee
	CREATE TABLE #APIsupers (custid int)

	INSERT INTO #APIsupers(custid)
	SELECT c.custid
	FROM customer c WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
		INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
	WHERE c.roleid = 4  
	 AND s.islicensee = 1
	 AND ci.Enabled = 1
	 AND c.currency NOT IN (20,72,27,28,17,21,31,36,37,40,44,46,50,62,63,65,68,73)
	 AND s.site IN ('N88','N8B','N8G ')

	CREATE TABLE #APIDummy	(CustID INT PRIMARY KEY)
	INSERT INTO #APIDummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend IN (SELECT custid FROM #APIsupers) AND roleid=3 AND username LIKE '%Acc%'
	
	INSERT INTO #SMATemp(CustID,RoleID,Currency,mrecommend,SiteId)
	SELECT ci.custid, ci.roleid, ci.currency, ci.mrecommend,s.SiteId
	FROM Custinfo ci WITH (NOLOCK)
		INNER JOIN customer c WITH (NOLOCK) ON c.custid = ci.custid
		INNER JOIN dbo.Site s WITH (NOLOCK) ON c.site = s.site
	WHERE ci.srecommend IN (SELECT custid FROM #APIsupers) AND ci.roleid IN (2,3,4) AND Enabled = 1 AND ci.custid > @max_custid 
	AND ci.mrecommend NOT IN (SELECT custid FROM #APIDummy)

	INSERT INTO #MemberTemp(CustID,Currency,mrecommend,SiteId)
	SELECT ci.custid, ci.currency, ci.mrecommend,s.SiteId
	FROM Custinfo ci WITH (NOLOCK)
		INNER JOIN customer c WITH (NOLOCK) ON c.custid = ci.recommend
		INNER JOIN dbo.Site s WITH (NOLOCK) ON c.site = s.site
	WHERE  ci.srecommend IN (SELECT custid FROM #APIsupers) AND  ci.roleid = 1  AND Enabled = 1 AND  ci.custid > @max_custid	
	AND  ci.mrecommend NOT IN (SELECT custid FROM #APIDummy)

	DECLARE @SportBettype TABLE
	(
		SportType SMALLINT, 
		BetType   SMALLINT
	)
	INSERT INTO @SportBettype(SportType, BetType) VALUES (245, 4601)

	-------------------------------------------------STAKE LEVEL----------------------------------------------------------------
	--> Bet Limit: Apply bet limit group level for all S/M/A/Member levels
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