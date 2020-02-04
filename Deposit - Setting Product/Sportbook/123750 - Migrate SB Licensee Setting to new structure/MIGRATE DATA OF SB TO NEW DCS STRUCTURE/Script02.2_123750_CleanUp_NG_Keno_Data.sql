/*
	Created: Eden
	Date: 20191029
	Task: Cleanup data New tables for Number Games and Keno [RM:#123750]
	DB: DBCust/CustDB
*/
SELECT custid,sporttype,bettype INTO #Dep_CustBetSetting_Agent			FROM Dep_CustBetSetting_Agent WITH(NOLOCK)			WHERE Sporttype IN (161, 202) 
SELECT custid,sporttype,bettype INTO #Dep_CustBetSetting_Member			FROM Dep_CustBetSetting_Member WITH(NOLOCK)			WHERE Sporttype IN (161, 202)
SELECT custid,sporttype,bettype INTO #Dep_CustBetSettingGame_Agent		FROM Dep_CustBetSettingGame_Agent WITH(NOLOCK)		WHERE Sporttype IN (161, 202) 
SELECT custid,sporttype,bettype INTO #Dep_CustBetSettingGame_Member		FROM Dep_CustBetSettingGame_Member WITH(NOLOCK)		WHERE Sporttype IN (161, 202)
SELECT custid,sporttype,bettype INTO #Dep_CustPTSetting_Agent			FROM Dep_CustPTSetting_Agent WITH(NOLOCK)			WHERE Sporttype IN (161, 202)  
SELECT custid,sporttype,bettype INTO #Dep_CustPTSetting_Member			FROM Dep_CustPTSetting_Member WITH(NOLOCK)			WHERE Sporttype IN (161, 202) 
SELECT AgentID,sporttype,bettype INTO #Dep_CustPTGroupSetting_Member 	FROM Dep_CustPTGroupSetting_Member  WITH(NOLOCK)	WHERE Sporttype IN (161, 202) 
SELECT custid,sporttype,bettype INTO #Dep_CustDiscountSetting_Agent		FROM Dep_CustDiscountSetting_Agent WITH(NOLOCK)		WHERE Sporttype IN (161, 202)   
SELECT custid,sporttype,bettype INTO #Dep_CustDiscountSetting_Member	FROM Dep_CustDiscountSetting_Member WITH(NOLOCK)	WHERE Sporttype IN (161, 202)  

DELETE a
FROM Dep_CustBetSetting_Agent a WITH(ROWLOCK) 
	INNER JOIN #Dep_CustBetSetting_Agent b WITH(NOLOCK) ON a.custid = b.custid AND a.sporttype = b.sporttype AND a.bettype = b.bettype

DELETE a
FROM Dep_CustBetSetting_Member a WITH(ROWLOCK) 
	INNER JOIN #Dep_CustBetSetting_Member b WITH(NOLOCK) ON a.custid = b.custid AND a.sporttype = b.sporttype AND a.bettype = b.bettype

DELETE a
FROM Dep_CustBetSettingGame_Agent a WITH(ROWLOCK) 
	INNER JOIN #Dep_CustBetSettingGame_Agent b WITH(NOLOCK) ON a.custid = b.custid AND a.sporttype = b.sporttype AND a.bettype = b.bettype

DELETE a
FROM Dep_CustBetSettingGame_Member a WITH(ROWLOCK) 
	INNER JOIN #Dep_CustBetSettingGame_Member b WITH(NOLOCK) ON a.custid = b.custid AND a.sporttype = b.sporttype AND a.bettype = b.bettype

DELETE a
FROM Dep_CustPTSetting_Agent a WITH(ROWLOCK) 
	INNER JOIN #Dep_CustPTSetting_Agent b WITH(NOLOCK) ON a.custid = b.custid AND a.sporttype = b.sporttype AND a.bettype = b.bettype

DELETE a
FROM Dep_CustPTSetting_Member a WITH(ROWLOCK) 
	INNER JOIN #Dep_CustPTSetting_Member b WITH(NOLOCK) ON a.custid = b.custid AND a.sporttype = b.sporttype AND a.bettype = b.bettype

DELETE a
FROM Dep_CustPTGroupSetting_Member  a WITH(ROWLOCK) 
	INNER JOIN #Dep_CustPTGroupSetting_Member b WITH(NOLOCK) ON a.AgentID = b.AgentID AND a.sporttype = b.sporttype AND a.bettype = b.bettype

DELETE a
FROM Dep_CustDiscountSetting_Agent a WITH(ROWLOCK) 
	INNER JOIN #Dep_CustDiscountSetting_Agent b WITH(NOLOCK) ON a.custid = b.custid AND a.sporttype = b.sporttype AND a.bettype = b.bettype

DELETE a
FROM Dep_CustDiscountSetting_Member a WITH(ROWLOCK) 
	INNER JOIN #Dep_CustDiscountSetting_Member b WITH(NOLOCK) ON a.custid = b.custid AND a.sporttype = b.sporttype AND a.bettype = b.bettype

 
DROP TABLE #Dep_CustBetSetting_Agent
DROP TABLE #Dep_CustBetSetting_Member
DROP TABLE #Dep_CustBetSettingGame_Agent
DROP TABLE #Dep_CustBetSettingGame_Member
DROP TABLE #Dep_CustDiscountSetting_Agent
DROP TABLE #Dep_CustDiscountSetting_Member
DROP TABLE #Dep_CustPTSetting_Agent
DROP TABLE #Dep_CustPTSetting_Member
DROP TABLE #Dep_CustPTGroupSetting_Member