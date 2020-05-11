/*
	Created: Eden
	Date: 20200507
	Task: Create setting for Virtual game follow by Macau games ( New accounts)
	DB: DBCust/CustDB
*/

	DECLARE @max_custid INT = xxx

	DECLARE @sporttype INT = 245 , @Bettype INT = 4602

	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED
	   ,Currency INT
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED
	   ,Currency INT
	)

	CREATE TABLE #supers (custid int)

	INSERT INTO #supers(custid)
	SELECT c.custid
	FROM customer c WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
		INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
		INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid 
	WHERE c.roleid = 4  
	 AND s.islicensee = 0
	 AND cs.isinternal = 0
	 AND ci.username NOT LIKE '3rdSuper%'
	 AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	 AND ci.Enabled = 1
	 AND c.currency IN ( 	2	--RM
					, 	71	--KHR
					, 	56	--PLN
					, 	67	--HKK
					, 	16	--Yen
					, 	64	--UT
					, 	35	--$US
					, 	3	--US$
					, 	69	--MMK
					, 	70	--MKK
					, 	72	--YNG
					, 	13	--RMB
					, 	81	--CY
					, 	66	--YUN
					, 	5	--HK$
					, 	47	--DDD
					, 	22	--IND
					, 	34	--IDR
					, 	33	--IDD
					, 	15	--IN
					, 	43	--THB
					, 	4	--TB
					, 	45	--Won
					, 	51	--INH
					, 	61	--INR
					, 	55	--RUB
					, 	6	--EURO
					, 	12	--GBP
					, 	32	--JPY
					) --Offered Currencies
	 AND c.site <> 'CN88'

	--Delete existing Data
	DELETE cg
	FROM dbo.CustStakeLevel_Agent cg WITH(ROWLOCK)	
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid		
	WHERE SportType = @SportType AND BetType = @Bettype
		AND cg.custid > @max_custid

	DELETE cg
	FROM dbo.CustStakeLevel_Member cg WITH(ROWLOCK)
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid			
	WHERE SportType = @SportType AND BetType = @Bettype
		AND cg.custid > @max_custid
	
	INSERT INTO #SMATemp(CustID,Currency)
	SELECT custid, currency
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @max_custid 

	INSERT INTO #MemberTemp(CustID,Currency)
	SELECT custid, currency
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 1  AND Enabled = 1 AND custid > @max_custid	

	-------------------------------------------------STAKE LEVEL----------------------------------------------------------------
	--> Bet Limit: Apply bet limit group level for all S/M/A/Member levels
	INSERT INTO CustStakeLevel_Agent(CustID, SportType, BetType, StakeLevelList)
	SELECT tmp.CustID
		,SportType = @sporttype
		,BetType = @Bettype
		,StakeLevelList = SUBSTRING(( SELECT ',' + CONVERT(VARCHAR(5),s.StakeLevelID) 
										FROM StakeLevel s WITH(NOLOCK) 
										WHERE s.ExchangeId = tmp.Currency AND s.GameTypeID = @Bettype
										FOR XML PATH(''))
							,2,200)
	FROM #SMATemp tmp

	INSERT INTO CustStakeLevel_Member(CustID, SportType, BetType, StakeLevelList,LastUpdated)
	SELECT tmp.CustID
		,SportType = @sporttype
		,BetType = @Bettype
		,StakeLevelList = ( SELECT TOP 1 CONVERT(VARCHAR(5),s.StakeLevelID) 
							FROM StakeLevel s WITH(NOLOCK) 
							WHERE s.ExchangeId = tmp.Currency AND s.GameTypeID = @Bettype
							ORDER BY s.MaxStake
							)
		,GETDATE()
	FROM #MemberTemp tmp

	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp