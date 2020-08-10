/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200805
	Task:  Insert Setting StakeLevel [PG Game] - deposit RedmineID:#137763
	DB: DBCust/CustDB
*/
CREATE TABLE #Dep_StakeLevel_Temp ( GameTypeID INT,
								ExchangeId int,
								GameGroupID int default(16))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,ExchangeId)
SELECT 6001,72   UNION ALL     -- YNG
SELECT 6001,20				   -- UUS

DECLARE @MaxStakeLevelID INT
SELECT @MaxStakeLevelID = MAX(StakeLevelID) FROM DEP_StakeLevel WITH(NOLOCK)

INSERT INTO Dep_StakeLevel(GameTypeID,ExchangeId,GameGroupID,StakeLevelID)
SELECT a.GameTypeID,a.ExchangeId,a.GameGroupID,StakeLevelID = @MaxStakeLevelID + ROW_NUMBER() OVER(ORDER BY e.exchangeid) 
FROM #Dep_StakeLevel_Temp a


DROP TABLE #Dep_StakeLevel_Temp