/*
	Created: Eden
	Date: 20191029
	Task: DELETE existed setting for Virtual game CREDIT
	DB: DBCust/CustDB
*/

DECLARE @SportBettype TABLE (SportType SMALLINT, BetType SMALLINT)
INSERT INTO @SportBettype(SportType, BetType) VALUES (245, 4601)

------------------------------------PT Setting-------------------------------------------------	
SELECT a.CustID,a.SportType,a.BetType
INTO #CustPTSetting3rd_Agent
FROM CustPTSetting3rd_Agent a WITH(NOLOCK)
INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType

DELETE a
FROM CustPTSetting3rd_Agent a WITH(ROWLOCK,UPDLOCK)
INNER JOIN #CustPTSetting3rd_Agent t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

SELECT a.CustID,a.SportType,a.BetType
INTO #CustPTSetting3rd_Member
FROM CustPTSetting3rd_Member a WITH(NOLOCK)
INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType

DELETE a
FROM CustPTSetting3rd_Member a WITH(ROWLOCK,UPDLOCK)
INNER JOIN #CustPTSetting3rd_Member t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

SELECT a.AgentID,a.SportType,a.BetType
INTO #CustPTGroupSetting3rd_Member
FROM CustPTGroupSetting3rd_Member a WITH(NOLOCK)
INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType

DELETE a
FROM CustPTGroupSetting3rd_Member a WITH(ROWLOCK,UPDLOCK)
INNER JOIN #CustPTGroupSetting3rd_Member t ON a.AgentID = t.AgentID AND a.SportType = t.SportType and a.BetType = t.BetType 

----------------------------------------WinLoss Limit Setting-------------------------------------------------		
SELECT a.CustID,a.SportType,a.BetType
INTO #CustWinLossLimit_Agent
FROM CustWinLossLimit_Agent a WITH(NOLOCK)
INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType

DELETE a
FROM CustWinLossLimit_Agent a WITH(ROWLOCK,UPDLOCK)
INNER JOIN #CustWinLossLimit_Agent t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

SELECT a.CustID,a.SportType,a.BetType
INTO #CustWinLossLimit_Member
FROM CustWinLossLimit_Member a WITH(NOLOCK)
INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType

DELETE a
FROM CustWinLossLimit_Member a WITH(ROWLOCK,UPDLOCK)
INNER JOIN #CustWinLossLimit_Member t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

-------------------------------------------------STAKE LEVEL----------------------------------------------------------------
SELECT a.CustID,a.SportType,a.BetType
INTO #CustStakeLevel_Agent
FROM CustStakeLevel_Agent a WITH(NOLOCK)
INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType

DELETE a
FROM CustStakeLevel_Agent a WITH(ROWLOCK,UPDLOCK)
INNER JOIN #CustStakeLevel_Agent t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

SELECT a.CustID,a.SportType,a.BetType
INTO #CustStakeLevel_Member
FROM CustStakeLevel_Member a WITH(NOLOCK)
INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType

DELETE a
FROM CustStakeLevel_Member a WITH(ROWLOCK,UPDLOCK)
INNER JOIN #CustStakeLevel_Member t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

SELECT a.StakeLevelID,a.GameTypeID
INTO #StakeLevelGroupDetail
FROM StakeLevelGroupDetail a WITH(NOLOCK)
WHERE a.GameTypeID BETWEEN 4601 AND 4604

DELETE a
FROM StakeLevelGroupDetail a WITH(ROWLOCK,UPDLOCK)
INNER JOIN #StakeLevelGroupDetail t ON a.StakeLevelID = t.StakeLevelID AND a.GameTypeID = t.GameTypeID

DROP TABLE #CustPTGroupSetting3rd_Member
DROP TABLE #CustPTSetting3rd_Agent
DROP TABLE #CustPTSetting3rd_Member
DROP TABLE #CustStakeLevel_Agent
DROP TABLE #CustStakeLevel_Member
DROP TABLE #CustWinLossLimit_Agent
DROP TABLE #CustWinLossLimit_Member
DROP TABLE #StakeLevelGroupDetail