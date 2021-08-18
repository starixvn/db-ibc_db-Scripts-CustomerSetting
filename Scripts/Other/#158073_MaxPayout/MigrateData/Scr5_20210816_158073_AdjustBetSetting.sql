/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20210816
	Task: Adjust BetSetting of CustBetSetting_Agent and CustBetSetting_Member tables - New Accounts [Redmine: #154048]   
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
		MaxPerNumber      MONEY, 
		MaxPayoutPerMatch MONEY
	)

	CREATE TABLE #CustBetSetting_Member(
		CustID INT,
		SportType         SMALLINT, 
		BetType           SMALLINT, 
		MinBet            MONEY, 
		MaxBet            MONEY, 
		MaxPerMatch       MONEY, 
		MaxPerNumber      MONEY, 
		MaxPayoutPerMatch MONEY
	)

	CREATE TABLE #CustBetSetting_TmpBatch(
		CustID INT,
		SportType         SMALLINT, 
		BetType           SMALLINT, 
		MinBet            MONEY, 
		MaxBet            MONEY, 
		MaxPerMatch       MONEY, 
		MaxPerNumber      MONEY, 
		MaxPayoutPerMatch MONEY
	)

	CREATE TABLE #supers (custid INT PRIMARY KEY)

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

	----> Agents
	INSERT INTO #CustBetSetting_Agent(CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch)
	SELECT new.custid,new.sporttype,new.bettype,c.minbet,c.maxbet,
		CASE WHEN new.sporttype = 1 AND new.bettype = 1 THEN ci.maxpermatch
			WHEN new.sporttype = 1 AND new.bettype = 9 THEN ci.MaxPerMatch1MP
			WHEN new.sporttype = 2 AND new.bettype = 1 THEN ci.maxpermatch2
			WHEN new.sporttype = 3 AND new.bettype = 1 THEN ci.maxpermatch3
			WHEN new.sporttype = 5 AND new.bettype = 1 THEN ci.maxpermatch5
			WHEN new.sporttype = 8 AND new.bettype = 1 THEN ci.maxpermatch8
			WHEN new.sporttype = 10 AND new.bettype = 1 THEN ci.maxpermatch10
			WHEN new.sporttype = 11 AND new.bettype = 1 THEN ci.maxpermatch11
			WHEN new.sporttype = 99 AND new.bettype = 1 THEN ci.maxpermatch99
			WHEN new.sporttype = 99 AND new.bettype = 9 THEN ci.MaxPerMatch99MP
			WHEN new.sporttype = 161 THEN ci.maxpermatch161
			WHEN new.sporttype = 164 THEN ci.maxpermatch164
		END AS MaxPerMatch
	FROM CustBetSetting_Agent new WITH(NOLOCK)
		INNER JOIN custInfo ci WITH(NOLOCK) ON new.CustID = ci.custid
		INNER JOIN custSetting c WITH(NOLOCK) ON new.CustID = c.custid AND new.SportType = c.sporttype AND new.BetType = c.bettype
	WHERE ci.srecommend IN (SELECT custid FROM #supers)
		AND ci.roleid IN (2,3,4)
		AND ci.Enabled = 1
		AND (   new.MinBet <> c.minbet
				OR new.MaxBet <> c.maxbet 
				OR new.MaxPerMatch <>  CASE WHEN new.sporttype = 1 AND new.bettype = 1 THEN ci.maxpermatch
											WHEN new.sporttype = 1 AND new.bettype = 9 THEN ci.MaxPerMatch1MP
											WHEN new.sporttype = 2 AND new.bettype = 1 THEN ci.maxpermatch2
											WHEN new.sporttype = 3 AND new.bettype = 1 THEN ci.maxpermatch3
											WHEN new.sporttype = 5 AND new.bettype = 1 THEN ci.maxpermatch5
											WHEN new.sporttype = 8 AND new.bettype = 1 THEN ci.maxpermatch8
											WHEN new.sporttype = 10 AND new.bettype = 1 THEN ci.maxpermatch10
											WHEN new.sporttype = 11 AND new.bettype = 1 THEN ci.maxpermatch11
											WHEN new.sporttype = 99 AND new.bettype = 1 THEN ci.maxpermatch99
											WHEN new.sporttype = 99 AND new.bettype = 9 THEN ci.MaxPerMatch99MP
										END
			)
		AND new.SportType NOT IN (161,164)

	INSERT INTO #CustBetSetting_Agent(CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch,MaxPerNumber)
	SELECT new.custid,new.sporttype,new.bettype,c.minbet,c.maxbet,
		CASE WHEN new.sporttype = 161 THEN ci.maxpermatch161
			WHEN new.sporttype = 164 THEN ci.maxpermatch164
		END AS MaxPerMatch,
		CASE WHEN new.sporttype = 161 THEN ci.MaxPerBall161
		END AS MaxPerNumber
	FROM CustBetSetting_Agent new WITH(NOLOCK)
		INNER JOIN custInfo ci WITH(NOLOCK) ON new.CustID = ci.custid
		INNER JOIN CustSetting3rd c WITH(NOLOCK) ON new.CustID = c.custid AND new.SportType = c.sporttype AND new.BetType = c.bettype
	WHERE ci.srecommend IN (SELECT custid FROM #supers)
		AND ci.roleid IN (2,3,4)
		AND ci.Enabled = 1
		AND (   new.MinBet <> c.minbet
				OR new.MaxBet <> c.maxbet 
				OR new.MaxPerMatch <>  CASE WHEN new.sporttype = 161 THEN ci.maxpermatch161
											WHEN new.sporttype = 164 THEN ci.maxpermatch164
										END
				OR new.MaxPerNumber <>  CASE WHEN new.sporttype = 161 THEN ci.MaxPerBall161
										END
			)
		AND new.SportType IN (161,164)


	----> Members
	INSERT INTO #CustBetSetting_Member(CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch)
	SELECT new.custid,new.sporttype,new.bettype,c.minbet,c.maxbet,
		CASE WHEN new.sporttype = 1 AND new.bettype = 1 THEN ci.maxpermatch
			WHEN new.sporttype = 1 AND new.bettype = 9 THEN ci.MaxPerMatch1MP
			WHEN new.sporttype = 2 AND new.bettype = 1 THEN ci.maxpermatch2
			WHEN new.sporttype = 3 AND new.bettype = 1 THEN ci.maxpermatch3
			WHEN new.sporttype = 5 AND new.bettype = 1 THEN ci.maxpermatch5
			WHEN new.sporttype = 8 AND new.bettype = 1 THEN ci.maxpermatch8
			WHEN new.sporttype = 10 AND new.bettype = 1 THEN ci.maxpermatch10
			WHEN new.sporttype = 11 AND new.bettype = 1 THEN ci.maxpermatch11
			WHEN new.sporttype = 99 AND new.bettype = 1 THEN ci.maxpermatch99
			WHEN new.sporttype = 99 AND new.bettype = 9 THEN ci.MaxPerMatch99MP
			WHEN new.sporttype = 161 THEN ci.maxpermatch161
			WHEN new.sporttype = 164 THEN ci.maxpermatch164
		END AS MaxPerMatch
	FROM CustBetSetting_Member new WITH(NOLOCK)
		INNER JOIN custInfo ci WITH(NOLOCK) ON new.CustID = ci.custid
		INNER JOIN custSetting c WITH(NOLOCK) ON new.CustID = c.custid AND new.SportType = c.sporttype AND new.BetType = c.bettype
	WHERE ci.srecommend IN (SELECT custid FROM #supers)
		AND ci.roleid = 1
		AND ci.Enabled = 1
		AND (   new.MinBet <> c.minbet
				OR new.MaxBet <> c.maxbet 
				OR new.MaxPerMatch <>  CASE WHEN new.sporttype = 1 AND new.bettype = 1 THEN ci.maxpermatch
											WHEN new.sporttype = 1 AND new.bettype = 9 THEN ci.MaxPerMatch1MP
											WHEN new.sporttype = 2 AND new.bettype = 1 THEN ci.maxpermatch2
											WHEN new.sporttype = 3 AND new.bettype = 1 THEN ci.maxpermatch3
											WHEN new.sporttype = 5 AND new.bettype = 1 THEN ci.maxpermatch5
											WHEN new.sporttype = 8 AND new.bettype = 1 THEN ci.maxpermatch8
											WHEN new.sporttype = 10 AND new.bettype = 1 THEN ci.maxpermatch10
											WHEN new.sporttype = 11 AND new.bettype = 1 THEN ci.maxpermatch11
											WHEN new.sporttype = 99 AND new.bettype = 1 THEN ci.maxpermatch99
											WHEN new.sporttype = 99 AND new.bettype = 9 THEN ci.MaxPerMatch99MP
										END
			)
		AND new.SportType NOT IN (161,164)

	INSERT INTO #CustBetSetting_Member(CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch,MaxPerNumber)
	SELECT new.custid,new.sporttype,new.bettype,c.minbet,c.maxbet,
		CASE WHEN new.sporttype = 161 THEN ci.maxpermatch161
			WHEN new.sporttype = 164 THEN ci.maxpermatch164
		END AS MaxPerMatch,
		CASE WHEN new.sporttype = 161 THEN ci.MaxPerBall161
		END AS MaxPerNumber
	FROM CustBetSetting_Member new WITH(NOLOCK)
		INNER JOIN custInfo ci WITH(NOLOCK) ON new.CustID = ci.custid
		INNER JOIN CustSetting3rd c WITH(NOLOCK) ON new.CustID = c.custid AND new.SportType = c.sporttype AND new.BetType = c.bettype
	WHERE ci.srecommend IN (SELECT custid FROM #supers)
		AND ci.roleid = 1
		AND ci.Enabled = 1
		AND (   new.MinBet <> c.minbet
				OR new.MaxBet <> c.maxbet 
				OR new.MaxPerMatch <>  CASE WHEN new.sporttype = 161 THEN ci.maxpermatch161
											WHEN new.sporttype = 164 THEN ci.maxpermatch164
										END
				OR new.MaxPerNumber <>  CASE WHEN new.sporttype = 161 THEN ci.MaxPerBall161
										END
			)
		AND new.SportType IN (161,164)

	--SELECT * FROM #CustBetSetting_Agent
	--SELECT * FROM #CustBetSetting_Member

	--> Update maxper payout
	UPDATE c
	SET c.MaxPayoutPerMatch = CASE WHEN c.MaxPerMatch >= 1 THEN c.MaxPerMatch*10 ELSE c.MaxPerMatch  END
	FROM #CustBetSetting_Agent c
	WHERE c.SportType NOT IN (161,164) 
		AND c.BetType <> 9 

	UPDATE c
	SET c.MaxPayoutPerMatch = CASE WHEN c.MaxPerMatch >= 1 THEN c.MaxPerMatch*10 ELSE c.MaxPerMatch  END
	FROM #CustBetSetting_Member c
	WHERE c.SportType NOT IN (161,164) 
		AND c.BetType <> 9

	--SELECT * FROM #CustBetSetting_Agent
	--SELECT * FROM #CustBetSetting_Member

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
			   deleted.MaxPayoutPerMatch, 
			   deleted.MaxPerNumber
		INTO #CustBetSetting_TmpBatch(
			CustID, 
			SportType, 
			BetType, 
			MinBet, 
			MaxBet, 
			MaxPerMatch, 
			MaxPayoutPerMatch, 
			MaxPerNumber
			)
		FROM #CustBetSetting_Agent a

		IF @@ROWCOUNT = 0
			BREAK

		UPDATE b
		SET b.MinBet = t.MinBet,
			b.MaxBet = t.MaxBet,
			b.MaxPerMatch = t.MaxPerMatch,
			b.MaxPayoutPerMatch = t.MaxPayoutPerMatch,
			b.MaxPerNumber = t.MaxPerNumber
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
			   deleted.MaxPayoutPerMatch, 
			   deleted.MaxPerNumber
		INTO #CustBetSetting_TmpBatch(
			CustID, 
			SportType, 
			BetType, 
			MinBet, 
			MaxBet, 
			MaxPerMatch, 
			MaxPayoutPerMatch, 
			MaxPerNumber
			)
		FROM #CustBetSetting_Member a

		IF @@ROWCOUNT = 0
			BREAK

		UPDATE b
		SET b.MinBet = t.MinBet,
			b.MaxBet = t.MaxBet,
			b.MaxPerMatch = t.MaxPerMatch,
			b.MaxPayoutPerMatch = t.MaxPayoutPerMatch,
			b.MaxPerNumber = t.MaxPerNumber
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
END
GO
