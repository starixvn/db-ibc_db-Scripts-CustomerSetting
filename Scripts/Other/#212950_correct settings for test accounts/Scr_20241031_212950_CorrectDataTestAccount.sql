/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20241031@Eden
	Task:  [Redmine: #212950]    
	Database: DBCUST-CustDB
*/

USE CustDB
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

--Update MaxPayoutPerMatch for Sportbooks
UPDATE cs
SET cs.MaxPayoutPerMatch = cs.MaxPerMatch * 8,
	cs.RepUpdateTime = dbo.f_GetDateTime2()
FROM Dep_CustBetSettingGame_Agent cs WITH(ROWLOCK)
	INNER JOIN #Temp_Cust c ON cs.CustID = c.custID
	AND sporttype NOT IN (161,0)

UPDATE cs
SET cs.MaxPayoutPerMatch = cs.MaxPerMatch * 8,
	cs.RepUpdateTime = dbo.f_GetDateTime2()
FROM Dep_CustBetSettingGame_Member cs WITH(ROWLOCK)
	INNER JOIN #Temp_Cust c ON cs.CustID = c.custID
	AND sporttype NOT IN (161,0)

--Update Sporttype for NumberGame
UPDATE cs
SET cs.SportType = 161,
	cs.BetType = 81,
	cs.RepUpdateTime = dbo.f_GetDateTime2()
FROM Dep_CustBetSettingGame_Agent cs WITH(ROWLOCK)
	INNER JOIN #Temp_Cust c ON cs.CustID = c.custID
	AND sporttype = 0

UPDATE cs
SET cs.SportType = 161,
	cs.BetType = 81,
	cs.RepUpdateTime = dbo.f_GetDateTime2()
FROM Dep_CustBetSettingGame_Member cs WITH(ROWLOCK)
	INNER JOIN #Temp_Cust c ON cs.CustID = c.custID
	AND sporttype = 0

DROP TABLE #Temp_Cust
DROP TABLE #Temp_Super