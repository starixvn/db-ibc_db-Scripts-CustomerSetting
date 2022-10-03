/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 20220927
	Task:	 [GMASTER] Adjust member CNY Bet Limit RedmineID:#178207
	DB:		 DBCUST/CustDB
*/
USE [CustDB]
GO
-----------------------------------------------------

CREATE TABLE #Dummy				(CustID INT PRIMARY KEY)	
CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY CLUSTERED, srecommend INT, 
								 mrecommend INT, recommend INT,isfinished BIT DEFAULT(0))
CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY CLUSTERED, RoleID INT, Currency INT, isfinished BIT DEFAULT(0))
CREATE TABLE #tmpCustInvid		(CustID INT PRIMARY KEY, recommend INT,isfinished BIT DEFAULT(0))
CREATE TABLE #tmpCustTemp		(CustID INT PRIMARY KEY, recommend INT)

DECLARE @MaxBet	MONEY
SELECT @MaxBet = 200000

DECLARE @SportBettype_tbl Table(Sporttype SMALLINT, BetType SMALLINT)
INSERT INTO @SportBettype_tbl(Sporttype,BetType)
SELECT a.SportType,a.BetType
FROM Dep_ProductSettingDetail a WITH(NOLOCK)
	INNER JOIN Dep_ProductSetting b WITH(NOLOCK) ON a.ProductSettingID = b.ProductSettingID
WHERE b.ProductID IN(1) AND SettingType = 10
GROUP BY a.SportType,a.BetType

-- Super	
INSERT INTO #tmpSMA(CustID,RoleID, Currency)
SELECT ci.custid, ci.roleid, ci.currency
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'
		AND ci.Enabled=1  
		AND (cs.site IN ('GMASTER')
		AND Ci.currency IN (13))-- RMB
		ORDER BY ci.custid 

INSERT INTO #Dummy(CustID)
SELECT CustID FROM Customer WITH(NOLOCK) 
WHERE srecommend IN (SELECT CustID FROM #tmpSMA)
AND roleid=3 
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

--Member
INSERT INTO #tmpCust(CustID, srecommend, mrecommend, recommend)
SELECT ci.CustID, ci.srecommend, ci.mrecommend, ci.recommend
FROM Customer ci WITH (NOLOCK)
	INNER JOIN custInfo c WITH (NOLOCK) ON ci.custid = c.custid
WHERE ci.srecommend IN (SELECT custid FROM #tmpSMA) 
	AND ci.roleid = 1  
	AND c.Enabled = 1 
	AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND ci.username2 LIKE '%' + 'aag' + '%' + '_gmgm'

-- Master, Agent
INSERT INTO #tmpSMA(CustID,RoleID,Currency)
SELECT custid, roleid,Currency
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN (SELECT custid FROM #tmpSMA) 
AND roleid IN (2,3) 
AND Enabled = 1 
AND mrecommend NOT IN (SELECT custid FROM #Dummy)
AND custid IN (SELECT DISTINCT mrecommend FROM #tmpCust UNION ALL  SELECT DISTINCT recommend FROM #tmpCust)

--Member invidual
INSERT INTO #tmpCustInvid(CustID,recommend)
SELECT ci.CustID,ci.recommend
FROM custInfo ci WITH (NOLOCK)
	INNER JOIN #tmpSMA c WITH (NOLOCK) ON ci.recommend = c.custid AND c.RoleID = 2
WHERE NOT EXISTS(SELECT TOP 1 1 FROM #tmpCust WITH(NOLOCK) WHERE Custid=ci.CustID)
AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_CustBetSettingGame_Member WITH(NOLOCK) WHERE Custid=ci.CustID)
-- delete EXISTS invidual data
DECLARE @batch int = 1000
	
WHILE EXISTS(SELECT TOP 1 1 FROM #tmpCustInvid WHERE isfinished = 0)
BEGIN
	UPDATE TOP (@batch) #tmpCustInvid 
	SET isfinished = 1
	OUTPUT DELETED.CustID INTO #tmpCustTemp(CustID)
	WHERE isfinished = 0

	IF @@ROWCOUNT=0
		BREAK		

	DELETE cg
	FROM dbo.Dep_CustBetSettingGame_Member cg WITH(ROWLOCK)	
		CROSS APPLY @SportBettype_tbl b
		INNER JOIN #tmpCustTemp  t 
			ON cg.CustID=t.CustID AND cg.SportType=b.Sporttype AND cg.BetType=b.Bettype

	TRUNCATE TABLE #tmpCustTemp
END

-- Insert invidual data for members 
WHILE EXISTS(SELECT TOP 1 1 FROM #tmpCustInvid WHERE isfinished = 1)
BEGIN
	UPDATE TOP (@batch)  a
	SET isfinished = 0
	OUTPUT DELETED.CustID,DELETED.recommend INTO #tmpCustTemp(CustID,recommend)
	FROM #tmpCustInvid a
	WHERE isfinished = 1

	IF @@ROWCOUNT=0
		BREAK		
	
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
		cg.MaxBet,
		cg.MaxPerMatch,
		cg.MaxPerNumber,
		cg.MaxPayoutPerMatch
	FROM dbo.Dep_CustBetSettingGameGroup_Member cg WITH(ROWLOCK)	
		CROSS APPLY @SportBettype_tbl b
		INNER JOIN #tmpCustTemp t ON cg.AgentID=t.recommend AND cg.SportType = b.Sporttype AND cg.BetType = b.BetType
	--Update Dep_CustSettingMode
	UPDATE c 
	SET IsGroupedBetLimit = 0
	FROM Dep_CustSettingMode c WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #tmpCustTemp t ON c.CustID = t.CustID
	
	TRUNCATE TABLE #tmpCustTemp
END

UPDATE a 
SET  a.MaxBet = @MaxBet
FROM Dep_CustBetSettingGame_Agent a WITH(ROWLOCK, UPDLOCK)
	CROSS APPLY @SportBettype_tbl b
	INNER JOIN #tmpSMA c ON a.CustID = c.CustID AND a.SportType = b.Sporttype AND a.BetType = b.BetType

UPDATE a 
SET  a.MaxBet = @MaxBet
FROM Dep_CustBetSettingGameGroup_Member a WITH(ROWLOCK, UPDLOCK)
	CROSS APPLY @SportBettype_tbl b
	INNER JOIN #tmpSMA c ON a.AgentID = c.CustID AND a.SportType = b.Sporttype AND a.BetType = b.BetType

DROP TABLE #Dummy
DROP TABLE #tmpCust
DROP TABLE #tmpSMA
DROP TABLE #tmpCustInvid
DROP TABLE #tmpCustTemp