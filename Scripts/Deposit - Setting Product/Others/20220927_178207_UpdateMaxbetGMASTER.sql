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
CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY CLUSTERED, srecommend INT, mrecommend INT, recommend INT,isfinished BIT DEFAULT(0))
CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY CLUSTERED, RoleID INT, Currency INT, isfinished BIT DEFAULT(0))

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

UPDATE a 
SET  a.MaxBet = @MaxBet
FROM Dep_CustBetSettingGame_Member a WITH(ROWLOCK, UPDLOCK)
	CROSS APPLY @SportBettype_tbl b
	INNER JOIN #tmpSMA c ON a.CustID = c.CustID AND a.SportType = b.Sporttype AND a.BetType = b.BetType

DROP TABLE #Dummy
DROP TABLE #tmpCust
DROP TABLE #tmpSMA