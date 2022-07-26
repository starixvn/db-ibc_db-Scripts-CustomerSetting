/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220714
	Task:  Insert Setting StakeLevel [PP Game] - deposit RedmineID:#175454
	DB: DBCust/CustDB
*/
CREATE TABLE #Dep_StakeLevel_Temp ( GameTypeID INT,	ExchangeId INT,	GameGroupID INT DEFAULT(38))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,ExchangeId)
SELECT 4101,4   -- TB

DECLARE @MaxStakeLevelID INT
SELECT @MaxStakeLevelID = MAX(StakeLevelID) FROM DEP_StakeLevel WITH(NOLOCK)

INSERT INTO Dep_StakeLevel(GameTypeID,ExchangeId,GameGroupID,StakeLevelID)
SELECT a.GameTypeID,a.ExchangeId,a.GameGroupID,StakeLevelID = @MaxStakeLevelID + ROW_NUMBER() OVER(ORDER BY exchangeid) 
FROM #Dep_StakeLevel_Temp a


DROP TABLE #Dep_StakeLevel_Temp


