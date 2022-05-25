/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220524
	Task:  Insert Setting StakeLevel [MaxGame] UUS - deposit RedmineID:#172933
	DB: DBCust/CustDB
	P/s : Step 1 Insert Setting StakeLevel UUS
*/
CREATE TABLE #Dep_StakeLevel_Temp ( GameTypeID INT,
								ExchangeId INT,
								GameGroupID INT DEFAULT(37))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,ExchangeId)
SELECT 5401,20 UNION ALL  -- UUS
SELECT 5401,37 		      -- YNG

DELETE a
FROM #Dep_StakeLevel_Temp a
INNER JOIN Dep_StakeLevel  b WITH(NOLOCK) on a.GameTypeID = b.GameTypeID AND a.ExchangeId = b.ExchangeID
					AND a.GameGroupID = b.GameGroupID 
WHERE b.GameTypeID = 5401

DECLARE @MaxStakeLevelID INT
SELECT @MaxStakeLevelID = MAX(StakeLevelID) FROM DEP_StakeLevel WITH(NOLOCK)

INSERT INTO Dep_StakeLevel(GameTypeID,ExchangeId,GameGroupID,StakeLevelID)
SELECT a.GameTypeID,a.ExchangeId,a.GameGroupID,StakeLevelID = @MaxStakeLevelID + ROW_NUMBER() OVER(ORDER BY exchangeid) 
FROM #Dep_StakeLevel_Temp a

DROP TABLE #Dep_StakeLevel_Temp