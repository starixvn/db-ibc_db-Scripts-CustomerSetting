/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20210908
	Task: Adjust BetSetting of Saba Soccer and Saba Basketball [Redmine: #159626]   
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO
BEGIN
	CREATE TABLE #CustBetSetting_Agent(
		CustID INT,
		SportType         SMALLINT, 
		BetType           SMALLINT, 
		MinBet            MONEY, 
		MaxBet            MONEY, 
		MaxPerMatch       MONEY, 
		MaxPayoutPerMatch MONEY
	)

	CREATE TABLE #CustBetSetting_Member(
		CustID INT,
		SportType         SMALLINT, 
		BetType           SMALLINT, 
		MinBet            MONEY, 
		MaxBet            MONEY, 
		MaxPerMatch       MONEY, 
		MaxPayoutPerMatch MONEY
	)

	CREATE TABLE #CustBetSetting_TmpBatch(
		CustID INT,
		SportType         SMALLINT, 
		BetType           SMALLINT, 
		MinBet            MONEY, 
		MaxBet            MONEY, 
		MaxPerMatch       MONEY, 
		MaxPayoutPerMatch MONEY
	)

	CREATE TABLE #supers (custid INT PRIMARY KEY)
	CREATE TABLE #sportbettype(fsporttype INT, fbettype INT, tsporttype INT, tbettype INT)

	INSERT INTO #sportbettype (fsporttype,fbettype,tsporttype,tbettype)
	SELECT 1,1,9901,1 UNION ALL
	SELECT 2,1,9902,1

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM customer ci WITH (NOLOCK) 
		INNER JOIN custInfo c WITH (NOLOCK) ON ci.custid = c.custid
		INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
		LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.roleid = 4  
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND s.islicensee = 0
		AND c.Enabled = 1
		AND ci.currency <> 20

	---->Saba Agents 
	INSERT INTO #CustBetSetting_Agent(CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch,MaxPayoutPerMatch)
	SELECT new.custid,new.sporttype,new.bettype,c.minbet,c.maxbet,c.MaxPerMatch,c.MaxPayoutPerMatch
	FROM CustBetSetting_Agent new WITH(NOLOCK)
		INNER JOIN custInfo ci WITH(NOLOCK) ON new.CustID = ci.custid
		INNER JOIN #sportbettype s ON new.SportType = s.tsporttype AND new.BetType = s.tbettype
		INNER JOIN CustBetSetting_Agent c WITH(NOLOCK) ON new.CustID = c.custid AND s.fSportType = c.sporttype AND s.fbettype = c.bettype
	WHERE ci.srecommend IN (SELECT custid FROM #supers)
		AND ci.roleid IN (2,3,4)
		AND ci.Enabled = 1
		AND (   new.MinBet <> c.minbet
				OR new.MaxBet <> c.maxbet 
				OR new.MaxPerMatch <> c.MaxPerMatch
				OR new.MaxPayoutPerMatch <> c.MaxPayoutPerMatch
				OR new.MinBet IS NULL
				OR new.MaxBet IS NULL
				OR new.MaxPerMatch IS NULL
				OR new.MaxPayoutPerMatch IS NULL
			)

	---->Saba Members
	INSERT INTO #CustBetSetting_Member(CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch)
	SELECT new.custid,new.sporttype,new.bettype,c.minbet,c.maxbet,c.MaxPerMatch,c.MaxPayoutPerMatch
	FROM CustBetSetting_Member new WITH(NOLOCK)
		INNER JOIN custInfo ci WITH(NOLOCK) ON new.CustID = ci.custid
		INNER JOIN #sportbettype s ON new.SportType = s.tsporttype AND new.BetType = s.tbettype
		INNER JOIN CustBetSetting_Member c WITH(NOLOCK) ON new.CustID = c.custid AND s.fSportType = c.sporttype AND s.fbettype = c.bettype
	WHERE ci.srecommend IN (SELECT custid FROM #supers)
		AND ci.roleid = 1
		AND ci.Enabled = 1
		AND (   new.MinBet <> c.minbet
				OR new.MaxBet <> c.maxbet 
				OR new.MaxPerMatch <> c.MaxPerMatch
				OR new.MaxPayoutPerMatch <> c.MaxPayoutPerMatch
				OR new.MinBet IS NULL
				OR new.MaxBet IS NULL
				OR new.MaxPerMatch IS NULL
				OR new.MaxPayoutPerMatch IS NULL
			)

	---->mix sport Agents 
	INSERT INTO #CustBetSetting_Agent(CustID,SportType,BetType)
	SELECT new.custid,new.sporttype,new.bettype
	FROM CustBetSetting_Agent new WITH(NOLOCK)
		INNER JOIN custInfo ci WITH(NOLOCK) ON new.CustID = ci.custid
	WHERE ci.srecommend IN (SELECT custid FROM #supers)
		AND ci.roleid IN (2,3,4)
		AND ci.Enabled = 1
		AND (   new.MaxPayoutPerMatch <> CASE WHEN new.MaxPerMatch >= 1 THEN new.MaxPerMatch * 10 ELSE new.MaxPerMatch END
				OR new.MaxPayoutPerMatch IS NULL
			)
		AND new.BetType = 9 
		AND new.SportType IN(1,99)

	---->mix sport Members
	INSERT INTO #CustBetSetting_Member(CustID,SportType,BetType)
	SELECT new.custid,new.sporttype,new.bettype
	FROM CustBetSetting_Member new WITH(NOLOCK)
		INNER JOIN custInfo ci WITH(NOLOCK) ON new.CustID = ci.custid
		INNER JOIN #sportbettype s ON new.SportType = s.tsporttype AND new.BetType = s.tbettype
		INNER JOIN CustBetSetting_Member c WITH(NOLOCK) ON new.CustID = c.custid AND s.fSportType = c.sporttype AND s.fbettype = c.bettype
	WHERE ci.srecommend IN (SELECT custid FROM #supers)
		AND ci.roleid = 1
		AND ci.Enabled = 1
		AND (   new.MaxPayoutPerMatch <> CASE WHEN new.MaxPerMatch >= 1 THEN new.MaxPerMatch * 10 ELSE new.MaxPerMatch END
				OR new.MaxPayoutPerMatch IS NULL
			)
		AND new.BetType = 9 
		AND new.SportType IN(1,99)

	--SELECT * FROM #CustBetSetting_Agent
	--SELECT * FROM #CustBetSetting_Member

	--> Adjust Saba Soccer, Saba Basketball
	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #CustBetSetting_TmpBatch
		
		DELETE TOP (5000) a
		OUTPUT deleted.CustID, 
			   deleted.SportType, 
			   deleted.BetType, 
			   deleted.MinBet, 
			   deleted.MaxBet, 
			   deleted.MaxPerMatch, 
			   deleted.MaxPayoutPerMatch
		INTO #CustBetSetting_TmpBatch(
			CustID, 
			SportType, 
			BetType, 
			MinBet, 
			MaxBet, 
			MaxPerMatch, 
			MaxPayoutPerMatch
			)
		FROM #CustBetSetting_Agent a
		WHERE a.SportType IN(9901,9902)

		IF @@ROWCOUNT = 0
			BREAK

		UPDATE b
		SET b.MinBet = t.MinBet,
			b.MaxBet = t.MaxBet,
			b.MaxPerMatch = t.MaxPerMatch,
			b.MaxPayoutPerMatch = t.MaxPayoutPerMatch
		FROM CustBetSetting_Agent b WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustBetSetting_TmpBatch t 
				ON b.CustID = t.CustID
				AND b.SportType = t.SportType
				AND b.BetType = t.BetType

	END

	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #CustBetSetting_TmpBatch
		
		DELETE TOP (5000) a
		OUTPUT deleted.CustID, 
			   deleted.SportType, 
			   deleted.BetType, 
			   deleted.MinBet, 
			   deleted.MaxBet, 
			   deleted.MaxPerMatch, 
			   deleted.MaxPayoutPerMatch
		INTO #CustBetSetting_TmpBatch(
			CustID, 
			SportType, 
			BetType, 
			MinBet, 
			MaxBet, 
			MaxPerMatch, 
			MaxPayoutPerMatch
			)
		FROM #CustBetSetting_Member a
		WHERE a.SportType IN(9901,9902)

		IF @@ROWCOUNT = 0
			BREAK

		UPDATE b
		SET b.MinBet = t.MinBet,
			b.MaxBet = t.MaxBet,
			b.MaxPerMatch = t.MaxPerMatch,
			b.MaxPayoutPerMatch = t.MaxPayoutPerMatch
		FROM CustBetSetting_Member b WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustBetSetting_TmpBatch t 
				ON b.CustID = t.CustID
				AND b.SportType = t.SportType
				AND b.BetType = t.BetType

	END
	
	--> Adjust max payout per match of parlay sport 
	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #CustBetSetting_TmpBatch
		
		DELETE TOP (5000) a
		OUTPUT deleted.CustID, 
			   deleted.SportType, 
			   deleted.BetType
		INTO #CustBetSetting_TmpBatch(
			CustID, 
			SportType, 
			BetType
			)
		FROM #CustBetSetting_Agent a
		WHERE a.SportType IN(1,99)
			AND a.BetType = 9

		IF @@ROWCOUNT = 0
			BREAK

		UPDATE b
		SET b.MaxPayoutPerMatch = CASE WHEN b.MaxPerMatch >= 1 THEN b.MaxPerMatch * 10 ELSE b.MaxPerMatch END
		FROM CustBetSetting_Agent b WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustBetSetting_TmpBatch t 
				ON b.CustID = t.CustID
				AND b.SportType = t.SportType
				AND b.BetType = t.BetType
	END

	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #CustBetSetting_TmpBatch
		
		DELETE TOP (5000) a
		OUTPUT deleted.CustID, 
			   deleted.SportType, 
			   deleted.BetType
		INTO #CustBetSetting_TmpBatch(
			CustID, 
			SportType, 
			BetType
			)
		FROM #CustBetSetting_Member a
		WHERE a.SportType IN(1,99)
			AND a.BetType = 9

		IF @@ROWCOUNT = 0
			BREAK

		UPDATE b
		SET b.MaxPayoutPerMatch = CASE WHEN b.MaxPerMatch >= 1 THEN b.MaxPerMatch * 10 ELSE b.MaxPerMatch END
		FROM CustBetSetting_Member b WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustBetSetting_TmpBatch t 
				ON b.CustID = t.CustID
				AND b.SportType = t.SportType
				AND b.BetType = t.BetType
	END

	DROP TABLE #CustBetSetting_Agent
	DROP TABLE #CustBetSetting_Member
	DROP TABLE #supers
	DROP TABLE #CustBetSetting_TmpBatch
	DROP TABLE #sportbettype
END
GO
