/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Johnson
	Date:	 20240522
	Task:	 [Yibo] - Adjust SB INH member betlimit [redmine:#205371]
	DB:		 DBCUST/CustDB
*/


CREATE TABLE #Dummy				(CustID INT PRIMARY KEY)	
CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY CLUSTERED, recommend INT)
CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY CLUSTERED)

DECLARE @MaxBet	MONEY, @MaxPerMatch MONEY, @MaxPayoutPerMatch MONEY
SELECT @MaxBet = 10000000 , @MaxPerMatch = 50000000, @MaxPayoutPerMatch = 400000000

-- Super	
INSERT INTO #tmpSMA(CustID)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'
		AND ci.Enabled=1  
		AND cs.site IN ('Yibo')
		AND Ci.currency IN (51)-- INH


INSERT INTO #Dummy(CustID)
SELECT CustID FROM Customer WITH(NOLOCK) 
WHERE srecommend IN (SELECT CustID FROM #tmpSMA)
AND roleid=3 
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

--43 Members
INSERT INTO #tmpCust(CustID,recommend)
SELECT ci.CustID, ci.recommend
FROM Customer ci WITH (NOLOCK)
	INNER JOIN custInfo c WITH (NOLOCK) ON ci.custid = c.custid
WHERE ci.srecommend IN (SELECT custid FROM #tmpSMA) 
	AND ci.roleid = 1  
	AND c.Enabled = 1 
	AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND ci.username2 LIKE '%vnd292_%'
	
-- Master, Agent
INSERT INTO #tmpSMA(CustID)
SELECT custid
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN (SELECT custid FROM #tmpSMA) 
AND roleid IN (2,3) 
AND Enabled = 1 
AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	--Add invidual setting for special members
	--43 customers
	INSERT INTO Dep_CustBetSettingGame_Member(
		CustID,
		SportType,
		BetType,
		MinBet,
		MaxBet,
		MaxPerMatch,
		MaxPerNumber,
		MaxPayoutPerMatch
	)
	SELECT t.custID,
		cg.SportType,
		cg.BetType,
		cg.MinBet,
		CASE WHEN sporttype = 161 THEN cg.MaxBet ELSE @MaxBet END,
		CASE WHEN sporttype = 161 THEN cg.MaxPerMatch ELSE @MaxPerMatch END,
		cg.MaxPerNumber,
		CASE WHEN sporttype = 161 THEN cg.MaxPayoutPerMatch ELSE @MaxPayoutPerMatch END
	FROM dbo.Dep_CustBetSettingGameGroup_Member cg WITH(ROWLOCK)
		INNER JOIN #tmpCust t ON t.recommend = cg.AgentID
	
	--Update Dep_CustSettingMode
	UPDATE c 
	SET IsGroupedBetLimit = 0
	FROM Dep_CustSettingMode c WITH(ROWLOCK,UPDLOCK)
	WHERE custid IN (SELECT custid FROM #tmpCust)	
	
	--update SMA 
	UPDATE a 
	SET  MaxBet = @MaxBet,
		MaxPerMatch = @MaxPerMatch,
		MaxPayoutPerMatch = @MaxPayoutPerMatch
	FROM Dep_CustBetSettingGame_Agent a WITH(ROWLOCK, UPDLOCK)
	WHERE sporttype NOT IN (161)
		AND custid IN (SELECT custid FROM #tmpSMA)