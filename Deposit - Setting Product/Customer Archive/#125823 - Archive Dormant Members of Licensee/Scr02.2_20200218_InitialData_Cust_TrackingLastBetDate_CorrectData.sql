/*
	Created: Eden
	Date: 20210125
	Task: Correct Data for Cust_TrackingLastBetDate [RM:#125823]
	DB: DBACC/bodb02
*/
USE bodb02
GO

DECLARE @CheckBettrans_CustPerBatch  INT = 2000

INSERT INTO Cust_TrackingLastBetDate(custid)
SELECT cust.custid
FROM customer cust WITH (NOLOCK)
	INNER JOIN custInfo ci WITH (NOLOCK) ON cust.custid = ci.custid
	INNER JOIN custInfo ag WITH (NOLOCK) ON ag.custid = ci.recommend
WHERE cust.roleid = 1
	AND cust.srecommend IN (SELECT custid FROM Dep_CustSuper WITH (NOLOCK))
	AND Cust.custid NOT IN (SELECT CustID FROM bodb02.dbo.Dep_Customer_Archived WITH (NOLOCK))
	AND Cust.custid NOT IN (SELECT custid FROM DBCUST.CustDB.dbo.Dep_Customer_Archived_Exception WITH (NOLOCK))
	AND cust.custid NOT IN (SELECT CustID FROM Cust_TrackingLastBetDate b WITH(NOLOCK) )
	AND ci.username NOT LIKE '%BetTrade%' 
	AND ci.username NOT LIKE '%CashOut%' 
	AND ci.username NOT LIKE '%ClearBal%'
	AND ci.username NOT LIKE '%01OddsAdj%'
	AND ag.username NOT LIKE '%ACC%' 
	AND cust.creatdate >= GETDATE() - 15

CREATE TABLE #Member 
(
	  custid int PRIMARY KEY
	, LastBetDate DATETIME
	, isProcessed BIT default 0
)

CREATE TABLE #tmpMember 
(
	custid INT PRIMARY KEY
)

CREATE TABLE #BettingMember 
(
	custid INT PRIMARY KEY
	,LastBetDate DATETIME 
)

INSERT INTO #Member(custid, LastBetDate)
SELECT custid, ISNULL(LastBetDate,'1900/01/01') AS LastBetDate
FROM Cust_TrackingLastBetDate WITH(NOLOCK)

WHILE ( 1 = 1 )
BEGIN
	TRUNCATE TABLE #tmpMember

	INSERT INTO #tmpMember
	SELECT TOP (@CheckBettrans_CustPerBatch) custid
	FROM #Member 
	WHERE isProcessed = 0
		
	IF (@@ROWCOUNT = 0) 
		BREAK

	--> scan ticket from bettrans
	TRUNCATE TABLE #BettingMember
	INSERT INTO #BettingMember(custid,LastBetDate)
	SELECT custid, MAX(b.transdate) AS transdate
	FROM bettrans b with (NOLOCK)
	WHERE bettype <> 20000 
		AND b.custid IN (SELECT CustID FROM #tmpMember b WITH(NOLOCK) )
	GROUP BY b.custid

	UPDATE a
	SET a.LastBetDate = b.LastBetDate
	FROM #Member a
		INNER JOIN #BettingMember b with (NOLOCK) ON a.custID = b.custid
	WHERE a.LastBetDate < b.LastBetDate

	--> scan ticket from bettransRNG
	TRUNCATE TABLE #BettingMember
	INSERT INTO #BettingMember(custid,LastBetDate)
	SELECT custid, MAX(b.transdate) AS transdate
	FROM bettransRNG b with (NOLOCK)
	WHERE b.custid IN (SELECT CustID FROM #tmpMember b WITH(NOLOCK) )
	GROUP BY b.custid

	UPDATE a
	SET a.LastBetDate = b.LastBetDate
	FROM #Member a
		INNER JOIN #BettingMember b with (NOLOCK) ON a.custID = b.custid
	WHERE a.LastBetDate < b.LastBetDate

	--> scan ticket from bettransLC
	TRUNCATE TABLE #BettingMember
	INSERT INTO #BettingMember(custid,LastBetDate)
	SELECT custid, MAX(b.transdate) AS transdate
	FROM bettransLC b with (NOLOCK)
	WHERE b.custid IN (SELECT CustID FROM #tmpMember b WITH(NOLOCK) )
	GROUP BY b.custid

	UPDATE a
	SET a.LastBetDate = b.LastBetDate
	FROM #Member a
		INNER JOIN #BettingMember b with (NOLOCK) ON a.custID = b.custid
	WHERE a.LastBetDate < b.LastBetDate

	--> scan ticket from translog
	TRUNCATE TABLE #BettingMember
	INSERT INTO #BettingMember(custid,LastBetDate)
	SELECT custid, MAX(b.transdate) AS transdate
	FROM translog b with (NOLOCK)
	WHERE b.custid IN (SELECT CustID FROM #tmpMember b WITH(NOLOCK) )
	GROUP BY b.custid

	UPDATE a
	SET a.LastBetDate = b.LastBetDate
	FROM #Member a
		INNER JOIN #BettingMember b with (NOLOCK) ON a.custID = b.custid
	WHERE a.LastBetDate < b.LastBetDate

	--> scan ticket from DBPTCS.bodb_PlaytechCS.dbo.bettrans_AGCasino
	TRUNCATE TABLE #BettingMember
	INSERT INTO #BettingMember(custid,LastBetDate)
	SELECT custid, MAX(b.transdate) AS transdate
	FROM DBPTCS.bodb_PlaytechCS.dbo.bettrans_AGCasino b with (NOLOCK)
	WHERE b.custid IN (SELECT CustID FROM #tmpMember b WITH(NOLOCK) )
	GROUP BY b.custid

	UPDATE a
	SET a.LastBetDate = b.LastBetDate
	FROM #Member a
		INNER JOIN #BettingMember b with (NOLOCK) ON a.custID = b.custid
	WHERE a.LastBetDate < b.LastBetDate

	--> scan ticket from DBPTCS.bodb_PlaytechCS.dbo.bettrans_GoldDeluxe
	TRUNCATE TABLE #BettingMember
	INSERT INTO #BettingMember(custid,LastBetDate)
	SELECT custid, MAX(b.transdate) AS transdate
	FROM DBPTCS.bodb_PlaytechCS.dbo.bettrans_GoldDeluxe b with (NOLOCK)
	WHERE b.custid IN (SELECT CustID FROM #tmpMember b WITH(NOLOCK) )
	GROUP BY b.custid

	UPDATE a
	SET a.LastBetDate = b.LastBetDate
	FROM #Member a
		INNER JOIN #BettingMember b with (NOLOCK) ON a.custID = b.custid
	WHERE a.LastBetDate < b.LastBetDate

	UPDATE a
	SET a.LastBetDate = b.LastBetDate
	FROM Cust_TrackingLastBetDate a WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #Member b with (NOLOCK) ON a.custID = b.custid
	WHERE ISNULL(a.LastBetDate,'1900/01/01') < b.LastBetDate 
		AND b.LastBetDate > '1900/01/01'

	UPDATE #Member
	SET isProcessed = 1
	WHERE custid IN (SELECT custid FROM #tmpMember)
END

DROP TABLE #BettingMember
DROP TABLE #Member
DROP TABLE #tmpMember
GO