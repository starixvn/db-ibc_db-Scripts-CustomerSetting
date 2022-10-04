/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 20221003
	Task:	 [GMASTER] Remove Bet Limit setitng NG for GMASTERSuperRMB  RedmineID:#178479
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

DECLARE @Sporttype SMALLINT, @BetType SMALLINT
SELECT @Sporttype = 161 , @BetType = 81
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
SELECT CustID FROM  Customer WITH(NOLOCK) 
WHERE srecommend IN (SELECT CustID FROM #tmpSMA)
AND roleid=3 
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

-- Master, Agent
INSERT INTO #tmpSMA(CustID,RoleID,Currency)
SELECT custid, roleid,Currency
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN (SELECT custid FROM #tmpSMA) 
AND roleid IN (2,3) 
AND Enabled = 1 
AND mrecommend NOT IN (SELECT custid FROM #Dummy)

--Member invidual
INSERT INTO #tmpCustInvid(CustID,recommend)
SELECT ci.CustID,ci.recommend
FROM custInfo ci WITH (NOLOCK)
	INNER JOIN #tmpSMA c WITH (NOLOCK) ON ci.recommend = c.custid AND c.RoleID = 2
WHERE  EXISTS(SELECT TOP 1 1 FROM Dep_CustBetSettingGame_Member WITH(NOLOCK) WHERE Custid=ci.CustID AND SportType = @Sporttype AND BetType = @BetType)

DELETE cg
FROM dbo.Dep_CustBetSettingGame_Member cg WITH(ROWLOCK)	
	INNER JOIN #tmpCustInvid  t ON cg.CustID=t.CustID AND cg.SportType=@Sporttype AND cg.BetType=@BetType

DELETE cg
FROM dbo.Dep_CustBetSettingGameGroup_Member cg WITH(ROWLOCK)	
	INNER JOIN #tmpSMA  t ON cg.AgentID=t.CustID AND cg.SportType=@Sporttype AND cg.BetType=@BetType

DELETE cg
FROM dbo.Dep_CustBetSettingGame_Agent cg WITH(ROWLOCK)	
	INNER JOIN #tmpSMA  t ON cg.CustID=t.CustID AND cg.SportType=@Sporttype AND cg.BetType=@BetType

--SELECT TOP 100 *
--FROM dbo.Dep_CustBetSettingGame_Member cg WITH(NOLOCK)	
--	INNER JOIN #tmpCustInvid  t ON cg.CustID=t.CustID AND cg.SportType=@Sporttype AND cg.BetType=@BetType

--SELECT TOP 100 *
--FROM dbo.Dep_CustBetSettingGameGroup_Member cg WITH(NOLOCK)	
--	INNER JOIN #tmpSMA  t ON cg.AgentID=t.CustID AND cg.SportType=@Sporttype AND cg.BetType=@BetType

--SELECT TOP 100 *
--FROM dbo.Dep_CustBetSettingGame_Agent cg WITH(NOLOCK)	
--	INNER JOIN #tmpSMA  t ON cg.CustID=t.CustID AND cg.SportType=@Sporttype AND cg.BetType=@BetType

DROP TABLE #Dummy
DROP TABLE #tmpCust
DROP TABLE #tmpSMA
DROP TABLE #tmpCustInvid
DROP TABLE #tmpCustTemp
