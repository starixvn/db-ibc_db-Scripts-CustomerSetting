/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20210908 
	Task: Initial data for Saba Soccer and Saba Basketball - New Accounts[Redmine: #159626]   
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO
BEGIN
	DECLARE @max_custid INT = xxx

	CREATE TABLE #supers (custid INT PRIMARY KEY)

	CREATE TABLE #SMAs(CustID INT)
	CREATE TABLE #Members(CustID INT)
	CREATE TABLE #CustTempBatch(CustID INT)

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

	INSERT INTO #SMAs (custid)
	SELECT custid
	FROM custInfo  WITH(NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers)
		AND roleid IN(2,3,4)
		AND Enabled = 1
		AND custid > @max_custid

	INSERT INTO #Members (custid)
	SELECT custid
	FROM custInfo WITH(NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers)
		AND roleid = 1
		AND Enabled = 1
		AND custid > @max_custid

	------------------------------------------INITIAL DATA---------------------------------------------------------------
	
	INSERT INTO CustBetSetting_Agent(CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch,MaxPayoutPerMatch)
	SELECT t.custid
		,sporttype = CASE WHEN mm.sporttype = 1 THEN 9901 ELSE 9902 END
		,mm.bettype,mm.minbet,mm.maxbet,mm.MaxPerMatch,mm.MaxPayoutPerMatch
	FROM #SMAs t
		INNER JOIN CustBetSetting_Agent mm WITH(NOLOCK) ON mm.custid = t.CustID
		LEFT JOIN CustBetSetting_Agent cs WITH(NOLOCK) ON t.CustID = cs.CustID AND cs.SportType IN(9901,9902) AND cs.BetType = 1
	WHERE mm.SportType IN(1,2) AND mm.BetType = 1
		AND cs.CustID IS NULL

	INSERT INTO CustBetSetting_Member(CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch,MaxPayoutPerMatch)
	SELECT t.custid
		,sporttype = CASE WHEN mm.sporttype = 1 THEN 9901 ELSE 9902 END
		,mm.bettype,mm.minbet,mm.maxbet,mm.MaxPerMatch,mm.MaxPayoutPerMatch
	FROM #Members t
		INNER JOIN CustBetSetting_Member mm WITH(NOLOCK) ON mm.custid = t.CustID
		LEFT JOIN CustBetSetting_Member cs WITH(NOLOCK) ON t.CustID = cs.CustID AND cs.SportType IN(9901,9902) AND cs.BetType = 1
	WHERE mm.SportType IN(1,2) AND mm.BetType = 1
		AND cs.CustID IS NULL

	--Update MaxPayoutPerMatch for soccer parrlay and mix sports parlay
	WHILE 1= 1
	BEGIN
		TRUNCATE TABLE #CustTempBatch
		DELETE TOP(2500) t
		OUTPUT deleted.CustID INTO #CustTempBatch(CustID)
		FROM #SMAs t

		IF @@ROWCOUNT = 0
			BREAK

		UPDATE b
		SET b.MaxPayoutPerMatch = CASE WHEN b.MaxPerMatch >= 1 THEN b.MaxPerMatch * 10 ELSE b.MaxPerMatch END
		FROM CustBetSetting_Agent b WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempBatch t ON b.CustID = t.CustID
		WHERE b.SportType IN(1,99) AND b.BetType = 9
	END

	WHILE 1= 1
	BEGIN
		TRUNCATE TABLE #CustTempBatch
		DELETE TOP(2500) t
		OUTPUT deleted.CustID INTO #CustTempBatch(CustID)
		FROM #Members t

		IF @@ROWCOUNT = 0
			BREAK

		UPDATE b
		SET b.MaxPayoutPerMatch = CASE WHEN b.MaxPerMatch >= 1 THEN b.MaxPerMatch * 10 ELSE b.MaxPerMatch END
		FROM CustBetSetting_Member b WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempBatch t ON b.CustID = t.CustID
		WHERE b.SportType IN(1,99) AND b.BetType = 9
	END
END

DROP TABLE #Members
DROP TABLE #SMAs
DROP TABLE #CustTempBatch
DROP TABLE #supers

