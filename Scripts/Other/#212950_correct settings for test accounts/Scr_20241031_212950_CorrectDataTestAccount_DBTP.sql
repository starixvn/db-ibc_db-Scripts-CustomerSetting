/*<info serverAlias="DBTP-bodb02"></info>*/
/*
	Created: 20241031@Eden
	Task:  Corect data test DBTP[Redmine: #212950]    
	Database: DBTP-bodb02
*/

USE bodb02
GO
CREATE TABLE #Temp_Super (CustID INT)
CREATE TABLE #Temp_Cust(custID INT, RoleID TINYINT)

INSERT INTO #Temp_Super(CustID)
SELECT custid 
FROM custinfo WITH(NOLOCK) 
WHERE username IN (
					'BODemoCVSuperWon2'
					,'BODemoCVSuperJPY2'
					,'BODemoCVSuperPE2'
					,'LiteDemoSuperUS$'
					,'NeuronDemoSuperPE'
					)

INSERT INTO #Temp_Cust(CustID,RoleID)
SELECT custid,roleid
FROM custinfo WITH(NOLOCK) 
WHERE srecommend IN (SELECT custid FROM #Temp_Super)

--SELECT * FROM #Temp_Cust

--> Mark isdeleted =1 for sporttype = 0
UPDATE cs
SET cs.isdeleted = 1,
	cs.RepUpdateTime =  dbo.f_GetDateTime2()
FROM Dep_CustBetSettingGame_Agent cs WITH(ROWLOCK)
	INNER JOIN #Temp_Cust c ON cs.CustID = c.custID
	AND sporttype = 0

UPDATE cs
SET cs.isdeleted = 1,
	cs.RepUpdateTime =  dbo.f_GetDateTime2()
FROM Dep_CustBetSettingGame_Member cs WITH(ROWLOCK)
	INNER JOIN #Temp_Cust c ON cs.CustID = c.custID
	AND sporttype = 0

UPDATE cs
SET cs.isdeleted = 1,
	cs.RepUpdateTime =  dbo.f_GetDateTime2()
FROM Dep_CustBetSettingGameGroup_Member cs WITH(ROWLOCK)
	INNER JOIN #Temp_Cust c ON cs.AgentID = c.custID
	AND sporttype = 0

----Insert 161
--INSERT INTO Dep_CustBetSettingGame_Agent(
--	 CustID
--	,SportType
--	,BetType
--	,MinBet
--	,MaxBet
--	,MaxPerMatch
--	,MaxPerNumber
--	,MaxPayoutPerMatch
--	,RepUpdateTime
--	,IsDeleted
--)
--SELECT 	cs.CustID
--	,SportType = 161
--	,BetType = 81
--	,cs.MinBet
--	,cs.MaxBet
--	,cs.MaxPerMatch
--	,cs.MaxPerNumber
--	,cs.MaxPayoutPerMatch
--	,RepUpdateTime=  dbo.f_GetDateTime2()
--	, IsDeleted = 0
--FROM Dep_CustBetSettingGame_Agent cs WITH(NOLOCK)
--	INNER JOIN #Temp_Cust c ON cs.CustID = c.custID
--	AND sporttype = 0
--WHERE NOT EXISTS( SELECT 1 FROM Dep_CustBetSettingGame_Agent (NOLOCK) WHERE cs.CustID = CustID AND sporttype = 161 and bettype = 81) 

--INSERT INTO Dep_CustBetSettingGame_Member(
--	 CustID
--	,SportType
--	,BetType
--	,MinBet
--	,MaxBet
--	,MaxPerMatch
--	,MaxPerNumber
--	,MaxPayoutPerMatch
--	,RepUpdateTime
--	,IsDeleted
--)
--SELECT 	cs.CustID
--	,SportType = 161
--	,BetType = 81
--	,cs.MinBet
--	,cs.MaxBet
--	,cs.MaxPerMatch
--	,cs.MaxPerNumber
--	,cs.MaxPayoutPerMatch
--	,RepUpdateTime=  dbo.f_GetDateTime2()
--	, IsDeleted = 0
--FROM Dep_CustBetSettingGame_Member cs WITH(NOLOCK)
--	INNER JOIN #Temp_Cust c ON cs.CustID = c.custID
--	AND sporttype = 0
--WHERE NOT EXISTS( SELECT 1 FROM Dep_CustBetSettingGame_Member (NOLOCK) WHERE cs.CustID = CustID AND sporttype = 161 and bettype = 81) 

--INSERT INTO Dep_CustBetSettingGameGroup_Member(
--	 AgentID
--	,SportType
--	,BetType
--	,MinBet
--	,MaxBet
--	,MaxPerMatch
--	,MaxPerNumber
--	,MaxPayoutPerMatch
--	,RepUpdateTime
--	,IsDeleted
--)
--SELECT 	cs.AgentID
--	,SportType = 161
--	,BetType = 81
--	,cs.MinBet
--	,cs.MaxBet
--	,cs.MaxPerMatch
--	,cs.MaxPerNumber
--	,cs.MaxPayoutPerMatch
--	,RepUpdateTime=  dbo.f_GetDateTime2()
--	, IsDeleted = 0
--FROM Dep_CustBetSettingGameGroup_Member cs WITH(NOLOCK)
--	INNER JOIN #Temp_Cust c ON cs.AgentID = c.custID
--	AND sporttype = 0
--WHERE NOT EXISTS( SELECT 1 FROM Dep_CustBetSettingGameGroup_Member (NOLOCK) WHERE cs.AgentID = AgentID AND sporttype = 161 and bettype = 81) 

DROP TABLE #Temp_Cust
DROP TABLE #Temp_Super