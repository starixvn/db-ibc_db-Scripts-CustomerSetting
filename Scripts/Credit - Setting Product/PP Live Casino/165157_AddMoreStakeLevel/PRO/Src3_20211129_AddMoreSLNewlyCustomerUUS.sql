/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Winfred
	Date: 20210806
	Task: Add setting for newly created customer of Pragmatic Live Casino UUS [ RedmineID:#165157]
	DB: DBCUST/CustDB
	P/s : Step 3 Add setting for newly created customer SMA level UUS
*/ 

	PRINT N'Step 3: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
	DECLARE @Sporttype INT = 170, @Bettype INT  = 3701
	DECLARE @MaxCustID INT, @fSportType SMALLINT, @fBetType SMALLINT

	SELECT @MaxCustID = xxx

	CREATE TABLE #supers (custid int)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM customer ci WITH (NOLOCK) 
		INNER JOIN Custinfo c WITH (NOLOCK) ON c.custid = ci.custid
		INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
		LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.roleid = 4  
				AND ci.username NOT LIKE '3rdSuper%'
				AND cs.isinternal = 0
				AND c.Enabled = 1
				AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
				AND ci.Site<>'CN88'
				AND s.islicensee = 0
				AND ci.currency IN (72        --YNG
									,20       --UUS
						)

	CREATE TABLE #tmpSTListSMA (BettypeID INT, Currency INT, StakeLevelList VARCHAR(500))
	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		roleid TINYINT,
		currency INT
	)

	INSERT INTO #SMATemp (CustID, roleid, currency)
	SELECT custid, roleid, currency
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @maxcustid 

	INSERT INTO #tmpSTListSMA(BettypeID, StakelevelList,Currency)
	SELECT DISTINCT ST.GameTypeID, CAST (STUFF (STL, 1,1, '')AS VARCHAR(500)) as StakeLevelList,sma.currency
	FROM #SMATemp SMA CROSS JOIN StakeLevel ST
	CROSS APPLY (SELECT ',' + CAST(StakeLevelID AS VARCHAR(10))
			FROM StakeLevel S WITH (NOLOCK)
			WHERE S.GameTypeID =ST.GameTypeID AND S.ExchangeId= sma.currency
			FOR XML PATH ('') ) AS A(STL)
	WHERE ST.GameTypeID = @Bettype
	ORDER BY ST.GameTypeID
	--------------------------------------BetSetting-------------------------------------------------
	-->SMA level
	UPDATE cs
	SET cs.StakeLevelList = tb.StakeLevelList	
	FROM dbo.CustStakeLevel_Agent cs WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #SMATemp ci ON cs.CustID = ci.CustID
	INNER JOIN #tmpSTListSMA TB WITH (NOLOCK) ON TB.BettypeID = cs.BetType
	WHERE cs.SportType = @Sporttype AND cs.BetType = @Bettype


	DROP TABLE #SMATemp
	DROP TABLE #tmpSTListSMA
	DROP TABLE #supers

PRINT N'Step 3: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
